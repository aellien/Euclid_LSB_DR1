from astropy.io import fits
import os
import glob
import numpy as np

path_wavelets = '/n08data/ellien/Euclid_LSB_DR1/wavelets/out3'
nfpl = glob.glob(os.path.join(path_wavelets, '*/*synth*fits'))

for nfp in nfpl:
    
    hdu = fits.open(nfp)
    recim = hdu[2].data
    if np.mean(recim) == 0.:
        print(nfp)