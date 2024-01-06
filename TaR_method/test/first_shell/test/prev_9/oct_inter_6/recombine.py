#! /public/home/ziqiangw/anaconda3/bin/python

import os
from math import *

with open ('start_site.dat', 'r') as file:
    #for i in range(16):
    #    line = file.readline()
    line = file.readline()
    ls = line.split()
    ls = [float(value) for value in ls]
    x0, y0, z0 = ls

with open ('end_site.dat', 'r') as file:
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
            if sqrt(pow((x1-x0),2)+pow((y1-y0),2)+pow((z1-z0),2)) < 1.0:
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

