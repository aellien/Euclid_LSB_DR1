#!/usr/bin/env bash
sbatch <<EOT
#!/bin/bash
#SBATCH --job-name=lsb_dr1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=48:00:00
#SBATCH --output /n03data/ellien/Euclid_LSB_DR1/logs/%x.%j.id$2_cut$3.out 
#SBATCH --error  /n03data/ellien/Euclid_LSB_DR1/logs/%x.%j.id$2_cut$3.err

source /home/ellien/.bashrc
conda activate dawis

python -W"ignore" /home/ellien/Euclid_LSB_DR1/dawis_input.py $1

exit 0
EOT