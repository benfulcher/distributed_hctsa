#!/bin/bash
# Set name of job
#PBS -N xxNameOfJobxx
#PBS -o jobOutput.txt
#PBS -j oe
# Specify a queue:
#PBS -q XXX
#PBS -l select=1:ncpus=1:mem=8GB
# Set your minimum acceptable walltime, format: day-hours:minutes:seconds
#PBS -l walltime=05:00:00
# Email user if job ends or aborts
#PBS -m ea
#PBS -M XXX@XXX
#PBS -V

# ---------------------------------------------------
cd "$PBS_O_WORKDIR"

# Show the host on which the job ran
hostname

# Load matlab module
module load Matlab2019b

# Launch the Matlab job
matlab -nodisplay -singleCompThread -r "HCTSA_Runscript; exit"
