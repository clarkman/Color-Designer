function drawSwatches()

pal=getPalette();
sz = size(pal);
% names = pal.colorNames;
% colors = pal.colors;
numColors = sz(2);

Xs = [-1,0,0,-1,-1];
Ys = [0,0,1,1,0];

hndl=getSwatchAxesHandle();
axes(hndl);
cla;

colrNames={};
for s = 1 : numColors
    patch(Xs+s,Ys,pal(s).colors, ...
    'UserData',pal(s), ...
    'ButtonDownFcn',@swatchCallback )
    colrNames = [colrNames, pal(s).colorNames];
end

sw=1:numColors;
set(hndl,'XTick',[sw-0.5]);
set(hndl,'YTick',[]);
set(hndl,'XTickLabel',colrNames);
set(hndl,'YTickLabel',{});
set(hndl,'FontSize',10)

