import numpy as np

Q = np.loadtxt("Q_map1.csv", delimiter=',')
print(Q)
NUM_COLS = 30

target = [39,14]
curr_pos = [0,1,6] #[0, 14, 23]

for i in range(100):
    print(f"Iterazione n.{i}")
    curr_y = curr_pos[1]
    curr_x = curr_pos[2]

    cell_index = curr_y*NUM_COLS + curr_x
    print(cell_index)
    print(f"\t{Q[cell_index]}")
    next_move = np.argmax(Q[cell_index])
    
    if next_move == 0:
        next_pos = [0, curr_y, curr_x-1, ]
    elif next_move == 1:
        next_pos = [1, curr_y+1, curr_x, ]
    elif next_move == 2:
        next_pos = [2, curr_y, curr_x+1]
    elif next_move == 3:
        next_pos = [3, curr_y-1, curr_x]

    print(f"\tcurr_pos = {curr_pos}, next_move = {next_move}, next_pos = {next_pos}")

    curr_pos = next_pos

    if curr_pos[1] == target [0] and curr_pos[2] == target [1]:
        print("Bersaglio raggiunto")
        break


print("FINE")