#!/bin/bash
input="/home/aellien/Euclid_LSB_DR1/data/EUC_EDF_N_bin4_10k2/EUC_VIS_LSB_ObsID_2693_scaled.fits"
output="/home/aellien/Euclid_LSB_DR1/analysis/EUC_VIS_LSB_ObsID_2693_scaled_det.fits"

#astarithmetic /home/aellien/Euclid_LSB_DR1/data/mosaic.fits /home/aellien/Euclid_LSB_DR1/data/mosaic.fits 0.0 eq nan where -g0

astnoisechisel $input --output=$output -h1 --dthresh=0.1