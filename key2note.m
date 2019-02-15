function [xx, ADSR] = key2note(X, keynum, dur)
%Specifies the sampling frequency and samples the length according to it
fs = 11025;
tt = 0:(1/fs):dur;
%Gets the frequency of the key by using key 49 as a reference.
freq = 440*2^((keynum-49)/12);
%creates a complex sinusoid based on the freq and sampling rate
y = real(X*exp(1j*2*pi*freq*tt));
%ADSR implementation
A = linspace(0, 1, (length(y)*0.1)); % 10%
D = linspace(1, 0.8, (length(y)*0.15)); % 15%
S = linspace(0.8, 0.8, (length(y)*0.6)); % 60%
R = linspace(0.8, 0, (length(y)*0.15)); % 15%
%A matrix that contain the ADSR values
ADSR = [A D S R];
%Creates an empty matrix "x" and fills it with values from ADSR
%Multiplies the complex sinusoid "y" with the ADSR matrix to get a more
%natural sounding sinusoid
x = zeros(size(y));
x(1:length(ADSR)) = ADSR;
xx = y.* x;

end