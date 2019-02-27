function paletteDesigner()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

load('Dyes.mat')
setColorNames(colors{1});
setColors(RGB./255);
s=struct('colorNames',{'RavenBlack'},'colors',{[0 0 0]});
% Test s=struct('colorNames',{'RavenBlack','Blue','Red'},'colors',{[0 0 0],[0 0 1],[1 0 0]});
setBaseColor(s);
setPalette(s);
setSchemes({'warm','cool','analogous','complimentary','triadic','tetradic','split complements','split analogous','neutrals','monochromatic'})
setColorScheme(struct('schemeName','monochromatic','schemeIdx',10))

f = openfig('ColorDesigner.fig');
data = guihandles(f); % initialize it to contain handles
guidata(f, data);  % store the structure


end

