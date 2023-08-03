function miki_lang( lang )
%MIKI_LANG Sets the language of the GUI

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/10/12
%

global miki_lang;

if ~strcmp(lang, 'de') && ~strcmp(lang, 'en')
    error('Unsupported language! (Choose ''de'' or ''en'')');
end

miki_lang = lang;

end

