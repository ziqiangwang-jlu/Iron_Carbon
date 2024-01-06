

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
group                   carbon    type     2

pair_style              eam/alloy
pair_coeff              * * FeC-Becquart2013.eam.txt Fe C
neighbor                0.3 bin
neigh_modify            delay 0 check yes every 1

compute                 force     carbon   reduce  sum  fx fy fz
#variable                fx    equal    c_force[1]
#variable                fy    equal    c_force[2]
#variable                fz    equal    c_force[3]

set                     atom          $i    x  ${x_new}  y  ${y_new}  z  ${z_new}

thermo_style            custom   step    v_fx v_fy v_fz pe ke etotal 
thermo                  1000
fix                     force   outer    setforce   0.0 0.0 0.0
fix                     hold    carbon   planeforce   ${new_x}  ${new_y}  ${new_z}
min_style               cg
minimize                1.0e-30 1.0e-30 10000 10000
unfix                   hold
unfix                   force 

