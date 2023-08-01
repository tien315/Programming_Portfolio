%%Part 1, write the code the produces the animation provided.  Use the
%%function:
%%x goes from 1 to 50 with a step size of 1
%%y should be the cos(x/pi) for each x value
%%You will not be able to test this on Zybooks, so just get it working and show your grad TA. 
figure
lastColumn = 50;
%TODO_1:your code goes here. 
pause('on');
x = 0:50;
for i = 1:51
    plot(x(1:i),cos(x(1:i)./pi))
    xlim([0 50])
    ylim([-1 1])
    pause(.1);
end