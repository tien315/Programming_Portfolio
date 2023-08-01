function miki_update_gui
%MIKI_UPDATE_UI. Update the state of the ui. Not to be called directly.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/10/12
%


global miki_status miki_cargo;
global miki_lang miki_gui miki_s_running miki_status_msg;

set(miki_gui.u_status, 'String', miki_status_msg{miki_status});

if miki_gui.running
    set(miki_gui.u_run, 'String', 'Pause');
    set(miki_gui.u_step, 'Enable', 'off');
else
    set(miki_gui.u_run, 'String', 'Run');
    set(miki_gui.u_step, 'Enable', 'on');
end

if miki_status ~= miki_s_running
    set(miki_gui.u_step, 'Enable', 'off');
    set(miki_gui.u_run, 'Enable', 'off');
    set(miki_gui.u_status, 'ForegroundColor', [1 0 0]);
end

set(miki_gui.u_speed, 'Value', miki_gui.speed);

if strcmp(miki_lang, 'de')
    set(miki_gui.u_cargo, 'String', sprintf('Vorrat: %d', miki_cargo));
else
    set(miki_gui.u_cargo, 'String', sprintf('Supply: %d', miki_cargo));
end

end