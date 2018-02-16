%----------------Mid Term Project - Power Spectral Estimation-------------%
% Name------Shashankar Sudarsan
% Roll------A53214136
% E-mail----ssudarsa@eng.ucsd.edu


clc;
clear variables;
close all;

%Initialization
n=0:255;
N=256;
nvals = (-N/2:(N/2)-1)/N;
w = hann(N);
u = sum(w.^2)/N;
b=1; % Fractional bit(s) of quantizer
q = 2^(-b); % Quantization interval
x = sin((2*pi*n)/N);
noise = (rand(1,N)-0.5)*(q/10); % noise to dither(q is replaced by q/10 for case 2)
xn = x+noise; % adding noise to dither our signal

figure
set(plot(n,xn),'LineWidth',1.5)
title('Fig.1 256 point Input Sinusoid Time Series x[n]')
xlabel('Samples n->')
ylabel('Amplitude')
grid on;
Qx = 2^(-b).*(round(2^b.*xn)); % Simple quantization
figure
set(plot(n,Qx),'LineWidth',1.5)
title('Fig.2: Quantized Input Signal Q(x[n])')
xlabel('Samples n->')
ylabel('Amplitude')
grid on
e = Qx-x; % Error signal
figure
set(plot(e),'LineWidth',1)
title('Fig.3: Quantization Error Time Series e[n]')
xlabel('Samples n->')
ylabel('Amplitude')
grid on
% frequency domain
wx = w'.*x;
Qwx = w'.*Qx;
ft_x = fftshift(abs(fft(wx)));
ft_Qx = fftshift(abs(fft(Qwx)));
ft_x_dB = 20*log10(ft_x);
ft_Qx_dB = 20*log10(ft_Qx);
figure
plot(nvals,ft_x_dB)
title('Fig.4: Magnitude plot of FFT of input time series')
xlabel('Normalized Frequency (cycles/sample)')
ylabel('Magnitude (dB)')
% ylim([-60,40]) % Changing dynamic range if necessary
grid on;
figure
plot(nvals,ft_Qx_dB)
title('Fig.5: Magnitude plot of FFT of quantized time series')
xlabel('Normalized Frequency (cycles/sample)')
ylabel('Magnitude (dB)')
% ylim([-70,40]) % Changing dynamic range if necessary
grid on;
figure
histogram(e,'FaceColor','b') % histogram
title('Fig.6: Histogram plot of error time series')
xlabel('Bins')
ylabel('Counts(Frequency)')
grid on;
[phi_ee, lagsee] = xcorr(e,'biased',63); % autocorrelation
figure
set(plot(lagsee(64:end),phi_ee(64:end)),'LineWidth',1.5)
title('Fig.7 Autocorrelation estimate of the error signal')
xlabel('Lags m->')
ylabel('Autocorrelation value')
grid on;
% power spectral denisty of error
we = w'.*e;
psd_e = (abs(fftshift(fft(we))).^2)/(N*u);
psd_e_dB = 10*log10(psd_e);
figure
plot(nvals,psd_e_dB)
title('Fig.8 Power Spectral Density of Error Signal')
xlabel('Normalized Frequency (cycles/sample)')
ylabel('Power Spectral Density (dB)')
% ylim([-100,-40]) % Changing dynamic range if necessary
grid on;
% cross correlation
[phi_xe, lagsxe] = xcorr(x,e,'biased',63);
figure
set(plot(lagsxe,phi_xe),'LineWidth',1.5);
title('Fig.9 Crosscorrelation estimate of the error signal with input time series');
xlabel('Lags m->')
ylabel('Crosscorrelation value')
grid on;

