#
# Relaxing the interstitial site fully
# Only if the displacement of the interstitial carbon is greater than or equal to 0.8 A, the new interstitial site 
# can be accepted
# The displacement threshold is specified as one fourth of the lattice constant(2.855) about 0.8A
#

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

variable                forward        equal     0.0
variable                x_saddle       equal     ${x_0}+(${back_delta}+${forward})*${unitx}
variable                y_saddle       equal     ${y_0}+(${back_delta}+${forward})*${unity}
variable                z_saddle       equal     ${z_0}+(${back_delta}+${forward})*${unitz}

set                     atom       $i     x   ${x_saddle}  y  ${y_saddle}  z   ${z_saddle}
fix                     force      outer  setforce  0.0 0.0 0.0
min_style               cg
minimize                1.0e-30 1.0e-30 10000 10000

variable                disp_threshold    equal     0.8
variable                displacement      equal     sqrt((${x0}-${x_0})^2+(${y0}-${y_0})^2+(${z0}-${z_0})^2)
if  "${displacement} >= ${disp_threshold}" then "print '${x0} ${y0} ${z0}' append info.dat"

unfix                   force
