function miki_pause
%MIKI_PAUSE. Pause program execution.
%   MIKI_PAUSE pauses the program execution until the user hits the
%   'run' or 'step' button in the MIKI ui.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/09/05
%


global miki_gui;

feval(miki_gui.pause);
    
end