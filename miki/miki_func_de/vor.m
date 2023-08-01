function vor
%VOR Move one field forward.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/09/05
%


global miki_pos miki_dir miki_s_e_wall;

miki_check_running;

if vorne_frei
    switch miki_dir
        case 1
            miki_pos(1) = miki_pos(1) + 1;
        case 2
            miki_pos(2) = miki_pos(2) + 1;
        case 3
            miki_pos(1) = miki_pos(1) - 1;
        case 4
            miki_pos(2) = miki_pos(2) - 1;
    end
else
    miki_set_status(miki_s_e_wall);     % Error: Niki hits a wall
end

miki_update;

end