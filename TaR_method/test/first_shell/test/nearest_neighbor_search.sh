#! /bin/bash

filename='interstitial_sites.txt'
n=0
delay=10
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
            tot_before=$(awk 'NR==3 {print $1}' poslmp_init.dat)
            tot_after=$(($tot_before+1))
            carbon_mass=12.01
            sed "3s/$tot_before/$tot_after/1" poslmp_init.dat > poslmp_carbon.dat
            sed -i 's/1 atom types/2 atom types/1' poslmp_carbon.dat
            sed -i "13a 2 $carbon_mass" poslmp_carbon.dat
            sed -i "17a $tot_after 2 $x $y $z 0 0 0" poslmp_carbon.dat
            qsub lammps.pbs | xargs echo > job_id.txt
            job_id=$(cut -f 1 -d "." job_id.txt)
            sleep ${delay}m
            while [ ! -f "minimize.e${job_id}" ]
            do
                #echo "Wait for one minute"
                sleep 1m
            done
            mkdir oct_inter_$n
            mv log.* minimize* end_site.dat start_site.dat oct_inter_$n
    fi
done < $filename
rm -f job_id.txt poslmp_carbon.dat

#Create nearest neighbor list
rm -rf neighborest_list
create_neighbor_list.sh




