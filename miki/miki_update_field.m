function miki_update_field
%MIKI_UPDATE_FIELD Draw the field. Not to be called directly.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/09/05
%

global miki_pos miki_dir;
global miki_discs miki_hwalls miki_vwalls;
global miki_im_discs miki_im_niki miki_gui;


% check if main window is still open
if ~ishandle(miki_gui.f)
    error('Miki-Fenster wurde geschlossen');
end

% activae main window and clear the field
set(0,'CurrentFigure',miki_gui.f)
cla;

fh = size(miki_discs,1);
fw = size(miki_discs,2);

lw = miki_gui.line_width;
fs = miki_gui.field_size;

% draw empty fields and discs
for x = 1:fw
    for y = 1:fh
        image([(x-1)*fs,x*fs-1],[(y-1)*fs,y*fs-1],miki_im_discs{miki_discs(y,x)+1}, 'Clipping', 'off');
    end
end

% draw Niki
image([(miki_pos(1)-1)*fs,miki_pos(1)*fs-1],[(miki_pos(2)-1)*fs,miki_pos(2)*fs-1], ...
    miki_im_niki{miki_dir}, 'Clipping', 'off' );

% draw walls in horizontal directions (the walls themselves are vertical)
for x = 1:(fw+1)
    for y = 1:fh
        if miki_hwalls(y,x)
            if lw >= 3
                line([x-1,x-1]*fs,[(y-1)*fs-1,y*fs+1], 'LineWidth', lw, 'Clipping', 'off');
            else
                line([x-1,x-1]*fs,[(y-1)*fs,y*fs+1], 'LineWidth', lw, 'Clipping', 'off');
            end
        end
    end
end

% draw walls in vertical directions (the walls themselves are horizontal)
for x = 1:fw
    for y = 1:(fh+1)
        if miki_vwalls(y,x)
            line([x-1,x]*fs,[y-1,y-1]*fs, 'LineWidth', lw, 'Clipping', 'off');
        end
    end
end
    
    
end