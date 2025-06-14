#!/bin/bash
path_data="/home/aellien/Euclid_LSB_DR1/data"

for id in 2689 2690 2693
do
    #tile="${path_data}/EUC_VIS_LSB_ObsID_${id}.fits"
    #astwarp -h0 $tile --scale=1./4. --output="${path_data}/EUC_VIS_LSB_ObsID_${id}_scaled.fits"

    weight="${path_data}/EUC_VIS_LSB_ObsID_${id}.weight.fits"
    astwarp -h0 $weight --scale=1./4. --output="${path_data}/EUC_VIS_LSB_ObsID_${id}_scaled.weight.fits"

done