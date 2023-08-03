function miki_init(varargin)
%MIKI_INIT Open miki main window and create or load a field.
%   MIKI_INIT creates a new field with width 20 and height 15.
%
%   MIKI_INIT(WIDTH,HEIGHT) creates a new field with width WIDTH and
%   height HEIGHT.
%
%   MIKI_INIT(PATH) loads the field from file PATH.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/10/12x=4
%

global miki_gui;
global miki_lang;

if isempty(miki_lang)
    miki_lang = 'en';
end

% check if we call miki_init the first time; if yes, add 'miki'
% subdir to path and display welcome message.
if isempty(miki_gui)
    addpath miki;
    addpath miki/miki_func_de;
    addpath miki/miki_func_en;
    if strcmp(miki_lang, 'de')
        fprintf('\nMIKI - NIKI der Roboter für Matlab v0.1\n\n');
    else
        fprintf('\nMIKI - NIKI the Robot for Matlab v0.1\n\n');
    end
end

% let miki_init2 do the real work
miki_init2(varargin{:});

end