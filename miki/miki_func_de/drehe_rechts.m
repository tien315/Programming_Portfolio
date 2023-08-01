function drehe_rechts
%DREHE_RECHTS Turn Niki 90 degrees clockwise.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/09/05
%

global miki_dir;

miki_check_running;

miki_dir = mod(miki_dir-2, 4) + 1;
miki_update;

end