function nimm_auf
%NIMM_AUF Remove one disc from field and add it to Niki's cargo.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/09/05
%


global miki_pos miki_cargo miki_discs miki_s_e_empty

miki_check_running;

if platz_belegt
    miki_set_cargo(miki_cargo + 1);
    miki_discs(miki_pos(2),miki_pos(1)) = miki_discs(miki_pos(2),miki_pos(1)) - 1;
else
    miki_set_status(miki_s_e_empty);    % Error: there is no disc!
end

miki_update;

end