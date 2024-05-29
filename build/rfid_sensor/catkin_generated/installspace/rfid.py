#!/usr/bin/env python3

import rospy
import numpy as np
from math import sqrt

from std_msgs.msg import Float32
from rfid_sensor.msg import Tag, TagArray
from geometry_msgs.msg import Point
from gazebo_msgs.msg import ModelStates
from std_msgs.msg import Empty

import matplotlib.pyplot as plt


'''
TAG USED: tag2, tag3, tag9 
- Tag1:
    position: 
      x: 2.9
      y: 0.57
      z: 2.05
    orientation: 
      x: 0.0
      y: 0.0
      z: 0.0
      w: 1.0

- Tag2:
    position: 
      x: 2.9
      y: -1.24
      z: 2.05
    orientation: 
      x: 0.0
      y: 0.0c
      z: 0.0
      w: 1.0

- Tag3:
    position: 
      x: 2.9
      y: -3.03 --> 4
      z: 2.05
    orientation: 
      x: 0.0
      y: 0.0
      z: 0.0
      w: 1.0

- Tag9:
    position: 
      x: -4.85
      y: 1.44  --> 5.5
      z: 2.05
    orientation: 
      x: 0.0
      y: 0.0
      z: 0.0
      w: 1.0

'''

# GLOBAL CONSTANTS
LIGHT_SPEED     = 299792458
FREQ            = 865.7 * 10**6
LAMBDA          = LIGHT_SPEED / FREQ
COMM_GAIN       = 3 # 250   # communication gain
PI              = 3.14159265358979323846
RFID_POSITIONS  = np.array([[2.9, -1.24, 2.05], [2.9, 4, 2.05], [-4.85, 1.44, 2.05]])
ANTENNA_Z       = 2.05 # 1.5
ROBOT_START_POS_X = 0
ROBOT_START_POS_Y = 0
IMAGE_PATH = "trajectories.png"
MAX_COUNTER = 25000 # 2500

# global vectors for storing the positions
real_positions = []
estimated_positions = []




class MovingAverage:
    def __init__(self, window_size):
        self.window_size = window_size
        self.x_values = []
        self.y_values = []

    def add_value(self, new_x, new_y):
        self.x_values.append(new_x)
        self.y_values.append(new_y)
        if len(self.x_values) > self.window_size:
            self.x_values.pop(0)
            self.y_values.pop(0)

    def get_average(self):
        if not self.x_values:
            return None
        x_average = sum(self.x_values) / len(self.x_values)
        y_average = sum(self.y_values) / len(self.y_values)
        return x_average, y_average 




