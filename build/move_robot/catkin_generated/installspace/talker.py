#!/usr/bin/env python3

'''
The position of the car is saved in this format:
    [direction, y, x]
    where:
    - direction:    {0:left; 1:down; 2:right; 3:up}
    - y,x:          coordinates of the grid cell. The cell [0,0] is the upper-left of the map

'''

import rospy
from geometry_msgs.msg import Twist
import time
import numpy as np


CYCLE_TIME = 4                      # tempo caratteristico di un ciclo
TIME_WAIT = 2                       # tempo di attesa prima e dopo una rotazione
NUM_ROWS = 46
NUM_COLS = 30
#Q = np.random.rand(NUM_ROWS*NUM_COLS, 4)
Q = np.loadtxt("Q_learning_def/Q_map_target_43_28.csv", delimiter=',')
target = [28,43]                        # [x, y]
VEL = 0.425/CYCLE_TIME                  # 0.425m is the length of the side of the square
ROT = 3.1415/2/CYCLE_TIME * 2           # the factor "*2" is due to the fact that the car turns by 45° # the constant "+0.27" has been added to avoid the problem of the robot rotating less than 90°
    
def get_next_cell(curr_pos):
    curr_dir = curr_pos[0]
    curr_x = curr_pos[2]
    curr_y = curr_pos[1]

    # get the next move using the Q table
    cell_index = curr_y*NUM_COLS + curr_x
    next_move = np.argmax(Q[cell_index])

    if next_move == 0:
        next_cell = [0, curr_y, curr_x-1 ]
    elif next_move == 1:
        next_cell = [1, curr_y+1, curr_x ]
    elif next_move == 2:
        next_cell = [2, curr_y, curr_x+1]
    elif next_move == 3:
        next_cell = [3, curr_y-1, curr_x]

    return next_cell


def move_robot():
    pub = rospy.Publisher('cmd_vel', Twist, queue_size=10) 
    rospy.init_node('move_robot', anonymous=True)
    rate = rospy.Rate(CYCLE_TIME) # hz

    twist_msg = Twist()
    twist_msg.linear.x = 0
    pub.publish(twist_msg)
    time.sleep(CYCLE_TIME)
    
    curr_pos = [0, 14, 23]          # starting position
    while not rospy.is_shutdown():
        next_pos = get_next_cell(curr_pos)
        
        rospy.loginfo(f"curr_pos = {curr_pos} ; next_pos = {next_pos}")
        
        # Give commands to the car
        if next_pos[0] == curr_pos[0]:      
            # No need to turn. Keep going straight
            twist_msg.linear.x = VEL 
            twist_msg.angular.z = 0
            pub.publish(twist_msg)
            time.sleep(CYCLE_TIME)

        elif next_pos[0] == (curr_pos[0]+1)%4:  
            # Rotate 90° to the left, then go straight
            twist_msg.linear.x = 0
            pub.publish(twist_msg)
            time.sleep(TIME_WAIT)
            twist_msg.linear.x = 0
            twist_msg.angular.z = ROT
            pub.publish(twist_msg)
            time.sleep(CYCLE_TIME)                           # In teoria sarebbe dovuto bastare 1 secondo!
            twist_msg.angular.z = 0
            pub.publish(twist_msg)
            time.sleep(TIME_WAIT)
            twist_msg.linear.x = VEL
            pub.publish(twist_msg)
            time.sleep(CYCLE_TIME)
            
        elif next_pos[0] == (curr_pos[0]-1)%4:  
            # Rotate 90° to the right, then go straight
            twist_msg.linear.x = 0
            pub.publish(twist_msg)
            time.sleep(TIME_WAIT)
            twist_msg.linear.x = 0
            twist_msg.angular.z = -ROT
            pub.publish(twist_msg)
            time.sleep(CYCLE_TIME)
            twist_msg.angular.z = 0
            pub.publish(twist_msg)
            time.sleep(TIME_WAIT)
            twist_msg.linear.x = VEL
            pub.publish(twist_msg)
            time.sleep(CYCLE_TIME)

        elif next_pos[0] == (curr_pos[0]+2)%4:  
            rospy.loginfo(f"Rotate 180°")
            # Rotate 180° to the left, then go straight --> theoretically, this should never happen. I add the function just for being sure
            twist_msg.linear.x = 0
            pub.publish(twist_msg)
            time.sleep(TIME_WAIT)
            rospy.loginfo(f"go")
            twist_msg.linear.x = 0
            twist_msg.angular.z = ROT
            pub.publish(twist_msg)
            time.sleep(2*CYCLE_TIME)
            '''
            # 2a rotazione di 90°
            twist_msg.linear.x = 0
            pub.publish(twist_msg)
            time.sleep(TIME_WAIT)
            rospy.loginfo(f"go")
            twist_msg.linear.x = 0
            twist_msg.angular.z = ROT
            pub.publish(twist_msg)
            time.sleep(CYCLE_TIME)
            '''
            rospy.loginfo(f"stop")
            twist_msg.angular.z = 0
            pub.publish(twist_msg)
            time.sleep(TIME_WAIT)
            twist_msg.linear.x = VEL
            pub.publish(twist_msg)
            time.sleep(CYCLE_TIME)
            rospy.loginfo(f"End rotate 180°")

        
        curr_pos = next_pos

        if curr_pos[1:3] == target:
            rospy.loginfo("OBIETTIVO RAGGIUNTO !!!")
            
        rate.sleep()
    
    

if __name__ == '__main__':
    try:
        move_robot()
    except rospy.ROSInterruptException:
        pass





'''
# DEFAULT PUBLISHER:

import rospy
from std_msgs.msg import String

def talker():
    pub = rospy.Publisher('chatter', String, queue_size=10)
    rospy.init_node('talker', anonymous=True)
    rate = rospy.Rate(10) # 10hz
    while not rospy.is_shutdown():
        hello_str = "hello world %s" % rospy.get_time()
        rospy.loginfo(hello_str)
        pub.publish(hello_str)
        rate.sleep()

if __name__ == '__main__':
    try:
        talker()
    except rospy.ROSInterruptException:
        pass
'''