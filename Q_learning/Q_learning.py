import numpy as np
import random
import map
import math
import pandas as pd
import matplotlib.pyplot as plt


# parametri tabella
dimrow = 30  # numero colonne (dimensione di una riga)
dimcol = 46  # numero righe (dimensioni di una colonna)

env = map.matrice

# definizione azioni
actions = [0,1,2,3] # left down right up


# target position
tpos = (37,24) #(nell'ordine coordinata y  e x)

# Definizone tabella Q
# Ordine delle celle prima riga 0 colonna 0,1,2,3,4... ,riga 1 colonna 0,1,2,3,4 riga 2 ecc...
q_table = np.zeros((dimrow * dimcol, len(actions)))

# learning parameters
num_iter = 1000000
learning_rate = 0.01
discount_rate = 0.5
exp_rate = 1.0
# max_exp_rate = 1.0
# min_exp_rate = 0.001
# exp_deg = 0.0001
max_iter_episode = 80

# calcolo posizione successiva
def next_step(cur_pos, action):
    col = cur_pos[0]
    row = cur_pos[1]
    uscita = 0 # se esce dall'ambiente metto uscita = 1, in questo modo posso gestire i reward senza errori di indici
    if action == 0 and row > 0:
        row -= 1
    elif action == 1 and col < (dimcol-1):
        col += 1
    elif action == 2 and row < (dimrow-1):
        row += 1
    elif action == 3 and col > 0:
        col -= 1
    else:
        uscita = 1
    return col, row, uscita

# calcolo cella iniziale casuale, tale per cui sia una cella non ostacolo
def get_initial_state():
    start_x = np.random.randint(dimrow)
    start_y = np.random.randint(dimcol)
    while env[start_y,start_x] != 0:
        start_x = np.random.randint(dimrow)
        start_y = np.random.randint(dimcol)
    return start_y, start_x

#calcolo reward medio, inutile ai fini del programma
mean_reward_1000 = 0
###
for episode in range(num_iter):
    # Inizializzazione dello stato di partenza
    a_pos = get_initial_state()
    finish = False
    num_steps = 0
    reward_iter = 0
    while not finish:
        num_steps += 1
        
        # Scelta dell'azione
        if random.uniform(0, 1) < exp_rate:
            action = random.choice(list(actions))  # Scelta casuale
        else:
            action_index = np.argmax(q_table[a_pos[0] * dimrow + a_pos[1], :]) # faccio mossa più conveniente
            action = actions[action_index]

        #calcolo nuova posizione
        next_state = next_step(a_pos, int(action))

        #controllo in che tipo di casella finisco e trovo reward corrispondente
        if next_state[2] == 1: # sono uscito dall'ambiente
            reward = -50
        elif env[next_state[0],next_state[1]] == 1: # ostacolo
            reward = -50
        elif next_state[0] == tpos[0] and next_state[1] == tpos[1]: # arrivato all'obiettivo
            reward = 100
        else:               #casella libera (il reward negativo penalizza percorsi lunghi)
            reward = -1

        #calcolo costo della mossa data casella di partenza, se esco metto un costo brutto brutto
        if next_state[2] == 1:
            q_table[a_pos[0] * dimrow + a_pos[1], action] = ((1 - learning_rate) * q_table[a_pos[0] * dimrow + a_pos[1], action]) + \
            learning_rate * (reward + discount_rate * (-100))
            finish = True
        else:
            q_table[a_pos[0] * dimrow + a_pos[1], action] = ((1 - learning_rate) * q_table[a_pos[0] * dimrow + a_pos[1], action]) +\
            learning_rate * (reward + discount_rate * np.max(q_table[next_state[0] * dimrow + next_state[1], :]))
            a_pos = next_state

         # Controllo se l'episodio è terminato

        if (a_pos[0] == tpos[0] and a_pos[1] == tpos[1]) or (env[a_pos[0],a_pos[1]] == 1):
            finish = True

        # controllo se ho messo troppe mosse
        if num_steps >= max_iter_episode:
            finish = True

        reward_iter += reward
    ##

    mean_reward_1000 += reward_iter
    
    if episode % 1000 == 0:
        #print(exp_rate)
        print(f"Episodes: {episode}, average reward: {mean_reward_1000/1000}")
        mean_reward_1000 = 0
    # Riduzione del tasso di esplorazione
    #exp_rate = min_exp_rate + (max_exp_rate - min_exp_rate) * np.exp(-exp_deg * episode)
    exp_rate = np.exp(-10 * episode/num_iter)

final_map = np.empty((dimcol, dimrow), dtype=np.str_)

for k in range(dimrow * dimcol):
    act = np.argmax(q_table[k,:])
    if env[math.trunc(k/dimrow),k - (dimrow * math.trunc(k/dimrow)) ] == 1:
        final_map[math.trunc(k / dimrow), k - (dimrow * math.trunc(k / dimrow))] = '■'
    elif (math.trunc(k/dimrow) == tpos[0] and k - (dimrow * math.trunc(k / dimrow)) == tpos[1]):
        final_map[math.trunc(k / dimrow), k - (dimrow * math.trunc(k / dimrow))] = '□'
    elif act == 0:
        final_map[math.trunc(k/dimrow),k - (dimrow * math.trunc(k/dimrow)) ] = '\N{LEFTWARDS ARROW}'
    elif act == 1:
        final_map[math.trunc(k/dimrow), k - (dimrow * math.trunc(k/dimrow))] = '\N{DOWNWARDS ARROW}'
    elif act == 2:
        final_map[math.trunc(k/dimrow), k - (dimrow * math.trunc(k/dimrow))] = '\N{RIGHTWARDS ARROW}'
    else:
        final_map[math.trunc(k/dimrow), k - (dimrow * math.trunc(k/dimrow))] = '\N{UPWARDS ARROW}'

#df = pd.DataFrame(final_map)
#df.to_excel('final_map.xlsx', index=False)

# Creazione del grafico della tabella utilizzando matplotlib
fig, ax = plt.subplots(figsize=(6, 8))
ax.axis('off')
table = ax.table(cellText=final_map, loc='center')

# Salvataggio del grafico della tabella come immagine
plt.savefig('mappa_final.png')

print(q_table)
print(final_map)
np.savetxt('Q_learning_def/Q_map1.csv', q_table, delimiter=',')