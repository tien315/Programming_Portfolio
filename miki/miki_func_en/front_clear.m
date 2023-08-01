function result = front_clear
%FRONT_CLEAR Check if there is a wall in front of Niki.
%   FRONT_CLEAR returns false if there is a wall in front of Niki.
%   If there is no wall, VORNE_FREI returns true.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/10/12
%

% just call the corresponding german named function
result = vorne_frei;

end