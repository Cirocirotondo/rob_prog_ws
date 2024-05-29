#!/usr/bin/env python3

import rospy
from geometry_msgs.msg import Twist, Point
# from nav_msgs.msg import Odometry
from tf.transformations import euler_from_quaternion
from gazebo_msgs.msg import ModelStates
from std_msgs.msg import Empty
import math
import numpy as np
import time

#------------------------------------------------------------
# GRID: 30 columns, 46 rows
# NOTE: the coordinates are in the format (x,y), but the 
#       target is in the format (y,x)
#------------------------------------------------------------

# COSTANTS
PI = 3.14159265
K_DIST = 0.5    
K_ANGLE = 0.2
ACCURACY = 0.30
CELL_LENGTH = 0.435
NUM_COLS = 30
BORDER_X_MIN = 6.50         # x-coordinate of the left border
BORDER_X_MAX = -6.50        # x-coordinate of the right border
BORDER_Y_MIN = -9.82        # y-coordinate of the left border
BORDER_Y_MAX = 9.82         # y-coordinate of the right border
TARGET = (31,24)            # cell_y, cell_x
Q_TABLE_PATH = "Q_learning/Q_map_target_37_24.csv"
ANGLE_ERR_MAX = 0.1

#------------------------------------------------------------
# FROM_POS_TO_CELL: go from world coordinates to grid cell
#------------------------------------------------------------
def from_pos_to_cell(pos_x, pos_y):
    x = int((BORDER_X_MIN - pos_x) / CELL_LENGTH)
    y = int((pos_y - BORDER_Y_MIN) / CELL_LENGTH)
    return x,y

#------------------------------------------------------------
# FROM_CELL_TO_POS: fo from grid cell to world coordinates
#------------------------------------------------------------
def from_cell_to_pos(x,y):
    pos_x = BORDER_X_MIN - CELL_LENGTH*x - CELL_LENGTH/2
    pos_y = BORDER_Y_MIN + CELL_LENGTH*y + CELL_LENGTH/2
    return pos_x, pos_y


#------------------------------------------------------------
# WAYPOINT_LIST: fifo queue for storing the waypoints
#------------------------------------------------------------
class waypoint_list:   
    def __init__(self):
        self.arr = []
        self.arr_cell = []
        # rospy.loginfo("STACK POPULATED")
        # rospy.loginfo(self.stack)

    def size(self):
        return len(self.arr)
    
    def push(self, waypoint):
        self.arr.append(waypoint)

    def push_cell(self, waypoint):
        self.arr_cell.append(waypoint)
    
    def pop(self):
        if self.size() > 0:
            self.arr_cell.pop(0)
            return self.arr.pop(0)
        else:
            raise IndexError("Waypoint Array is empty")
    
    
    def peek(self):  # Returns the topmost waypoint from the stack without removing it.
        if self.size() > 0:
            return self.arr[0]
        else:
            raise IndexError("Waypoint Array is empty")
        
    def peek_cell(self):  # Returns the topmost waypoint from the stack without removing it.
        if self.size() > 0:
            return self.arr_cell[0]
        else:
            raise IndexError("Waypoint Array is empty")

    def is_empty(self):
        return len(self.arr) == 0
    
    def print(self):
        rospy.loginfo(f"Waypoints (world coordinates) = {self.arr}\n")

    def print_cell(self):
        rospy.loginfo(f"Waypoints (cell coordinates) = {self.arr_cell}\n")
        

