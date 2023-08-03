clear all;
close all;
clc;
win = 0;
loss = 0;
n = 0;
doors = 3;

iter = input('How many iterations? ');

while n < iter
    goal = randi(doors);
    choice = randi(doors);

    %pick a door to eliminate that is neither goal nor choice
    while true
        elimination = randi(doors);
        if elimination ~= goal && elimination ~= choice
            break
        end
    end
    
    %pick a new choice that is neither the eliminated door nor the first
    %choice.
    while true
        new_choice = randi(doors);
        if new_choice ~= elimination && new_choice ~= choice
            break;
        end
    end
    
    %tally wins and losses
    if new_choice == goal
        win = win + 1;
        %Dwin = true;
    else
        loss = loss + 1;
        %Dwin = false;
    end
    
    n = n+1;

end

%display the win percentage
disp("Win rate: " + win/(win+loss)*100+"%");