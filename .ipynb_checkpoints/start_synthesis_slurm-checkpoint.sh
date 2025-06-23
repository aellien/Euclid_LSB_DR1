#!/usr/bin/env bash
#!/bin/bash
#SBATCH --job-name=lsb_dr1_synth
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=48:00:00
#SBATCH --output /n03data/ellien/Euclid_LSB_DR1/logs/%x.%j.out 
#SBATCH --error  /n03data/ellien/Euclid_LSB_DR1/logs/%x.%j.err

source /home/durret/.bashrc
conda activate dawis
python -W"ignore" /home/ellien/Euclid_LSB_DR1/make_synthesis_euc_edfn.py $@

exit 0
