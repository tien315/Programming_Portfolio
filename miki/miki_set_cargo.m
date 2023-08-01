function miki_set_cargo(c)
%MIKI_SET_CARGO. Set Niki's cargo.
%   MIKI_SET_CARGO(c) sets Niki's cargo to c and updates the ui.
%   Not to be called directly.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/09/05
%


global miki_cargo;

miki_cargo = c;
miki_update_gui;
    
end