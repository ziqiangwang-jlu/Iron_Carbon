#! /public/home/ziqiangw/anaconda3/bin/python

import os

with open ('poslmp_carbon.dat', 'r') as file:
    for i in range(16):
        line = file.readline()
    line = file.readline()
    ls = line.split()
    x0, y0, z0 = float(ls[2]), float(ls[3]), float(ls[4])

if os.path.isfile('info.dat'):
    pass
else:
    cwd = os.getcwd()   
    with open ('../directory_ls', 'a+') as file:
        file.write(cwd+'\n')    
with open ('info.dat', 'r') as file:
    init_pos = []
    neighbor_ls = []
    temp_ls = []
    while True:
        line = file.readline()
        if len(line) == 0:
            break
        else:
            ls = line.split()
            x1, y1, z1 = float(ls[0]), float(ls[1]), float(ls[2])
            if abs(x1-x0) < 0.2 and abs(y1-y0) < 0.2 and abs(z1-z0) < 0.2:
                if len(init_pos) == 0:
                    init_pos.append([str(x1), str(y1), str(z1)])
                else:
                    pass
            else:
                if [round(x1, 1), round(y1, 1), round(z1, 1)] not in temp_ls:
                    temp_ls.append([round(x1, 1), round(y1, 1), round(z1, 1)])
                    neighbor_ls.append([str(x1), str(y1), str(z1)])

if len(init_pos) == 0:
    init_pos.append([str(x0), str(y0), str(z0)])

if os.path.exists('../neighborest_list'):
    pass
else:
    os.makedirs('../neighborest_list')    

with open ('file_index.txt', 'r') as file:
    line = file.readline()
    ls = line.split()
    index = int(ls[0])

with open ('../neighborest_list/oct_inter_'+str(index)+'.dat', 'w') as file:
    for i in range(len(neighbor_ls)):
        file.write(init_pos[0][0]+' '+init_pos[0][1]+' '+init_pos[0][2]+' '+neighbor_ls[i][0]+' '+neighbor_ls[i][1]+' '+neighbor_ls[i][2]+'\n')

