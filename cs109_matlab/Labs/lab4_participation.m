n = input('Enter a number to sum(-77 to stop): '); %assigns user input to n
array = []; %initialize array array
ct= 0; %initialize ct
while(n ~= -77) %while user input ~= -77
    ct = ct + 1; %increase ct by 1
    array(ct) = n; %assign n to array at index ct
    n = input('Enter a number to sum (-77 to stop): '); %ask for user input and assign to n
end %end of loop
disp("Sentinel loop done! Here is the array: "); %display message
disp(array) %display array
display(ct) %display ct