class RFID_position:
    def __init__(self):
        rospy.init_node('rfid_node', anonymous=True)

        self.first_tag_message = True               # Variabile booleana che innesca la calibrazione dei sensori  
        self.pow_0_rfid = np.zeros(3)               # Valore per la calibrazione dei sensori
        self.det_pow = np.zeros(3)                  # Valore di potenza ricevuto
        self.mean_pos = MovingAverage(50)          
        
        self.rob_x = 0
        self.rob_y = 0

        self.counter = 0             # counter for displaying the trajectory only once in a while

        # Subscriber to the topic publishing data received from RFIDs
        rospy.Subscriber('/gazebo/antenna1_robot/data', TagArray, self.sensor_distances_callback)
        # Subscriber to the model states topic
        rospy.Subscriber('/gazebo/model_states', ModelStates, self.model_states_callback)
        # Subscriber to the target_reached topic
        rospy.Subscriber('/target_reached', Empty, self.target_reached_callback)
        # Publisher for publishing the RFID position
        self.rfid_position_pub = rospy.Publisher('rfid_position', Point, queue_size=10)

    # da fare all'inizio del ciclo: trova la potenza pow_0 in prossimità del RFID
    # da chiamare una volta per ogni RFID tag utilizzato
    # x_0, y_0 è posizione iniziale del robot nota, pow è la potenza letta RSSI
    def calib(self, x_rfid, y_rfid, pow):
        x_0 = ROBOT_START_POS_X
        y_0 = ROBOT_START_POS_Y
        d = np.sqrt(((x_rfid-x_0)**2) + ((y_rfid-y_0)**2))
        p_init = pow + 20 * np.log(4*np.pi*d/((3*10**8) / FREQ))
        return p_init

    # data RSSI e pow_0 potenza in prossimità del RFID tag trova distanza
    '''
    def dist_calc(self, power, pow_0):
        lamb = (3*10**8) / FREQ
        distance = (lamb/(4 * np.pi))*(np.exp((pow_0 - power)/20))
        return distance
    '''
    def dist_calc(self, rssi):
        dist = COMM_GAIN * LAMBDA / (4* PI * 10**(rssi/40))
        return dist
    
    def real_dist_calc(self):
        d1 = sqrt( (self.rob_x - RFID_POSITIONS[0][0])**2 + (self.rob_y - RFID_POSITIONS[0][1])**2)
        d2 = sqrt( (self.rob_x - RFID_POSITIONS[1][0])**2 + (self.rob_y - RFID_POSITIONS[1][1])**2)
        d3 = sqrt( (self.rob_x - RFID_POSITIONS[2][0])**2 + (self.rob_y - RFID_POSITIONS[2][1])**2)
        return d1,d2,d3

    
    
    
    #date coordinate dei tre rfid tag e distanze rilevate trova posizione antenna
    def triangolazione(self, d):
        x1, y1 = RFID_POSITIONS[0][0:2]
        x2, y2 = RFID_POSITIONS[1][0:2]
        x3, y3 = RFID_POSITIONS[2][0:2]

        # Estraiamo le distanze note
        d1, d2, d3 = d
        print(f"\n\tESTIMATED distances: {d1}, \t{d2}, \t{d3}")

        dr1, dr2, dr3 = self.real_dist_calc()
        print(f"\tREAL distances:      {dr1}, \t{dr2}, \t{dr3}")


        A = 2 * x2 - 2 * x1
        B = 2 * y2 - 2 * y1
        C = d1**2 - d2**2 - x1**2 + x2**2 - y1**2 + y2**2
        D = 2 * x3 - 2 * x2
        E = 2 * y3 - 2 * y2
        F = d2**2 - d3**2 - x2**2 + x3**2 - y2**2 + y3**2
        x = (C * E - F * B) / (E * A - B * D)
        y = (C * D - A * F) / (B * D - A * E)
        return x, y

    # funzione complessiva, chiama le altre funzioni e da chiamare a ogni ciclo per trovare la posizione antenna in real time
    def calc_pos(self):
        d1 = self.dist_calc(self.det_pow[0])
        d2 = self.dist_calc(self.det_pow[1])
        d3 = self.dist_calc(self.det_pow[2])

        # z-correction to bring to 2D
        d1 = sqrt(d1**2 - (RFID_POSITIONS[0][2] - ANTENNA_Z)**2)
        d2 = sqrt(d2**2 - (RFID_POSITIONS[1][2] - ANTENNA_Z)**2)
        d3 = sqrt(d3**2 - (RFID_POSITIONS[2][2] - ANTENNA_Z)**2)

        variab = self.triangolazione([d1, d2, d3])

        print(f"\trssi1: {self.det_pow[0]}, rssi2: {self.det_pow[1]}, rssi3: {self.det_pow[2]}, triangolaz: {variab}\n")
        return variab
    

    def sensor_distances_callback(self, msg):
        tags = TagArray()
        tags = msg.tags
        # Find the indexes of the tags (they can change from message to message)
        for idx, element in enumerate(msg.tags):
            # Check if the "name" field contains "tag2" or "tag3" or "tag9"
            if "tag2" in element.name:
                self.det_pow[0] = element.rssi
            elif "tag3" in element.name:
                self.det_pow[1] = element.rssi
            elif "tag9" in element.name:
                self.det_pow[2] = element.rssi

        if self.first_tag_message:
            if self.det_pow[0] != 0 and self.det_pow[1] != 0 and self.det_pow[2] != 0:
                self.first_tag_message = False
                self.pow_0_rfid[0] = self.calib(RFID_POSITIONS[0][0], RFID_POSITIONS[0][1], self.det_pow[0])
                self.pow_0_rfid[1] = self.calib(RFID_POSITIONS[1][0], RFID_POSITIONS[1][1], self.det_pow[1])
                self.pow_0_rfid[2] = self.calib(RFID_POSITIONS[2][0], RFID_POSITIONS[2][1], self.det_pow[2])
                rospy.loginfo("CALIBRATION COMPLETED!")

        else:
            # get new position
            x,y = self.calc_pos()
            # insert it in the moving average
            self.mean_pos.add_value(x,y)
            x,y = self.mean_pos.get_average()

            rospy.loginfo(f"\n\tESTIMATED POSITION: x = {x},  \ty = {y} \n\tREAL POSITION:      x = {self.rob_x}, \ty = {self.rob_y}\n\tCounter: {self.counter}")
            position = Point()
            position.x = x
            position.y = y
            # Publish the position
            self.rfid_position_pub.publish(position)
            estimated_positions.append((x, y))
            real_positions.append((self.rob_x, self.rob_y))

            
            self.counter += 1
            if self.counter >= MAX_COUNTER:
                self.counter = 0
                self.plot_trajectories()

        
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
        self.rob_x = model_position.x
        self.rob_y = model_position.y

    def target_reached_callback(self, msg):
        self.plot_trajectories()


    def calculate_error(self, actual, estimated):
        error = np.sqrt((actual[0] - estimated[0])**2 + (actual[1] - estimated[1])**2)
        return error

    def plot_trajectories(self):
        if len(real_positions) == 0 or len(estimated_positions) == 0:
            return
    
        fig, ax = plt.subplots()
        actual_x, actual_y = zip(*real_positions)
        estimated_x, estimated_y = zip(*estimated_positions)

        ax.plot(actual_x, actual_y, label='Real Trajectory')
        ax.plot(estimated_x, estimated_y, label='Estimated Trajectory')

        # Calculate and plot error
        errors = [self.calculate_error(actual, estimated) for actual, estimated in zip(real_positions, estimated_positions)]
        ax.set_title(f'Mean Error: {np.mean(errors):.2f}')

        ax.legend()
        plt.show()

        # Save the plot
        plt.savefig(IMAGE_PATH)
        rospy.loginfo(f"Plot saved to {IMAGE_PATH}")
        plt.close(fig)

if __name__ == '__main__':
    print("Node: RFID")
    try:
        distance_calculator_node = RFID_position()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass
