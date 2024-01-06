#! /bin/bash

filename='interstitials_sites_new.txt'
n=0
delay=5
while read line; do
    IFS=' '
    read -a strarr <<< "$line"
    if [ ${#strarr[@]} -eq 0 ]
        then 
            exit 0
        else
            x=${strarr[0]}
            y=${strarr[1]}
            z=${strarr[2]}
            n=$((n+1))
            sed "3s/288750/288751/1" poslmp_init.dat > poslmp_carbon.dat
            sed -i 's/1 atom types/2 atom types/1' poslmp_carbon.dat
            sed -i '12a 2 12.01' poslmp_carbon.dat
            sed -i "16a 288751 2 $x $y $z 0 0 0" poslmp_carbon.dat
            qsub lammps.pbs | xargs echo > job_id.txt
            job_id=$(cut -f 1 -d "." job_id.txt)
            sleep ${delay}
            while [ ! -f "minimize.e${job_id}" ]
            do
                #echo "Waiting for one second"
                sleep 1
            done
            mkdir oct_inter_$n
            mv log.* minimize* initial_sites.dat poslmp_carbon.dat oct_inter_$n
    fi
done < $filename






