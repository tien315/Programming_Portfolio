%Lab 11 - Reversing and Fading Sound
%Alan Tieng
%CS 109, Spring 2020, Reckinger

function lab11
clear all;
close all;
clc;
%test code here

[y, f] = reverse('cde.wav')

%p = .25
%p = .50
%[y, f] = fadeIn('water.wav', p)

size(y) %check dim of output file
end


%The reverse function will take in a file and return it reversed.
%INPUTS
%filename - a string filename of the audio file, e.g. 'water.wav'
%OUTPUTS
%y - the array (n by 1 or n by 2) of reversed sound data
%f - sample rate 
function [y, f] = reverse(filename)
[y, f] = audioread(filename);
y = y(end:-1:1,:);
end

%The fade in function will take in an audio file and return data with the sound
%fading in.  Let's call the length of the sample n.  The input p represents the 
%the percentage of the sample that should be included in the fade.  For
%example, if p = 0.5, then the sound should be at full volume after half
%way through the sample.  If p = 0.25, then the sound should be at full
%volume after a quarter way through the sample.
%The first sample should be multiplied by (1/(n*p)) and the last sample should be multiplied
%by (n*p)/(n*p).  Each sample in between should be multipled by the values that linearly
%scale between (1/(n*p)) and (n*p)/(n*p).  Linearly scale means the first
%one is multipled by (1/(n*p)), second one is multipled by (2/(n*p)), third
%one is multipled by (3/(n*p)), etc.  Make sure n*p is an integer, by
%using the round function.
%INPUTS
%filename - a string filename of the audio file, e.g. 'water.wav'
%p - the percentage of the sample that should be included in the fade. 
%OUTPUTS
%y - the array (n by 1 or n by 2) with the fade applied
%f - sample rate
function [y, f] = fadeIn(filename, p)
[y, f] = audioread(filename);
n = size(y,1);
y = y.*[[1:round(n*p)]./round(n*p),ones(1,n-round(n*p))];
end
