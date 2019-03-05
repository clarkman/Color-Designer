function createSwatchPanel();


prompt = {'Enter palette name:'};
dlg_title = 'Save Palette ...';
num_lines = 1;
defaultans = {'My palette'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
if isempty( answer )
	return
end

pal = getPalette();
sz = size(pal);
numColors=sz(2);

h=2;
w=2*numColors;

Xs = [ 0, 2, 2, 0, 0 ] - 2;
Ys = [ 0, 0, 2, 2, 0 ];

figure;
%line(Xs,Ys,'Color','k')

ticks = (1:numColors) * 2 - 1;

colrNames={};
for s = 1 : numColors
    patch(Xs+s*2,Ys,pal(s).colors)
    colrNames = [colrNames, pal(s).colorNames];
end

set(gca,'XTick',ticks);
set(gca,'YTick',[]);
set(gca,'XTickLabel',colrNames);
set(gca,'YTickLabel',{});
set(gca,'FontSize',10)
set(gca,'Position',[0.1, 0.15, 0.8, 0.75])
set(gcf,'Position',[100, 100, 700, 140])
set(gca,'XLim',[0 numColors*2])

title( answer )
set(gcf,'Name',answer{1})
pDir = 'palettes/';
system( [ 'mkdir -p ', pDir] );
outFile = [pDir, answer{1}, '.jpg'];
saveas( gcf, outFile, 'jpeg' );
%print( gcf, '-djpeg100', '-noui', [pDir, answer, '.jpg'] );
