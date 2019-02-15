%--- play_scale.m
%---
scale.keys = [ 40 42 44 45 47 49 51 52 ];
%--- NOTES: C D E F G A B C
% key #40 is middle-C
%
scale.durations = 0.25 * ones(1,length(scale.keys));
fs = 11025; %-- or 8000 Hz
xx = zeros(1, sum(scale.durations)*fs+length(scale.keys) );
n1 = 1;
X = 100*exp(-1j*pi/4);
for kk = 1:length(scale.keys)
keynum = scale.keys(kk);
tone = key2note(X, keynum, scale.durations);
n2 = n1 + length(tone) - 1;
xx(n1:n2) = xx(n1:n2) + tone;
n1 = n2 + 1;
end
specgram(xx, 512, fs);
soundsc(xx, fs);
