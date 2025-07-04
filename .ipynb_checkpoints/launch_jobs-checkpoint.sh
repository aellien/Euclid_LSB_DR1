#!/bin/bash
for file in /n03data/ellien/Euclid_LSB_DR1/data/EUC_EDF_N_bin4_2.5k2/*_scaled.cut*.fits
do
  echo "Launch Dawis on file ${file}"
  n=$(basename "$file")
  idtile=${file:18:4}
  idcut=$(echo $file | sed -n 's/.*cut\([0-9]\+\)\.fits/\1/p') # à l'arrache
  if [ -f /n08data/ellien/Euclid_LSB_DR1/wavelets/out3/${idtile}/EUC_VIS_LSB_ObsID_${idtile}_scaled.cut${idcut}.synth.lvl_sep.fits ] 
  then
    echo "bash start_dawis_slurm.sh $n"
  fi
done
