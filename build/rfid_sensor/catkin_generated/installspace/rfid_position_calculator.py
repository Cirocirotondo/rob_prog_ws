#!/usr/bin/env python3
'''
This script creates a listener for rfid messages.
When a message is received, this script computes the positioin 
and publishes it on the topic "rfid_position"
'''


import rospy
import numpy as np
from std_msgs.msg import String
from geometry_msgs.msg import Point
from rfid_sensor.msg import TagArray, Tag

rospy.loginfo("RDIF POSITION CALCULATOR \nWaiting for messages from the antenna...")

RSSI = 15.6
pow_0_rfid = np.zeros((1,3))
freq = 865.7 * 10**6
RFID_POSITIONS = np.array([[-1, 0], [3, 4], [0, -2]])
distances = np.array([1, 5, 2])
rospy.loginfo("AAAAAA...")


# data RSSI e pow_0 potenza in prossimità del RFID tag trova distanza
def dist_calc(power, pow_0, f):
    lamb = (3*10**8) / f
    distance = (lamb/(4 * np.pi))*(np.exp((pow_0 - power)/20))
    return distance

# da fare all'inizio del ciclo: trova la potenza pow_0 in prossimità del RFID
# da chiamare una volta per ogni RFID tag utilizzato
# x_0, y_0 è posizione iniziale del robot nota, pow è la potenza letta RSSI
def calib(x_rfid, y_rfid, x_0, y_0, pow, f):
    d = np.sqrt(((x_rfid-x_0)**2) + ((y_rfid-y_0)**2))
    p_init = pow + 20 * np.log(4*np.pi*d/((3*10**8) / f))
    return p_init


#date coordinate dei tre rfid tag e distanze rilevate trova posizione antenna
def triangolazione(RFID_pos, d):
    x1, y1 = RFID_pos[0]
    x2, y2 = RFID_pos[1]
    x3, y3 = RFID_pos[2]

    # Estraiamo le distanze note
    d1, d2, d3 = d

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
def calc_pos(RFID_position, pow_0_rfid, det_pow, freq_enza):
    d1 = dist_calc(det_pow[0], pow_0_rfid[0], freq_enza)
    d2 = dist_calc(det_pow[1], pow_0_rfid[1], freq_enza)
    d3 = dist_calc(det_pow[2], pow_0_rfid[2], freq_enza)
    return triangolazione(RFID_position, [d1, d2, d3])

def callback(data):
    rospy.loginfo(rospy.get_caller_id() + "I heard %s", data.data)
    det_pow = np.array([1, 2, 3])
    if pow_0_rfid[0] == 0:
        pow_0_rfid[0] = calib(RFID_POSITIONS[0][0], RFID_POSITIONS[0][1], 0, 0, det_pow[0], freq)
        pow_0_rfid[1] = calib(RFID_POSITIONS[1][0], RFID_POSITIONS[1][1], 0, 0, det_pow[1], freq)
        pow_0_rfid[2] = calib(RFID_POSITIONS[2][0], RFID_POSITIONS[2][1], 0, 0, det_pow[2], freq)
        rospy.loginfo("CALIBRATION COMPLETED!")

    if pow_0_rfid[0] != 0:
        x,y = calc_pos(RFID_POSITIONS, pow_0_rfid, det_pow, freq)
        rospy.loginfo(f"ESTIMATED POSITION: x = {x}, y = {y}")
        position = Point()
        position.x = x
        position.y = y
        pub = rospy.Publisher('rfid_position', Point, queue_size=10)
        pub.publish(position)
        

def listener():
    rospy.init_node('rfid_pos_calc', anonymous=True)
    rospy.Subscriber("antenna_message", String, callback)
    rospy.spin()

if __name__ == '__main__':
    rospy.loginfo("RDIF POSITION CALCULATOR \nWaiting for messages from the antenna...")
    listener()