function miki_edit
%MIKI_EDIT. Start the editor.

%
% Stephan Rave (stephan.rave@wwu.de) - 2012/10/12
%


global miki_lang miki_gui;

if strcmp(miki_lang, 'de')
    fprintf('\n');
    fprintf('MIKI - Editor\n');
    fprintf('--------------------------------------------------------------\n');
    fprintf('\n');
    fprintf('Pfeiltasten  Cursor bewegen\n');
    fprintf('w/a/s/d      Wand nördlich/westlich/südlich/östlich von Cursor\n');
    fprintf('             ein-/ausschalten\n');
    fprintf('+/-          Scheibe hinzufügen/entfernen\n');
    fprintf('Leertaste    positioniere Niki unter Cursor\n');
    fprintf('W,A,S,D      setze Blickrichtung von Niki\n');
    fprintf('v            setze Nikis Vorrat\n');
    fprintf('Escape       beende Editor\n');
    fprintf('\n');
    fprintf('--------------------------------------------------------------\n');
    fprintf('\n');
else
    fprintf('\n');
    fprintf('MIKI - Editor\n');
    fprintf('--------------------------------------------------------------\n');
    fprintf('\n');
    fprintf('Arrow keys   move cursor\n');
    fprintf('w/a/s/d      toggle wall north/west/south/east of cursor\n');
    fprintf('+/-          add/remove disk\n');
    fprintf('Leertaste    place Niki at current cursor position\n');
    fprintf('W,A,S,D      set Niki''s orientation\n');
    fprintf('c            set Niki''s supply\n');
    fprintf('Escape       exit editor\n');
    fprintf('\n');
    fprintf('--------------------------------------------------------------\n');
    fprintf('\n');
end

feval(miki_gui.edit);

end