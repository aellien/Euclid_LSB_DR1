#!/bin/bash

for tile in ../data/*.weight_scaled.fits
do
    mv $tile ${tile::-19}_scaled.weight.fits
done