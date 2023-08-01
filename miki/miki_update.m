function miki_update
%MIKI_UPDATE. Redraw field and wait.
%   MIKI_UPDATE redraws the field. If the ui is in 'step' mode, halt the
%   execution again. If the ui is in 'run' mode, wait some time.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/09/05
%


global miki_gui;

miki_update_field;
drawnow;
if miki_gui.step
    miki_gui.step = 0;
    uiwait(miki_gui.f);
%else
    %pause(0.0001);
    %pause(0.25 + (10000 - miki_gui.speed^2) / 5000);
end
    
end