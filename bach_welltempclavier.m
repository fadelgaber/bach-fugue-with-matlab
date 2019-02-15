load bach_fugue.mat;
%Specifies the beats per minute and sampling frequency.
%Calculates bps then spb then spp
bpm = 80;
fs = 11025;
beats_per_second = bpm/60;
seconds_per_beat = 1/beats_per_second;
seconds_per_pulse = seconds_per_beat / 4;
key_per_pulse = fs * seconds_per_pulse;

%Loops for the length of theVoices
%Creates an array of ones the size of durations on every iteration
%Creates an array xx that will store all the tones
max_duration=0;
max_start_pulse=0;

for i = 1:length (theVoices)
    for j = 1:length(theVoices(i).durations)
        if (theVoices(i).durations(j) > max_duration)
            max_duration = theVoices(i).durations(j);
        end
    end
    
    for z = 1: length(theVoices(i).startPulses)
        if(theVoices(i).startPulses(z) > max_start_pulse)
            max_start_pulse = theVoices(i).startPulses(z);
        end
    end
end
xx = zeros(1, ceil(seconds_per_pulse*fs*(max_duration+max_start_pulse)));


for a = 1:length (theVoices)
    %Loops through all noteNumbers
    %Calculates the duration of every note in seconds
    %Calculates the amount of keys per pulse of each note
    for b = 1:length (theVoices(a).noteNumbers)
    keynum = theVoices(a).noteNumbers(b);         
    duration =  theVoices(a).durations(b)*seconds_per_pulse;
    keyOrder = theVoices(a).startPulses(b)*key_per_pulse;
    
    %Uses key2note to synthesize a sinusoid for all key numbers and their
    %duration
    %stores the amount of keys per pulse in the rows and the length of tone
    %in columns. Adds the tone to this matrix.
    [tone, adsr] = key2note(1, keynum, duration);
    n1 = ceil(keyOrder);
    n2 = n1 + length(tone) - 1;
    xx(n1:n2) = xx(n1:n2) + tone ;
    end

end
%Plays the xx matrix using the fs sampling frequency and produces a
%spectogram
soundsc(xx,fs);
specgram(xx, 512, fs);    

