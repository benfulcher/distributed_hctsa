#!/bin/bash

# -------------------------------------------
# USER INPUT:
# -------------------------------------------
# Set range of ts_ids to calculate
tsMin=1
tsMax=1614
# Set number of time series to calculate per job
numPerJob=100
# -------------------------------------------

# Calculate the number of jobs required
NumJobs=$((($tsMax-$tsMin)/$numPerJob+1))

#
# Start by writing the directory structure
# Stored in {DirNames[]} array
TheTS=$tsMin
for (( i=0; i<$NumJobs; i++)); do
    HereMin=$TheTS
    if [ $i -eq $(($NumJobs-1)) -a $(($NumJobs*$numPerJob)) -gt $tsMax ]; then
        HereMax=$tsMax
    else
        HereMax=$(($TheTS+$numPerJob-1))
    fi
    DirNames[i]="tsids_$HereMin-$HereMax" # Store the directory names
    JobNames[i]="tsids-$HereMin-$HereMax" # Make names for PBS jobs
    MinIDS[i]=$HereMin # Also store the minimum ts_id
    MaxIDS[i]=$HereMax # Also store the maximum ts_id
    mkdir ${DirNames[i]}
    TheTS=$(($TheTS+$numPerJob))
done

#
# Next we want to go into each directory and create
# a SLURM script with a suitable job name
# The file slurm_runscript.sh and HCTSA.mat must be in the base directory
for ((i=0; i<$NumJobs; i++)); do
    # Define the script location:
    ScriptLocation="${DirNames[i]}/slurm_runscript.sh"
    # echo $ScriptLocation
    # Use sed to replace the wildcard NameOfJob with the directory name
    sed "s/xxNameOfJobxx/${JobNames[i]}/g" slurm_runscript.sh > $ScriptLocation

    # Copy the HCTSA.mat file into the subdirectory
	# MatFileLocation="${DirNames[i]}/HCTSA.mat"
    # sed "s/xxNameOfJobxx/${JobNames[i]}/g" HCTSA.mat > $MatFileLocation
done

#
# Ok, so now we have all the SLURM shell scripts for the jobs we want to
# run in their respective directories.
# Now we need to copy Matlab runscripts with the right range of ts_ids in them
# (into each directory)
for ((i=0; i<$NumJobs; i++)); do
    # Define the script location:
    RunScriptLocation="${DirNames[i]}/HCTSA_Runscript.m"
    # echo $ScriptLocation
    # Use sed to replace the wildcard NameOfJob with the directory name
    sed -e "s/xxTSIDMINxx/${MinIDS[i]}/g" -e "s/xxTSIDMAXxx/${MaxIDS[i]}/g" HCTSA_Runscript.m > $RunScriptLocation
done

#
# Ok, so now we want to go through and actually submit all the SLURM scripts as jobs
for ((i=0; i<$NumJobs; i++)); do
    cd ${DirNames[i]}
    JobNumber=$(sbatch slurm_runscript.sh) # Take note of the job number
    echo "Job submitted for tsids between ${MinIDS[i]} and ${MaxIDS[i]} as $JobNumber"
    # Make a file for the job number
    # echo ${JobNumber} > "${JobNumber%%.*}.txt"
    cd ../
done
