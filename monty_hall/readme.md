"Suppose you are on a game show, and you're given the choice of three doors: Behind one door is a car; behind the others, goats.  You pick a door, say No. 1, and the host, who knows what's behind the doors, opens another door, say No. 3, which is a goat.  He then says to you, "Do you wannt to pick door No. 2?"  Is it to your advantage to switch your choice?"

See an explaination of the Monty Hall problem [here](https://en.wikipedia.org/wiki/Monty_Hall_problem).

The script uses the standard assumptions:
  1)  The host must always open a door that was not picked by the contestant.
  2)  The host must always open a door to reveal a goat and never the car.
  3)  The host must always offer the chance to switch between the originally chosen door and the remaining closed door.  

The script requests user input for the number of iterations, and assumes the number of doors is 3.

```Matlab
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
```
