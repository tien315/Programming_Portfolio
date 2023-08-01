function gib_ab
%GIB_AB Remove one disc from Niki's cargo and put it to the field.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/09/05
%

global miki_pos miki_cargo miki_discs miki_s_e_nocargo miki_s_e_full;

miki_check_running;

if hat_vorrat
    if miki_discs(miki_pos(2),miki_pos(1)) < 9
        miki_set_cargo(miki_cargo - 1);
        miki_discs(miki_pos(2),miki_pos(1)) = miki_discs(miki_pos(2),miki_pos(1)) + 1;
    else
        miki_set_status(miki_s_e_full);  % Error: there cannot be more than 9 discs on a field
    end
else
    miki_set_status(miki_s_e_nocargo);   % Error: Niki's cargo may not be empty
end

miki_update;

end