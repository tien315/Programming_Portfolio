function testMySolution(world)
myAnswer = "mySolution_"+world;
load(myAnswer);
miki_cargoS = miki_cargo;
miki_posS = miki_pos;
miki_discsS = miki_discs;

refSolution = "refSolution_" + world;
load(refSolution);

if (miki_cargoS==miki_cargo)
    disp("CORRECT: Miki has all the discs");
else
    disp("INCORRECT: Miki does not have all the discs");
end
if miki_posS==miki_pos
    disp("CORRECT: Miki is in the final position");
else
    disp("INCORRECT: Miki is not in the final position");
end
if miki_discsS==miki_discs
    disp("CORRECT: You picked up the all the disks except the last one");
else
    disp("INCORRECT: You did not picked up the all the disks");
end

end