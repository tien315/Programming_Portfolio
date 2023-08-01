function result = platz_belegt
%PLATZ_BELEGT Check if there is a disc under Niki.
%   PLATZ_BELEGT returns true if there is a disc on Niki's field.
%   Otherwise, PLATZ_BELEGT returns false.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/09/05
%


global miki_pos miki_discs;

miki_check_running;

result = miki_discs(miki_pos(2),miki_pos(1)) > 0;

end