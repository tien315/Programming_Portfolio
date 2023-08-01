function miki_init2(arg1, arg2)
%MIKI_INIT2 Main initialization routine. Not to be called directly.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/10/16
%

global miki_lang;       % either 'de' or 'en'
global miki_pos;        % Niki's current position
global miki_dir;        % Niki's orientation
global miki_cargo;      % the amount of discs Niki carries
global miki_status;     % Niki's current status
global miki_discs;      % discs on the field
global miki_hwalls;     % horizontal walls
global miki_vwalls;     % vertical walls
global miki_gui;        % struct containing all gui related stuff


% Setup global constants

% constants encoding Niki's state
global miki_s_running miki_s_deactivated miki_s_e_wall miki_s_e_nocargo;
global miki_s_e_empty miki_s_e_full miki_status_msg;

miki_s_running       = 1;       % Niki is running
miki_s_deactivated   = 2;       % Niki has successfully shut down
miki_s_e_wall        = 3;       % Error: Niki hit a wall
miki_s_e_nocargo     = 4;       % Error: Niki is out of cargo
miki_s_e_empty       = 5;       % Error: Niki tried to take a disc from empty field
miki_s_e_full        = 6;       % Error: Niki tried to put a dist onto full field

% status messages
if strcmp(miki_lang, 'de')
    miki_status_msg{1} = 'Eingeschaltet';
    miki_status_msg{2} = 'Erfolgreich abgeschaltet!';
    miki_status_msg{3} = 'Fehler! Kollision mit Wand! Notabschaltung!';
    miki_status_msg{4} = 'Fehler! Kein Vorrat mehr! Notabschaltung!';
    miki_status_msg{5} = 'Fehler! Feld ist leer, kann nichts aufnehmen! Notabschaltung!';
    miki_status_msg{6} = 'Fehler! Feld ist voll, kann nichts ablegen! Notabschaltung!';
else
    miki_status_msg{1} = 'Turned on';
    miki_status_msg{2} = 'Turned off successfully!';
    miki_status_msg{3} = 'Error! Collision with wall! Emergency shutdown!';
    miki_status_msg{4} = 'Error! Supply empty! Emergency shutdown!';
    miki_status_msg{5} = 'Error! Field is empty, cannot pick up disk! Emergency shutdown!';
    miki_status_msg{6} = 'Error! Field is full, cannot drop disk! Emergency shutdown!';
end

% Parse Arguments
newfield = 0;
fw = 20;
fh = 15;
path = '';
if nargin >= 1
    if nargin >= 2
        if nargin > 3
            usage;
        end
        fw = arg1;
        fh = arg2;
        if (fw <= 0) || (fh <= 0)
            usage;
        end
        newfield = 1;
    elseif ~ischar(arg1)
        usage;
    else
        path = arg1;
    end
else
    newfield = 1;
end


% setup field
if newfield
    miki_pos = [1 1];
    miki_dir = 1;
    miki_cargo = 10;
    miki_discs  = zeros(fh,  fw);
    miki_hwalls = zeros(fh,  fw+1);
    miki_vwalls = zeros(fh+1,fw);
    miki_hwalls(:,1) = 1;
    miki_hwalls(:,end) = 1;
    miki_vwalls(1,:) = 1;
    miki_vwalls(end,:) = 1;
else
    load(path)
end

% Niki starts in running state
miki_status = miki_s_running;

% If the gui hasn't been open before, set some default values
if isempty(miki_gui)
    miki_gui.size    = 3;
    miki_gui.speed   = 75;
    miki_gui.pink    = 0;
    miki_gui.edit  = @start_edit;
    miki_gui.pause = @start_pause;
    miki_gui.setup = @setup_gui;
end

% the gui starts in 'run' mode
miki_gui.step    = 0;
miki_gui.running = 1;

% create the gui
setup_gui;

% draw the field
miki_update_field;

end


function setup_gui

global miki_gui miki_im_discs miki_im_niki miki_discs;

