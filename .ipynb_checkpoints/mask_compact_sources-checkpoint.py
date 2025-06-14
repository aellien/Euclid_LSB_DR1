import photutils
import numpy as np
import os
from astropy.io import fits
from photutils.background import Background2D, MedianBackground
from astropy.convolution import convolve
from photutils.segmentation import make_2dgaussian_kernel
from photutils.segmentation import detect_sources
import matplotlib.pyplot as plt
from astropy.visualization import SqrtStretch, ZScaleInterval, LinearStretch
from astropy.visualization.mpl_normalize import ImageNormalize
from dawis import sample_noise, inpaint_with_gaussian_noise


path_data = '/home/aellien/Euclid_LSB_DR1/data/'
path_analysis = '/home/aellien/Euclid_LSB_DR1/analysis/'
    
#image_list = ['EUC_VIS_LSB_ObsID_2688_scaled.fits',
#              'EUC_VIS_LSB_ObsID_2689_scaled.fits',
#              'EUC_VIS_LSB_ObsID_2690_scaled.fits',
#              'EUC_VIS_LSB_ObsID_2691_scaled.fits',
#              'EUC_VIS_LSB_ObsID_2692_scaled.fits',
#              'EUC_VIS_LSB_ObsID_2693_scaled.fits']
#for image in image_list:

with open(os.path.join(path_data, 'list_tiles.txt'), 'r') as f:
    for line in f:
        
        # read image
        nfp = line.split()[0]
        #nfp = os.path.join(path_data, image)
        print('\nRead %s'%nfp)

        hdu = fits.open(nfp)
        orim = hdu[1].data
        data = np.copy(orim)
        data[data == 0.] = np.nan
    
        # bkg subtraction
        bkg_estimator = MedianBackground()
        bkg = Background2D(data, (50, 50), filter_size=(31, 31), bkg_estimator=bkg_estimator)
        data -= bkg.background  # subtract the background
    
        # detection
        threshold = 1.1 * bkg.background_rms
        kernel = make_2dgaussian_kernel(10.0, size = 11)  # FWHM = 3.0
        convolved_data = convolve(data, kernel)
        segment_map = detect_sources(convolved_data, threshold, npixels = 10)
    
        # mask image
        mask = np.copy(segment_map.data)
        mask[mask > 0] = 1.
        orim[mask > 0] = np.nan
        orim[orim == 0.] = np.nan

        # inpainting
        noise_pixels, valmax = sample_noise(orim, n_sigmas = 3, bins = 200)
        mean, sigma = np.mean(noise_pixels), np.std(noise_pixels)
        iptd = np.copy(orim)
        iptd = inpaint_with_gaussian_noise(iptd, mean = mean, sigma = sigma, iptd_sigma = 5)

        # write masked
        hduo = fits.PrimaryHDU(header = hdu[0].header)
        hdu1 = fits.ImageHDU(orim, header = hdu[1].header)
        hdul = fits.HDUList([hduo, hdu1])
        image = nfp.split('/')[-1]
        out = image[:-5] + '_masked.fits'
        print('write to %s\n' %os.path.join(path_analysis, out))
        hdul.writeto(os.path.join(path_analysis, out), overwrite = True)

        # write inpainted
        hduo = fits.PrimaryHDU(header = hdu[0].header)
        hdu1 = fits.ImageHDU(iptd, header = hdu[1].header)
        hdul = fits.HDUList([hduo, hdu1])
        out = image[:-5] + '_iptd.fits'
        print('write to %s\n' %os.path.join(path_analysis, out))
        hdul.writeto(os.path.join(path_analysis, out), overwrite = True)

        

    