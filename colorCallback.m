function colorCallback(src,arg1)

colr = src.UserData;
display([ 'Adding: ', colr(1).colorNames, ' to palette.'])

pal = getPalette();
sz = size(pal);
numColors = sz(2);

for c = 1 : numColors
    if strcmpi(pal(c).colorNames,colr(1).colorNames)
    	warning([ 'Color: ', pal(c).colorNames, ' is already in palette.'])
    	return
    end
end

pal = [ pal colr ];

setPalette(pal);

drawSwatches();
