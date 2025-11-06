#!/bin/bash
path_data="/home/aellien/Euclid_LSB_DR1/data/"
path_analysis="/home/aellien/Euclid_LSB_DR1/analysis"
path_IR_maps="/home/aellien/Euclid_LSB_DR1/data/IR_EDF_N"
path_wavelets="/home/aellien/Euclid_LSB_DR1/wavelets/out3"
# Euclid
#swarp @${path_data}/list_tiles.txt -c default.swarp
#swarp @${path_analysis}/list_scaled.txt -c default.swarp


# IR maps
#for filter in 100micron 30GHz 12microns 353GHz 25microns 44GHz 60microns 545GHz 100GHz 70GHz 143GHz 857GHz 217GHz
#do
#    swarp @${path_IR_maps}/list_$filter.txt -c IR.swarp -IMAGEOUT_NAME ${path_IR_maps}/mosaic_$filter.fits
#done

swarp @${path_wavelets}/list_recim.txt -c IR.swarp -IMAGEOUT_NAME ${path_wavelets}/mosaic_dawis_residuals.fits #-WEIGHT_IMAGE @${path_wavelets}/list_weights.txt -#WEIGHTOUT_NAME ${path_wavelets}/mosaic_dawis_residuals.weigth.fits
#swarp @${path_wavelets}/list_recim1.txt -c IR.swarp -IMAGEOUT_NAME ${path_wavelets}/mosaic_dawis_residuals1.fits
#swarp @${path_wavelets}/list_recim2.txt -c IR.swarp -IMAGEOUT_NAME ${path_wavelets}/mosaic_dawis_residuals2.fits
#swarp @${path_wavelets}/list_recim3.txt -c IR.swarp -IMAGEOUT_NAME ${path_wavelets}/mosaic_dawis_residuals3.fits
#swarp ${path_wavelets}/mosaic_dawis_residuals1.fits ${path_wavelets}/mosaic_dawis_residuals2.fits ${path_wavelets}/mosaic_dawis_residuals3.fits c IR.swarp -IMAGEOUT_NAME ${path_wavelets}/mosaic_dawis_residuals.fits

#swarp @${path_data}/EUC_EDF_N_bin4_2.5k2/list_cuts.txt -c IR.swarp -IMAGEOUT_NAME ${path_data}/EUC_EDF_N_bin4_2.5k2/mosaic_recombined.fits -WEIGHT_TYPE MAP_WEIGHT