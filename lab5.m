%Exporing Functions with Miki
%Alan Tieng
%CS 109, Spring 2020, Reckinger
function lab5(world, test)
%***DO NOT CHANGE*******
save temp
clear all;
close all;
load temp;
miki_init(world)
%***DO NOT CHANGE*******

%{
Miki Controls
turn_right; turns Miki 90 deg to the right
move; moves Miki one space forward
right_clear; is true if the space to the right of Miki is clear (has no
wall)
left_clear; is true if the space to the left of Miki is clear (has no wall)
front_clear; is true if the space in front of Miki is clear (has no wall)
pick_up; has Miki pick up a disk (Miki and disk must both be on the spot)
over_disk; is true if Miki is standing on a disk
has_disk; is true if Miki has any disks
drop; has Miki place a disk on the spot Miki is on
turn_off; ends the game
%}

%TODO-your code goes here
game_over = false;
pick_up;
while ~game_over
    up_the_step;
    game_over = check_disk;
end
turn_off;

%%This code can be used to test your solution
%***DO NOT CHANGE*******
if (test)
globalVars = who('global')'; %notice the '
glob_str = sprintf('global %s',strjoin(globalVars));
%create them
eval(glob_str)
myAnswer = "mySolution_"+world;
save(myAnswer);
testMySolution(world);
%***DO NOT CHANGE*******
end
end

%TODO-add your new functions here
%call to move up one step
function up_the_step
turn_left; %turn left
%drehe_links; %german function to turn left
while ~right_clear
    move;
end
turn_right;
while front_clear
    move;
end
end

%pick up disks and if there are two disks, end the game
function game_over = check_disk
if over_disk
    pick_up;
end
if over_disk
    game_over = true;
else
    game_over = false;
end
end

%turn left by turning right x3
function turn_left 
turn_right;
turn_right;
turn_right;
end

%lab6('united_nations_A.mat')