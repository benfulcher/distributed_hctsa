#!/bin/bash
# Set name of job shown in squeue
#SBATCH --job-name xxNameOfJobxx
# Set project code account
#SBATCH --account=XXX
# Request CPU resources
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
# Memory usage (MB)
#SBATCH --mem-per-cpu=12000
# Set your minimum acceptable walltime, format: day-hours:minutes:seconds
#SBATCH --time=20:00:00
# Email user if job fails or ends
#SBATCH --mail-type=FAIL
#SBATCH --mail-type=END
#SBATCH --mail-user=XXX@XXX
# Specify a queue (called a partition on SLURM)
#SBATCH --partition=main
#SBATCH -p main

# Set environment variables to run Matlab
module purge
module load matlab/r2015b

# Show the host on which the job ran
hostname

# Show what SLURM ennvironment variables our environment has
env | grep SLURM

# Launch the Matlab job
matlab -nodisplay -r "disp(pwd); HCTSA_Runscript; exit"
