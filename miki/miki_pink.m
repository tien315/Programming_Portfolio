function miki_pink
%
% Stephan Rave (stephan.rave@wwu.de) - 2012/10/16
%


global miki_gui;

miki_gui.pink = 1 - miki_gui.pink;

feval(miki_gui.setup);
miki_update_field;

end