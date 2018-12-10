#!/bin/bash
# Set name of job
#PBS -N xxNameOfJobxx
#PBS -o jobOutput.txt
#PBS -j oe
# Specify a queue:
#PBS -q physics
#PBS -l nodes=1:ppn=1
# Set your minimum acceptable walltime, format: day-hours:minutes:seconds
#PBS -l walltime=01:00:00
# Email user if job ends or aborts
#PBS -m ea
#PBS -M ben.fulcher@sydney.edu.au
#PBS -V

# ---------------------------------------------------
cd "$PBS_O_WORKDIR"

# Show the host on which the job ran
hostname

# Load matlab module
module load Matlab2018a

# Launch the Matlab job
matlab -nodisplay -singleCompThread -r "HCTSA_Runscript; exit"
