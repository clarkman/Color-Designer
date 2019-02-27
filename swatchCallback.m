function swatchCallback(arg1,arg2)

colr=arg1.UserData;

bColor = getBaseColor();

colr(1).colorNames;
bColor(1).colorNames;

pal = getPalette();
sz = size(pal);
numColors = sz(2);

if strcmpi(colr(1).colorNames,bColor(1).colorNames)
	warning([ colr(1).colorNames, ' is the base color.  Change base color with pop-up menu.' ])
	return
end

newPalNames = {};
newPalColrs = {};

for c = 1 : numColors
	if strcmpi(colr(1).colorNames,pal(c).colorNames)
		continue
	end
	newPalNames = [ newPalNames, pal(c).colorNames ];
	newPalColrs = [ newPalColrs, pal(c).colors ];
end

setPalette( struct('colorNames',newPalNames,'colors',newPalColrs) );

drawSwatches();