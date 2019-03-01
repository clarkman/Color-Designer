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

title( answer )

get(gcf)
get(gca)

pDir = 'palettes/';
system( [ 'mkdir -p ', pDir] );
outFile = [pDir, answer{1}, '.jpg'];
saveas( gcf, outFile, 'jpeg' );
%print( gcf, '-djpeg100', '-noui', [pDir, answer, '.jpg'] );
