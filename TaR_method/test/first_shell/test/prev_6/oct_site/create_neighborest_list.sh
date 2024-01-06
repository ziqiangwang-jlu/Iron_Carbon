#! /bin/bash

# Create neighborest lists for all selected interstitial sites
# Format: x0 y0 z0 x1 y1 z1
#         x0 y0 z0 x2 y2 z2
#         .......


start_num=1
end_num=6
step=1
for i in $(seq $start_num $step $end_num)
do
    #echo $i
    echo $i > oct_inter_$i/file_index.txt
    cd oct_inter_$i
    cp ../recombine.py .
    recombine.py
    cd ../ 
done   
