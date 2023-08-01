function result = hat_vorrat
%HAT_VORRAT Check Niki's cargo.
%   HAT_VORRAT returns false if Niki's cargo is empty. Otherwise,
%   HAT_VORRAT returns true.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/09/05
%


global miki_cargo;

miki_check_running;

result = miki_cargo > 0;

end