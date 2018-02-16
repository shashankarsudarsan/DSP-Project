# Power Spectral Estimation – Quantization Noise

## Objective: 
To investigate the correlation and spectral properties of quantization noise for various number of fractional bits and then compare and verify our results with the statistical model representing the effects of quantization.
## Background:
The A/D converter is a physical device that converts an analog signal to digitized signal representing a quantized amplitude value closest to the amplitude of the input signal. Prior to A/D conversion, pre-filtering is done using a proper low-pass filter to avoid aliasing during sampling. A/D conversion almost always ends up distorting the original signal because whatever maybe the value of the input signal it ends up into one of the predefined set of values in output. 
Nevertheless this impact of A/D conversion can be modelled as actual signal + additive uncorrelated noise process, i.e. model A/D as adding noise to signal. And this noise will be the quantization error. This is done to make sure that the quantization noise level is not higher than the ambient noise from the environment. A statistical model based on the quantizer depicted above is useful for representing the effects of quantization. This model has the following assumptions:
* The error sequence is a sample sequence of a stationary random process
* The error is a white noise process
* The probability distribution of the error is uniform over the range of quantization error
* The error is uncorrelated with the sequence

It should be noted that the statistical model is valid when the quantizer is not overloaded and when the signal is sufficiently complex and the quantization steps are sufficiently small. Dithering the input signal with an uncorrelated noise sequence will break any correlation present in the error. 
## Approach:
* The input sinusoid is generated and the constant values required for implementation are set. The signal is quantized in a straightforward way using the formula
```
Q(x[n])=2^(-b)×round(2^b×x[n])
```
Where b is the number of fractional bits of the quantizer
* The error signal is determined by
```
e[n]=Q(x[n])-x[n]
```
And all three signals are plotted. 
* We now plot the magnitude of the Fourier transform of x[n]  and Q(x[n]) signals. A Hanning window function is applied prior to determining the Fourier transform.
* The histogram of the error signal is plotted using the hist function in MATLAB to check if it’s uniformly distributed. In addition, we determine and plot its autocorrelation and power spectral density.
*	Since one of our model’s assumptions include the error sequence being uncorrelated with the input sequence, we determine and plot the cross-correlation between input and the error time series.
*	Furthermore, for comparison we calculate the theoretical and expected values and tabulate them. The above steps are repeated for b=1,3 and 7 cases.
*	Finally, for b=1 case, in order to make it fit the model, we try to break the error’s correlation by dithering the input time series by adding uncorrelated noise sequence of amplitude = (i) ±(q/2) (ii) ±(q/20) and observe the effects.

## Results
* First, we compare the plots of signal quantized with various fractional bits (1, 3, and 7), we see that as the number of bits is increased, the quantization models the original signal better.
* We observe that as the fractional bits increases the correlation between the samples of the error sequence decreases. It is seen that for b=1 case the error is highly correlated and doesn’t match our theoretical assumption for the statistical model.
* We see that there is significant difference in the Fourier domain between the input and quantized signals. The quantized signal Fourier transform has significant amount of other frequencies than the ones present in the input signal.
* The frequencies other than the ones present in the input signal is pulled down significantly. Moreover, the variance also decreases as the number of bits increases.
* The histogram of the error sequence is plotted to see its probability distribution. In case of b=1, it’s not exactly uniform but rather spiked in the middle. When we increase b to 3, we get an approximation of the uniform distribution and b = 7 almost fits our model assumption of uniform distribution for the error sequence.
