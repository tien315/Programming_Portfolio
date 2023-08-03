filenames = ["welcome.wav", "door.wav", "welcome.wav" , "door.wav","welcome.wav", "door.wav"];

y = [0 0];
array = 0;
for i = 1:length(filenames)
    [y_temp,f] = audioread(filenames(i));
    len = length(y_temp);
    array = [array, len];
    
    
end