function abschalten
%ABSCHALTEN Set Niki to halting state.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/10/12
%

global miki_lang miki_s_deactivated;

miki_set_status(miki_s_deactivated);

if strcmp(miki_lang, 'de')
    disp('Niki hat sich abgeschaltet!');
else
    disp('Niki has shut down!');
end

end
