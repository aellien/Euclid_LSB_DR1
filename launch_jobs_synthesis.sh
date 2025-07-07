#!/bin/bash
for file in /n03data/ellien/Euclid_LSB_DR1/data/EUC_EDF_N_bin4_2.5k2/*_scaled.cut*.fits
do
  echo "Launch synthesis for file ${file}"
  n=$(basename "$file")
  idtile=${n:18:4}
  idcut=$(echo $n | sed -n 's/.*cut\([0-9]\+\)\.fits/\1/p') # à l'arrache
  echo "/n08data/ellien/Euclid_LSB_DR1/wavelets/out3/${idtile}/EUC_VIS_LSB_ObsID_${idtile}_scaled.cut${idcut}.synth.lvl_sep.fits"
  if [ -f /n08data/ellien/Euclid_LSB_DR1/wavelets/out3/${idtile}/EUC_VIS_LSB_ObsID_${idtile}_scaled.cut${idcut}.synth.lvl_sep.fits ] 
  then
    echo "synthesis image found, passing"
  else
      bash start_synthesis_slurm.sh $n
  fi
done
