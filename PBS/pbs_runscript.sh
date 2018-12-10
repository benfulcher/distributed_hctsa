#!/bin/bash
# Set name of job
#PBS -N xxNameOfJobxx
#PBS -o demo.txt
#PBS -j oe
# Specify a queue:
#PBS -q physics
#PBS -l nodes=1:ppn=1
# Set your minimum acceptable walltime, format: day-hours:minutes:seconds
#PBS -l walltime=00:01:00
# Email user if job ends or aborts
#PBS -m ea
#PBS -M ben.fulcher@physics.sydney.edu.au
#PBS -V

# your commands/programs start here, for example:
cd "$PBS_O_WORKDIR"
# Show the host on which the job ran
hostname
# Launch the Matlab job
matlab -nodisplay -singleCompThread -r "disp(pwd); HCTSA_Runscript; exit"
exit
