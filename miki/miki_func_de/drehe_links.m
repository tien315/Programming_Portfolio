function drehe_links
%DREHE_LINKS Turn Niki 90 degrees counterclockwise.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/09/05
%

global miki_dir;

miki_check_running;

miki_dir = mod(miki_dir, 4) + 1;
miki_update;

end