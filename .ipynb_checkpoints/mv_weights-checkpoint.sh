#!/bin/bash
for weight in /home/aellien/Euclid_LSB_DR1/data/EUC*scaled.weight.fits
do
    #echo "${weight}"
    bn=$(basename "$weight")
    #echo $(basename "$weight")
    cp $weight /home/aellien/Euclid_LSB_DR1/analysis/${bn::-12}_masked.weight.fits
done