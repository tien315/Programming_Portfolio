%More exploring Functions with Miki
%Alan Tieng
%CS 109, Spring 2020, Reckinger

function lab6(world)
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
while ~game_over
    locate_site;
    game_over = end_game_check;
end
turn_off;

%%This code can be used to test your solution
%***DO NOT CHANGE*******
globalVars = who('global')'; %notice the '
glob_str = sprintf('global %s',strjoin(globalVars));
%create them
eval(glob_str)
myAnswer = "mySolution_"+world;
save(myAnswer);
testMySolution(world);
%***DO NOT CHANGE*******

end

%TODO-add your new functions here
function locate_site
while front_clear && ~over_disk
    move;
end
if over_disk && front_clear
    pick_up;
    build_house;
end
end

function build_house
build_stilts;
build_walls;
build_roof;

%return to ground
turn_right;
move;
turn_right;
move;
move;
move;
turn_left;
%end position @ right stilt
end

function build_stilts
%movement and build pattern
%2 1
move;
turn_back;
drop;
move;
move;
drop;
end

function build_walls
%movement and build pattern
%234
%165
turn_right;
move;
drop;
move;
drop;
turn_right;
move;
drop;
move;
drop;
turn_right;
move;
drop;
turn_right;
move;
drop;
turn_right;
end

function build_roof
%place cap
move;
move;
drop;
end

function turn_back
turn_right;
turn_right;
end

function turn_left
turn_right;
turn_right;
turn_right;
end

function game_over = end_game_check
if ~front_clear
    game_over = true;
else
    game_over = false;
    move;
end
end
