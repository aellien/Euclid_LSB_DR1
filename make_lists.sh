#!/bin/bash

# IR maps
for filter in 100micron 30GHz 12microns 353GHz 25microns 44GHz 60microns 545GHz 100GHz 70GHz 143GHz 857GHz 217GHz
do
    ls /home/aellien/Euclid_LSB_DR1/data/IR_EDF_N/*/*$filter* > /home/aellien/Euclid_LSB_DR1/data/IR_EDF_N/list_$filter.txt
done

# Dawis outputs
ls /home/aellien/Euclid_LSB_DR1/wavelets/out3/EUC_VIS_LSB_ObsID_*_scaled.cut*.synth.lvl_sep.fits > /home/aellien/Euclid_LSB_DR1/wavelets/out3/list_recim.txt

# cutouts
ls /home/aellien/Euclid_LSB_DR1/data/EUC_EDF_N_bin4_2.5k2/EUC_VIS_LSB_ObsID_*_scaled.cut*.fits > /home/aellien/Euclid_LSB_DR1/data/EUC_EDF_N_bin4_2.5k2/list_cuts.txt