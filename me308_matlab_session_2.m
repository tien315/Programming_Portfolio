%{
In a script do the following:
Create a function that when called can output the factorial of an input
Define A = [1,2,3,5,7];
Define B = ‘abceg’;
Create a loop that goes through each element in A and B and 
1) Determines if it is a number or a character
2) Takes the factorial IF it is a number greater than 2 and adds it to C 
as a string
3) Add string to C
3)Print out result
Result should be a string C = ‘1a2b6c120e5040g’;
If this is too advanced, focus on looping through A and taking the 
factorial of each element if the number is greater than 2
%}

%a = [1 2 3 5 7];
%b = 'abceg';

b = [1 2 3 5 7 10 15 20];
a = 'abceg';
exercise_2(a,b)

function [c] = exercise_2(a,b)

%find shorter string or vector
if length(a)>=length(b)
    sz = length(b);
    rm = length(a)-length(b);
else
    sz = length(a);
    rm = length(b)-length(a);
end

%check types for the first input
if isa(a(1), 'double')
    if (a(1)>2)
        c = num2str(factorial(a(1)));
    else 
        c = num2str(a(1));
    end
else
    c = a(1);
end
if isa(b(1), 'double')
    if (b(1)>2)
        c = [c,num2str(factorial(b(1)))];
    else
        c = [c,num2str(b(1))];
    end
else
    c = [c,b(1)];
end

%loop through 2nd to end
for i = 2:sz
    if isa(a(i), 'double')
        if (a(i)>2)
            c = [c,num2str(factorial(a(i)))];
        else
            c = [c,num2str(a(i))];
        end
    else
        c = [c,a(i)];
    end
    
    if isa(b(i), 'double')
        if (b(i)>2)
            c = [c,num2str(factorial(b(i)))];
        else
            c = [c,num2str(b(i))];
        end
    else 
        c = [c,b(i)];
    end
    disp(c)
end
%add on remainder of the longer string
%for i = len+1:len+rem
    
return
end