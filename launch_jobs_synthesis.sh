#!/bin/bash
for file in /n03data/ellien/Euclid_LSB_DR1/data/EUC_EDF_N_bin4_2.5k2/*_scaled.cut*.fits
do
  echo "Launch synthesis for file ${file}"
  n=$(basename "$file")
  sbash start_synthesis_slurm.sh $n
done
