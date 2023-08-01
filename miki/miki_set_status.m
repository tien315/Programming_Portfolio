function miki_set_status(s)
%MIKI_SET_STATUS. Set Niki's status.
%   MIKI_SET_STATUS(s) sets Niki's status to s and updates the ui.
%   Not to be called directly.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/09/05
%


global miki_status;

miki_status = s;
miki_update_gui;
    
end