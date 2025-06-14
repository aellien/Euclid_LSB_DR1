#!/bin/bash
for file in /n03data/ellien/Euclid_LSB_DR1/data/EUC_EDF_N_bin4_2.5k2/*2690*.fits
do
  echo "Launch Dawis on file ${file}"
  n=$(basename "$file")
  bash start_dawis_slurm.sh $n
done
