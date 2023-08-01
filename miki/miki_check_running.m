function miki_check_running
%MIKI_CHECK_RUNNING Check if Niki is still running.
%   MIKI_CHECK_RUNNING checks if Niki is still in running state. If not,
%   an error is thrown. Not to be called directly.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/10/12
%


global miki_lang miki_status miki_s_running;

% Niki can only perform operations if he is in running state. So
% throw an error if this is not the case.
if miki_status ~= miki_s_running
    if strcmp(miki_lang, 'de')
        error('Niki ist abgeschaltet!');
    else
        error('Niki is no longer running!');
    end
end
    
end