#------------------------------------------------------------
# WAYPOINT_NAVIGATOR: fifo queue for storing the waypoints
#------------------------------------------------------------
class waypoint_navigator:
    def __init__(self):
        rospy.loginfo("STARTING NODE MOVE_ROBOT")
        rospy.init_node('waypoint_navigator')

        # Define waypoints
        self.waypoints = waypoint_list()
        
        # Current position
        self.curr_pos_x = 0
        self.curr_pos_y = 0
        self.curr_ang_x = 0
        self.curr_ang_y = 0
        self.curr_ang_z = 0

        self.first_position_message = True          # variable that makes the robot wait until the first position message is received

        # Subscribe to gazebo "model_states" topic to get current position
        rospy.Subscriber('/gazebo/model_states', ModelStates, self.model_states_callback)
        #rospy.Subscriber('/odom', Odometry, self.odometry_callback)

        # Publisher for velocity commands
        self.velocity_pub = rospy.Publisher('/cmd_vel', Twist, queue_size=10)
        self.finished_pub = rospy.Publisher('/target_reached', Empty, queue_size=10)


        # Rate for the control loop
        self.rate = rospy.Rate(10)

    def model_states_callback(self, msg):
        # Get the index of the robot
        try:
            model_index = msg.name.index("pioneer3at_robot")
        except ValueError:
            rospy.logerr("Model not found in model states message")
            return

        # Get the position of the model
        model_position = msg.pose[model_index].position
        #rospy.loginfo("Position of the robot: x={}, y={}, z={}".format(model_position.x, model_position.y, model_position.z))
        self.curr_pos_x = model_position.x
        self.curr_pos_y = model_position.y

        # Get the orientation of the model and convert it to Euler angles
        model_orientation = msg.pose[model_index].orientation
        (roll, pitch, yaw) = euler_from_quaternion([model_orientation.x, model_orientation.y, model_orientation.z, model_orientation.w])
        self.curr_ang_x = roll
        self.curr_ang_y = pitch
        if yaw > PI:
            yaw = yaw - 2*PI
        self.curr_ang_z = yaw

        if self.first_position_message:
            self.first_position_message = False
            self.populate_waypoint_list()

    def rfid_callback(self,msg):
        print("hey")


    # def odometry_callback(self, msg):
    #     self.current_position.x = msg.pose.pose.position.x
    #     self.current_position.y = msg.pose.pose.position.y

    def populate_waypoint_list(self):
        Q = np.loadtxt(Q_TABLE_PATH, delimiter=',')
        (x,y) = from_pos_to_cell(self.curr_pos_x, self.curr_pos_y)
        
        count = 0
        while (y,x) != TARGET:
            cell_index = y*NUM_COLS + x
            next_move = np.argmax(Q[cell_index])
            if next_move == 0:
                next_x = x-1
                next_y = y
            elif next_move == 1:
                next_x = x
                next_y = y+1
            elif next_move == 2:
                next_x = x+1
                next_y = y
            elif next_move == 3:
                next_x = x
                next_y = y-1
            x_pos, y_pos = from_cell_to_pos(next_x, next_y)
            self.waypoints.push((x_pos, y_pos))
            self.waypoints.push_cell((next_x, next_y))

            x = next_x
            y = next_y
            
            count += 1
            if count > 100:
                rospy.logerr("PATH TO TARGET NOT FOUND!")
                quit()

        self.waypoints.print_cell()
        self.waypoints.print()

    def navigate(self):
        while self.first_position_message:
            rospy.loginfo("Waiting for first position message")
            time.sleep(0.3)

        
        while not rospy.is_shutdown():
            # Calculate direction to next waypoint
            next_waypoint = self.waypoints.peek()
            next_waypoint_cell = self.waypoints.peek_cell()

            rospy.loginfo("\n\nNext waypoint_cell = {},\t\tNext Waypoint = {} \nCurrent Cell = {} \t\t Current position: x= {} \t\t y={}".format(
                next_waypoint_cell, next_waypoint, from_pos_to_cell(self.curr_pos_x, self.curr_pos_y), self.curr_pos_x, self.curr_pos_y))
            dx = next_waypoint[0] - self.curr_pos_x
            dy = next_waypoint[1] - self.curr_pos_y
            linear_velocity, angular_velocity = self.compute_velocity(dx, dy)

            # Publish velocity commands
            cmd_vel = Twist()
            cmd_vel.linear.x = linear_velocity
            cmd_vel.angular.z = angular_velocity
            self.velocity_pub.publish(cmd_vel)

            # Check if waypoint reached
            #if math.sqrt(dx**2 + dy**2) < ACCURACY:
            if from_pos_to_cell(self.curr_pos_x, self.curr_pos_y) == next_waypoint_cell:
                print("\n\n\nWAYPOINT REACHED!!!\n\n\n")
                self.waypoints.pop()
                if self.waypoints.is_empty():
                    break

            self.rate.sleep()

        rospy.loginfo("TARGET REACHED!")
        cmd_vel = Twist()           # stop the robot
        self.velocity_pub.publish(cmd_vel)

        # communicate that the robot has reached the target
        empty_msg = Empty()
        self.finished_pub.publish(empty_msg)




    def compute_velocity(self, dx, dy):
        angle_to_waypoint = math.atan2(dy,dx)

        # Calculate angular velocity
        angle_err = angle_to_waypoint - self.curr_ang_z
        if angle_err > PI:
            angle_err -= 2*PI
        elif angle_err < -PI:
            angle_err += 2*PI
        angular_velocity = K_ANGLE * angle_err
        if abs(angular_velocity) < 0.01:
            angular_velocity = 0

        # Calculate linear velocity
        distance_to_waypoint = math.sqrt(dx**2 + dy**2)
        linear_velocity = K_DIST * min(0.5, distance_to_waypoint)
        if abs(linear_velocity) < 0.01 or abs(angle_err) > ANGLE_ERR_MAX:
            linear_velocity = 0
        

        print("Parameters: \n\t\tdx={}, \n\t\tdy={}, \n\t\tlinear_velocity = {}, \n\t\tangle_to_waypoint = {}, \n\t\trobot_angle = {},\n\t\tangle_err = {}, \n\t\tangular_velocity = {}".format(dx, dy, linear_velocity, angle_to_waypoint, self.curr_ang_z , angle_err, angular_velocity))
        return linear_velocity, angular_velocity

if __name__ == '__main__':

    navigator = waypoint_navigator()
    rospy.loginfo("Starting navigation")

    navigator.navigate()