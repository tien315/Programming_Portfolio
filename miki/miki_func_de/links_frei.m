function result = links_frei
%LINKS_FREI Check if there is a wall to the left.
%   LINKS_FREI returns false if there is a wall to Niki's left.
%   If there is no wall, LINKS_FREI returns true.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/09/05
%


global miki_pos miki_dir miki_hwalls miki_vwalls;

miki_check_running;

switch miki_dir
    case 4
        result = 1 - miki_hwalls(miki_pos(2),miki_pos(1) + 1);
    case 1
        result = 1 - miki_vwalls(miki_pos(2)+1,miki_pos(1));
    case 2
        result = 1 - miki_hwalls(miki_pos(2),miki_pos(1));
    case 3
        result = 1 - miki_vwalls(miki_pos(2),miki_pos(1));
end

end