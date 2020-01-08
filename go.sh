#!/bin/bash

Gamma=1.666666666666

densL=1.0
velyL=0.0
presL=1e-13


densR=1.0
velyR=0.0
presR=1e-14

dt=24000.0
TimeMax=9.6e5
Length=1.0


c=299792458

presL=`python -c "print($presL*$c*$c)"` 
velyL=`python -c "print($velyL*$c)"`
       
presR=`python -c "print($presR*$c*$c)"`
velyR=`python -c "print($velyR*$c)"`

Length=`python -c "print($Length*$c)"`
Middle=`python -c "print($Length*0.5)"`


rm ouput/*


for idx in {0..40};
do    
    Time=`python -c "print($idx*$dt)"`
    
    python ./toro_exact.py -n 512 -d nodal -p user --left "[$densL,$velyL,$presL]" --right "[$densR,$velyR,$presR]" -b "[0.0,$Length]" -x $Middle -t $Time -g $Gamma 

    Idx=`printf "%03d" $idx`


	mv output/toro_user_exact.dat output/toro_user_exact_${Idx}.dat
done
