#! /bin/bash


for i in {1086..1204}
do
    echo $i > oct_inter_$i/file_index.txt
    cd oct_inter_$i
    cp ../recombine.py .
    recombine.py
    cd ../ 
done   
