function colorCallback(src,arg1)

colr = src.UserData;
display([ 'Adding: ', colr(1).colorNames, ' to palette.'])

pal = getPalette();
sz = size(pal);
numColors = sz(2);


removing = 0;
for c = 1 : numColors
    if strcmpi(pal(c).colorNames,colr.colorNames)
		removing = c;    
	end
end

if ~removing % We are adding
	setPalette([ pal colr ]);
else
	newPalNames = {};
	newPalColrs = {};
	for c = 1 : numColors
		if strcmpi(colr.colorNames,pal(c).colorNames)
			continue
		end
		newPalNames = [ newPalNames, pal(c).colorNames ];
		newPalColrs = [ newPalColrs, pal(c).colors ];
	end
	setPalette( struct('colorNames',newPalNames,'colors',newPalColrs) );
end

drawSwatches();