% load graphics
switch miki_gui.size
    case 1
        miki_im_discs{1}  = flipdim(imread('miki/gfx/empty.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{2}  = flipdim(imread('miki/gfx/disc1.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{3}  = flipdim(imread('miki/gfx/disc2.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{4}  = flipdim(imread('miki/gfx/disc3.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{5}  = flipdim(imread('miki/gfx/disc4.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{6}  = flipdim(imread('miki/gfx/disc5.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{7}  = flipdim(imread('miki/gfx/disc6.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{8}  = flipdim(imread('miki/gfx/disc7.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{9}  = flipdim(imread('miki/gfx/disc8.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{10} = flipdim(imread('miki/gfx/disc9.png', 'BackgroundColor', [1 1 1]),1);
        if miki_gui.pink
            miki_im_niki{1}  = flipdim(imread('miki/gfx/niki_r_r.png', 'BackgroundColor', [1 1 1]),1);
            miki_im_niki{2}  = flipdim(imread('miki/gfx/niki_r_u.png', 'BackgroundColor', [1 1 1]),1);
            miki_im_niki{3}  = flipdim(imread('miki/gfx/niki_r_l.png', 'BackgroundColor', [1 1 1]),1);
            miki_im_niki{4}  = flipdim(imread('miki/gfx/niki_r_d.png', 'BackgroundColor', [1 1 1]),1);
        else
            miki_im_niki{1}  = flipdim(imread('miki/gfx/niki_r.png', 'BackgroundColor', [1 1 1]),1);
            miki_im_niki{2}  = flipdim(imread('miki/gfx/niki_u.png', 'BackgroundColor', [1 1 1]),1);
            miki_im_niki{3}  = flipdim(imread('miki/gfx/niki_l.png', 'BackgroundColor', [1 1 1]),1);
            miki_im_niki{4}  = flipdim(imread('miki/gfx/niki_d.png', 'BackgroundColor', [1 1 1]),1);
        end
        
        miki_gui.field_size = 48;
        miki_gui.control_height = 22;
        miki_gui.control_sep = 5;
        miki_gui.line_width = 3;
        
    case 2
        miki_im_discs{1}  = flipdim(imread('miki/gfx/empty_medium.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{2}  = flipdim(imread('miki/gfx/disc1_medium.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{3}  = flipdim(imread('miki/gfx/disc2_medium.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{4}  = flipdim(imread('miki/gfx/disc3_medium.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{5}  = flipdim(imread('miki/gfx/disc4_medium.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{6}  = flipdim(imread('miki/gfx/disc5_medium.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{7}  = flipdim(imread('miki/gfx/disc6_medium.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{8}  = flipdim(imread('miki/gfx/disc7_medium.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{9}  = flipdim(imread('miki/gfx/disc8_medium.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{10} = flipdim(imread('miki/gfx/disc9_medium.png', 'BackgroundColor', [1 1 1]),1);
        if miki_gui.pink
            miki_im_niki{1}  = flipdim(imread('miki/gfx/niki_r_r_medium.png', 'BackgroundColor', [1 1 1]),1);
            miki_im_niki{2}  = flipdim(imread('miki/gfx/niki_r_u_medium.png', 'BackgroundColor', [1 1 1]),1);
            miki_im_niki{3}  = flipdim(imread('miki/gfx/niki_r_l_medium.png', 'BackgroundColor', [1 1 1]),1);
            miki_im_niki{4}  = flipdim(imread('miki/gfx/niki_r_d_medium.png', 'BackgroundColor', [1 1 1]),1);
        else
            miki_im_niki{1}  = flipdim(imread('miki/gfx/niki_r_medium.png', 'BackgroundColor', [1 1 1]),1);
            miki_im_niki{2}  = flipdim(imread('miki/gfx/niki_u_medium.png', 'BackgroundColor', [1 1 1]),1);
            miki_im_niki{3}  = flipdim(imread('miki/gfx/niki_l_medium.png', 'BackgroundColor', [1 1 1]),1);
            miki_im_niki{4}  = flipdim(imread('miki/gfx/niki_d_medium.png', 'BackgroundColor', [1 1 1]),1);
        end
        
        miki_gui.field_size = 32;
        miki_gui.control_height = 22;
        miki_gui.control_sep = 5;
        miki_gui.line_width = 3;
        
    case 3
        miki_im_discs{1}  = flipdim(imread('miki/gfx/empty_low.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{2}  = flipdim(imread('miki/gfx/disc1_low.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{3}  = flipdim(imread('miki/gfx/disc2_low.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{4}  = flipdim(imread('miki/gfx/disc3_low.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{5}  = flipdim(imread('miki/gfx/disc4_low.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{6}  = flipdim(imread('miki/gfx/disc5_low.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{7}  = flipdim(imread('miki/gfx/disc6_low.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{8}  = flipdim(imread('miki/gfx/disc7_low.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{9}  = flipdim(imread('miki/gfx/disc8_low.png', 'BackgroundColor', [1 1 1]),1);
        miki_im_discs{10} = flipdim(imread('miki/gfx/disc9_low.png', 'BackgroundColor', [1 1 1]),1);
        if miki_gui.pink
            miki_im_niki{1}  = flipdim(imread('miki/gfx/niki_r_r_low.png', 'BackgroundColor', [1 1 1]),1);
            miki_im_niki{2}  = flipdim(imread('miki/gfx/niki_r_u_low.png', 'BackgroundColor', [1 1 1]),1);
            miki_im_niki{3}  = flipdim(imread('miki/gfx/niki_r_l_low.png', 'BackgroundColor', [1 1 1]),1);
            miki_im_niki{4}  = flipdim(imread('miki/gfx/niki_r_d_low.png', 'BackgroundColor', [1 1 1]),1);
        else
            miki_im_niki{1}  = flipdim(imread('miki/gfx/niki_r_low.png', 'BackgroundColor', [1 1 1]),1);
            miki_im_niki{2}  = flipdim(imread('miki/gfx/niki_u_low.png', 'BackgroundColor', [1 1 1]),1);
            miki_im_niki{3}  = flipdim(imread('miki/gfx/niki_l_low.png', 'BackgroundColor', [1 1 1]),1);
            miki_im_niki{4}  = flipdim(imread('miki/gfx/niki_d_low.png', 'BackgroundColor', [1 1 1]),1);
        end
        
        miki_gui.field_size = 24;
        miki_gui.control_height = 22;
        miki_gui.control_sep = 5;
        miki_gui.line_width = 2;        
end

% if there is already a window open, activate and empty it; otherwise
% create new figure
if isfield(miki_gui, 'f')
    figure(miki_gui.f)
    clf;
else
    miki_gui.f = figure;
    set(gcf, 'Position', [0 0 100 100]);
end

fh = size(miki_discs,1);            % width of field
fw = size(miki_discs,2);            % height of field
fs = miki_gui.field_size;
ch = miki_gui.control_height;
cs = miki_gui.control_sep;

% setup figure
set(gcf, 'Resize', 'off');
p = get(gcf, 'Position');
p(3:4) = [fw*fs+2*cs fh*fs+3*cs+ch];
set(gcf, 'Position', p);

% setup axes
miki_gui.a = axes;
axis image;
set(miki_gui.a, 'Units', 'pixels')
set(gca, 'Position', [cs 2*cs+ch fw*fs fh*fs]);
axis([0 fw*fs 0 fh*fs]);
axis off;
hold on;

% create uicontrols
miki_gui.u_step   = uicontrol('Style', 'pushbutton', 'String', 'Step', ...
                              'Position', [cs cs 50 ch], 'Callback', @callback_step);
miki_gui.u_run    = uicontrol('Style', 'pushbutton', ...
                              'Position', [100 cs 50 ch], 'Callback', @callback_run);
miki_gui.u_speed  = uicontrol('Style', 'slider', 'Min',0,'Max',100, ...
                              'Position', [200 cs 100 ch], 'Callback', @callback_speed);
miki_gui.u_zoom   = uicontrol('Style', 'popup', 'String', '100%|75%|50%', 'Value', miki_gui.size, ...
                              'Position', [300 cs 55 ch], 'Callback', @callback_zoom);
miki_gui.u_cargo  = uicontrol('Style', 'pushbutton', 'HorizontalAlignment', 'left', ...
                              'Position', [400 cs 75 ch], 'Enable', 'inactive');
miki_gui.u_status = uicontrol('Style', 'pushbutton', 'HorizontalAlignment', 'left', ...
                              'Position', [500 cs 600 ch], 'Enable', 'inactive');
                          
% align uicontrols                          
align([miki_gui.u_step, miki_gui.u_run, miki_gui.u_speed, miki_gui.u_zoom, miki_gui.u_cargo, miki_gui.u_status], ...
    'Fixed', 0, 'Bottom');
p = get(miki_gui.u_status, 'Position');
p(3) = cs+fw*fs - p(1);
if p(3) < 1
    p(3) = 1;
end
set(miki_gui.u_status, 'Position', p);

% set state of ui elements
miki_update_gui;

end


function start_edit
% enter edit mode

global miki_gui

% disable uicontrols
set(miki_gui.u_step, 'Enable', 'off');
set(miki_gui.u_run,  'Enable', 'off');

% setup editor
miki_gui.edit_pos = [1 1];
draw_crosshairs(miki_gui.edit_pos);
set(gcf, 'KeyPressFcn', @callback_edit_key);

% activate figure and wait for user input
figure(miki_gui.f);
uiwait(miki_gui.f);

end


function start_pause
% switch to 'pause' mode

global miki_gui;

set(miki_gui.u_run, 'String', 'Run');
set(miki_gui.u_step, 'Enable', 'on');
miki_gui.running = 0;
uiwait(miki_gui.f);

end


function callback_run(source, ~)
% callback for 'run' button

global miki_gui;

caption = get(source, 'String');
if strcmp(caption, 'Run')                       % 'run' pressed
    set(source, 'String', 'Pause');
    set(miki_gui.u_step, 'Enable', 'off');
    miki_gui.running = 1;
    uiresume;
else                                            % 'pause' pressed
    set(source, 'String', 'Run');
    set(miki_gui.u_step, 'Enable', 'on');
    miki_gui.running = 0;
    uiwait(miki_gui.f);
end

end


function callback_step(~, ~)
% callback for 'step' button

global miki_gui;

% we are in step mode and want to halt after next instruction
% see 'miki_update'
miki_gui.step = 1;
uiresume;

end


function callback_speed(source, ~)
% callfack for 'speed' slider

global miki_gui;

miki_gui.speed = get(source, 'Value');

end


function callback_zoom(source, ~)
% callback for 'zoom' popup

global miki_gui;

% set the gui_size and redraw everthing
miki_gui.size = get(source, 'Value');
setup_gui;
miki_update_field;

end


function draw_crosshairs(pos)

global miki_gui;

fs = miki_gui.field_size;
lw = 3;
line([pos(1)-0.9,pos(1)-0.7]*fs, [pos(2)-0.5,pos(2)-0.5]*fs, ...
    'LineWidth', lw, 'Color', [0 1 0]);
line([pos(1)-0.3,pos(1)-0.1]*fs, [pos(2)-0.5,pos(2)-0.5]*fs, ...
    'LineWidth', lw, 'Color', [0 1 0]);
line([pos(1)-0.5,pos(1)-0.5]*fs, [pos(2)-0.9,pos(2)-0.7]*fs, ...
    'LineWidth', lw, 'Color', [0 1 0]);
line([pos(1)-0.5,pos(1)-0.5]*fs, [pos(2)-0.3,pos(2)-0.1]*fs, ...
    'LineWidth', lw, 'Color', [0 1 0]);

end


function callback_edit_key(~, event)
% callback for keypresses in edit mode

global miki_lang miki_gui;
global miki_pos miki_dir miki_cargo;
global miki_discs miki_hwalls miki_vwalls;

fh = size(miki_discs,1);
fw = size(miki_discs,2);
ep = miki_gui.edit_pos;

% which button has been pressed?
switch event.Character
    
    case 27  % escape
        set(gcf, 'KeyPressFcn', []);
        set(miki_gui.u_run, 'String', 'Pause');
        set(miki_gui.u_run, 'Enable', 'on');
        miki_update_field;
        uiresume;
        
    case 28  % left
        miki_gui.edit_pos(1) = ep(1) - 1;
        if miki_gui.edit_pos(1) == 0
            miki_gui.edit_pos(1) = fw;
        end
        miki_update_field;
        draw_crosshairs(miki_gui.edit_pos);
        
    case 29  % right
        miki_gui.edit_pos(1) = ep(1) + 1;
        if miki_gui.edit_pos(1) > fw
            miki_gui.edit_pos(1) = 1;
        end
        miki_update_field;
        draw_crosshairs(miki_gui.edit_pos);
        
    case 30  % up
        miki_gui.edit_pos(2) = ep(2) + 1;
        if miki_gui.edit_pos(2) > fh
            miki_gui.edit_pos(2) = 1;
        end
        miki_update_field;
        draw_crosshairs(miki_gui.edit_pos);
        
    case 31  % down
        miki_gui.edit_pos(2) = ep(2) - 1;
        if miki_gui.edit_pos(2) == 0
            miki_gui.edit_pos(2) = fh;
        end
        miki_update_field;
        draw_crosshairs(miki_gui.edit_pos);
        
    case 'w'
        if ep(2) < fh
            miki_vwalls(ep(2)+1,ep(1)) = 1 - miki_vwalls(ep(2)+1,ep(1));
            miki_update_field;
            draw_crosshairs(miki_gui.edit_pos);
        end
        
    case 's'
        if ep(2) > 1
            miki_vwalls(ep(2),ep(1)) = 1 - miki_vwalls(ep(2),ep(1));
            miki_update_field;
            draw_crosshairs(miki_gui.edit_pos);
        end
        
    case 'd'
        if ep(1) < fw
            miki_hwalls(ep(2),ep(1)+1) = 1 - miki_hwalls(ep(2),ep(1)+1);
            miki_update_field;
            draw_crosshairs(miki_gui.edit_pos);
        end
        
    case 'a'
        if ep(1) > 1
            miki_hwalls(ep(2),ep(1)) = 1 - miki_hwalls(ep(2),ep(1));
            miki_update_field;
            draw_crosshairs(miki_gui.edit_pos);
        end
        
    case '+'
        miki_discs(ep(2),ep(1)) = mod(miki_discs(ep(2),ep(1))+1,10);
        miki_update_field;
        draw_crosshairs(miki_gui.edit_pos);
        
    case '-'
        miki_discs(ep(2),ep(1)) = mod(miki_discs(ep(2),ep(1))-1,10);
        miki_update_field;
        draw_crosshairs(miki_gui.edit_pos);
        
    case ' '
        miki_pos = ep;
        miki_update_field;
        draw_crosshairs(miki_gui.edit_pos);
        
    case 'D'
        miki_dir = 1;
        miki_update_field;
        draw_crosshairs(miki_gui.edit_pos);
        
    case 'W'
        miki_dir = 2;
        miki_update_field;
        draw_crosshairs(miki_gui.edit_pos);
        
    case 'A'
        miki_dir = 3;
        miki_update_field;
        draw_crosshairs(miki_gui.edit_pos);
        
    case 'S'
        miki_dir = 4;
        miki_update_field;
        draw_crosshairs(miki_gui.edit_pos);
        
    case {'v', 'c'}
        if strcmp(miki_lang, 'de')
            answer = inputdlg('Neuer Vorrat:', 'Vorrat setzen', 1, {num2str(miki_cargo)});
        else
            answer = inputdlg('New supply:', 'Set Supply', 1, {num2str(miki_cargo)});
        end
        nc = floor(str2double(answer));
        if nc < 0 || isnan(nc)
            nc = 0;
        end
        if nc > 99
            nc = 99;
        end
        miki_set_cargo(nc);
        miki_update_field;
        draw_crosshairs(miki_gui.edit_pos);
        
end

end


function usage

error('Aufruf: miki_init breite höhe  oder   miki_init feldname ');

end
