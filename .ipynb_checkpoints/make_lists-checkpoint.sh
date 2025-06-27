#!/bin/bash
for filter in 100micron 30GHz 12microns 353GHz 25microns 44GHz 60microns 545GHz 100GHz 70GHz 143GHz 857GHz 217GHz
do
    ls /home/aellien/Euclid_LSB_DR1/data/IR_EDF_N/*/*$filter* > /home/aellien/Euclid_LSB_DR1/data/IR_EDF_N/list_$filter.txt
done

ls /home/aellien/Euclid_LSB_DR1/wavelets/out2/EUC_VIS_LSB_ObsID_*_scaled.cut?.synth.lvl_sep.fits > /home/aellien/Euclid_LSB_DR1/wavelets/out2/list_recim.txt