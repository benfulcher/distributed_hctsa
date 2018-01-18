#!/bin/bash
# Set name of job
#PBS -N MyJobName
#PBS -o demo.txt
#PBS -j oe
# Specify a queue:
#PBS -q physics
#PBS -l nodes=1:ppn=4
# Set your minimum acceptable walltime, format: day-hours:minutes:seconds
#PBS -l walltime=00:01:00
# Email user if job ends or aborts
#PBS -m ea
#PBS –M ben.fulcher@physics.sydney.edu.au
#PBS -V

# your commands/programs start here, for example:
cd "$PBS_O_WORKDIR"
# Show the host on which the job ran
hostname
# Launch the Matlab job
matlab -nodisplay -r "disp(pwd); HCTSA_Runscript; exit"
exit


# Request CPU resources
# SBATCH --ntasks=1
# SBATCH --ntasks-per-node=1
# SBATCH --cpus-per-task=1
# Memory usage (MB)
# SBATCH --mem-per-cpu=12000
# SBATCH --time=10:00:00

# SBATCH --mail-type=FAIL
# SBATCH --mail-type=END
# SBATCH --mail-user=ben.fulcher@monash.edu

# SBATCH --partition=main
# SBATCH -p main

# Show what SLURM ennvironment variables our environment has
# env | grep SLURM
