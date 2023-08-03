%Project 11a - Echo, Mixing Sounds, and Removing Vocals
%Alan Tieng
%CS 109, Spring 2020, Reckinger

function project11
%test code goes here


%filename = "welcome.wav"
%filenames = ["welcome.wav", "door.wav"];
%long filename test
%filenames = ["welcome.wav", "door.wav", "welcome.wav" , "door.wav", "welcome.wav", "door.wav"];
%filename = "love.wav"

%uncomment to test function calls
%[y, f] = echoSound(filename);
%[y, f] = mix(filenames);
%[y, f] = removeVocals(filename);
end

%The echo function will take in a file and return it with a delayed echo.
%INPUTS
%filename - a string filename of the audio file, e.g. 'crow.wav'
%sounds and echoed sound
%OUTPUTS
%y - the array (n by 1 or n by 2) of echoed sound data
%f - sample rate 
function [y, f] = echoSound(filename)
[y_original,f] = audioread(filename);
%add 5000 sample buffer and 1/4 sample values of original audio to the end
y = [y_original; zeros(5000, size(y_original,2)); y_original*.25];
end

%The mix function will take in a list of audio files and return the sounds mixed.
%INPUTS
%filenames - a list of string filenames, e.g. ["cde.wav", "water.wav"], please note
%the list could have any number of files (2, or more)
%OUTPUTS
%y - the array (n by 1 or n by 2) of the mixed sounds
%f - sample rate 
function [y, f] = mix(filenames)
y = [0 0]; %initialize y to 2ch array

for i = 1:length(filenames) %loop through list of filenames
    
    [y_temp,f] = audioread(filenames(i)); %read in audio file
    
    if size(y_temp, 2) == 1 %if in 1ch, convert to 2ch
        y_temp = [y_temp, y_temp];
    end
    
    if size(y_temp, 1) > size(y, 1) %if new audio file is larger
        %expand y to match new larger dim, make equal to concatenation of
        %the section of the new audio file of the same length as the y 
        %added to y and the remainder of the new file.
        y(1:size(y_temp, 1), :) = [y_temp(1:size(y,1),:) + y; y_temp(size(y,1) + 1:end, :)];
    elseif size(y_temp, 1) < size(y, 1) %if new audio file is smaller
        %make y equal to the  concatenation of the section of y of the same 
        %length as the new audio file plus the new file and the remainder
        %of y.
        y = [y(1:size(y_temp,1), :) + y_temp; y(size(y_temp,1)+1:end,:)];
    else %if audio files are equal length
        %add both new and old files together.
        y = y+y_temp;
    end
    
end

end

%The removeVocals function will take in a file and return the audio with 
%the vocals removed.
%INPUTS
%filename - a string filename of the audio file, e.g. 'love.wav'
%OUTPUTS
%y - the array (n by 2) of sound data with vocals removed
%f - sample rate 
function [y, f] = removeVocals(filename)
[y_temp,f] = audioread(filename);
y = (y_temp(:,1)-y_temp(:,2))/2; %remove vocals
y = [y y]; %copy to both channels
end