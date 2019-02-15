# Introduction

This project is about creating a Bach &quot;the well tempered-clavier&quot; fugue via MATLAB by synethsising sinusoids.

## Explanation

We are provided a MATLAB structure (theVoices) that contains the required data to be able to synthesise and play the well-tempered by Bach. This structure is loaded into MATLAB by using:

load bach\_fugue.mat;

This structure contains 3 rows and 3 columns. The columns are startPulses, noteNumbers and durations which specify the start of each pulse (in terms of pulses), the key number, and the duration of every note (in terms of pulses) respectively.

We are also provided a sampling frequency and the bits per minute of the music piece, from which we can calculate the number of keys per pulse. Moreover, it is possible to calculate a value for seconds per pulse which will help in converting the pulses in theVoices to seconds.

Although the lab script says the bpm is 120, I found 80 bpm to be more close to the real sound. The bpm (bits per minute) controls how fast the music is played by changing seconds\_per\_pulse and keys\_per\_pulse accordingly.

Matrix xx holds the sinusoids (notes) to be played. To calculate the correct length of xx, the total duration (maximum) of the music piece has to be found. The maximum length would be the maximum value of theVoices.durations added to the maximum of theVoices.startPulses, then multiplied by seconds\_per\_pulse and the sampling frequency(fs). The ceil() function is used to round the number up, since a float cannot represent an index.

To find the maximum values, two loops iterate over theVoices, comparing the current value with a dummy variable (max\_durations, max\_start\_pulse), which store the largest number after the last iteration of the loop.

Next, the second for-loop iterates over all theVoices and uses the key2note function to synthesise a sinusoid for each key number(noteNumbers). The duration of every note is calculated by multiplying durations with seconds\_per\_pulse, which essentially converts the data from pulses to seconds. These sinusoids are then added to the matrix xx, after which it is played and a spectrogram is built.

To make the music piece sound more realistic, ADSR functionality was added to the key2note function. The linspace function generates a linearly spaced vector between two points (inclusive).

_Ex_:         y = linspace(x1,x2) returns a row vector of 100 evenly spaced points between x1 and x2.

y = linspace(x1,x2,n) generates n points. The spacing between the points is (x2-x1)/(n-1).

A = linspace(0, 1, (length(y)\*0.1)); % rise(attack) 10% of signal

D = linspace(1, 0.8, (length(y)\*0.15)); % drop(delay) of 15% of signal

S = linspace(0.8, 0.75, (length(y)\*0.6)); % delay(sustain) of 60% of signal

R = linspace(0.75, 0, (length(y)\*0.15)); % drop(release) of 15% of signal

## Usage

**Copy all the files into your working directory.**

**Open bach\_welltemperedclavier.m**

**Run the file**
