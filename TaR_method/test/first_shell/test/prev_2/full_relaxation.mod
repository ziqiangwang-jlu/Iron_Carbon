
clear
units                   metal
atom_style              atomic
dimension                   3
boundary                p p p
atom_modify             map array sort 0 0.0

read_data               poslmp_carbon.dat

variable                zmax     equal    zhi
variable                zmin     equal    zlo

region                  inner   cylinder   z  1.16564  0.67298333  100.0  ${zmin}  ${zmax}  units  box
group                   inner   region     inner
group                   outer   subtract   all  inner

pair_style              eam/alloy
pair_coeff              * * FeC-Becquart2013.eam.txt Fe C
neighbor                0.3 bin
neigh_modify            delay 0 check yes every 1

variable                x_saddle       equal     ${x_new}+${back_delta}*${unitx}
variable                y_saddle       equal     ${y_new}+${back_delta}*${unity}
variable                z_saddle       equal     ${z_new}+${back_delta}*${unitz}

set                     atom       $i     x   ${x_saddle}  y  ${y_saddle}  z   ${z_saddle}
fix                     force      outer  setforce  0.0 0.0 0.0
min_style               cg
minimize                1.0e-30 1.0e-30 10000 10000
print                   "${x0} ${y0} ${z0}" append info.dat
unfix                   force
