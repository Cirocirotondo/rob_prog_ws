Link utili:

AWS Warehouse: 
https://github.com/aws-robotics/aws-robomaker-small-warehouse-world

rfid_sensor:
https://github.com/SalvatoreDAvella/rfid_sensor?tab=readme-ov-file

rfid_simulator_test:
https://github.com/SalvatoreDAvella/rfid_simulator_test

PAPER:
https://ieeexplore.ieee.org/document/9715113

------- STRUTTURA CARTELLA --------
Q_learning e Q_learning_def contengono i file per creare la Q-table.
Dentro la cartella src ci sono 3 pacchetti: uno 

------- COMANDI:  -------
# compilare
catkin_make


open in terminal the workspace
source devel/setup.bash
roscore
# nuovo terminale
source devel/setup.bash
roslaunch rfid_simulator_test simulation.launch

## per aprire il teleop twist keyboard
# nuovo terminale
source devel/setup.bash
rosrun teleop_twist_keyboard teleop_twist_keyboard.py

## per lanciare il nostro programma
# nuovo terminale
source devel/setup.bash
rosrun move_robot talker.py

## visualizzare il topic con i comandi in velocità
rostopic echo /cmd_vel






