function miki_save(path)
% MIKI_SAVE Save field.
%   MIKI_SAVE(path) writes the current state of the field to the file
%   given by path.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/09/05
%


global miki_pos miki_dir miki_cargo; 
global miki_discs miki_hwalls miki_vwalls;

save(path, 'miki_pos', 'miki_dir', 'miki_cargo', ...
           'miki_discs', 'miki_hwalls', 'miki_vwalls' );

end