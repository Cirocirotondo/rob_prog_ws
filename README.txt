AUTONOMOUS NAVIGATION IN AN AWS WAREHOUSE USING REINFORCEMENT LEARNING
==============

In this project, we programmed a robot in order to make it navigate inside an AWS warehouse with the aim of reaching a target.
The path was defined using a Q-learning algorithm. To ensure accurate movement along the path, we implemented a closed-loop control system, which continuously adjusts the robot's actions based on feedback from its sensors.
Additionally, we explored the feasibility of using RFID technology for position tracking. Three RFID tags were placed around the warehouse, and the robot's position was estimated based on the signals received from these tags. This aspect of the project aimed to evaluate whether RFID-based positioning could provide reliable location data to support the robot's navigation.




## How to run the code:
Download the folder and compile using the command: 
catkin_make


### terminal l: master node
cd rob_prog_ws
source devel/setup.bash
roscore

#### terminal 2: launch the simulation
source devel/setup.bash
roslaunch rfid_simulator_test simulation.launch

#### terminal 3: RFID node
source devel/setup.bash
rosrun rfid_sensor rfid.py

#### terminal 4: Navigation Node
source devel/setup.bash
rosrun move_robot follow_waypoints.py

#### (Optional) Terminal 5: Teleop twist keyboard
source devel/setup.bash
rosrun teleop_twist_keyboard teleop_twist_keyboard.py


#### To visualize the command given to control the robot
rostopic echo /cmd_vel


### Useful Links:

AWS Warehouse: 
https://github.com/aws-robotics/aws-robomaker-small-warehouse-world

rfid_sensor:
https://github.com/SalvatoreDAvella/rfid_sensor?tab=readme-ov-file

rfid_simulator_test:
https://github.com/SalvatoreDAvella/rfid_simulator_test

PAPER:
https://ieeexplore.ieee.org/document/9715113




