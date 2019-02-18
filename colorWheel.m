function [ output_args ] = colorWheel( colorNames, colrs, baseColor, schema )
%COLORWHEEL Facilitate color choices for design.
%   Using a flattening of the HSL model, identify other colors on a list
%   that are appropriate selections for the design of a brochure, house 
%   painting, tie dye, etc.  Draw a hue wheel, and then draw darker colors 
%   in the list inside the wheel and lighter colors outside.  Then using
%   baseColor as a starting point, draw lines on the wheel that indicate
%   other colors that go with the baseColr based on traditional color
%   schemes, 'complimentary', 'triadic, etc.
%
% Args:
%   - colorNames: a cell array of n color names
%   - colrs: an n x 3 array of colors, where each m color's name is
%     colorNames{m}, specified in RGB where each component is in range
%     0-255.
%   - baseColor: is the name of one of the colors in colorNames
%   - schema: is one of the classic color schemes: 'warm';
%     'cool'; 'analogous'; 'triadic'; 'tetradic'; 'split complements'; 
%     or 'monochromatic'.


wheelRadius = 1;
wheelThickness = 0.05;
innerR = wheelRadius - wheelThickness;
outerR = wheelRadius + wheelThickness;
angleStep = 0.1; %deg

sz = size(colrs);
numColors=sz(1);
chosenColor='';
%isempty(chosenColor)

for c = 1 : numColors
    %colorNames{c}
    if( strcmpi(colorNames{c},baseColor) )
        chosenColor = c;
        chosenColorName = colorNames{c};
        break
    end
end

if(isempty(chosenColor))
    error(['Specified color: ', baseColor, ' not found!'])
end

for theta = 0:angleStep:360
    line([innerR*sind(theta),outerR*sind(theta)],...
         [innerR*cosd(theta),outerR*cosd(theta)],...
         'Color',hsv2rgb([theta/360,1,1]))
end
spoke=1.1;
for theta = 0:30:360
    x=outerR*sind(theta);
    y=outerR*cosd(theta);
    line([x,x*spoke],...
         [y,y*spoke],...
         'Color',hsv2rgb([theta/360,1,1]))
end

set(gcf, 'OuterPosition', [ 320 20 1150 1150 ] );
set(gca, 'XLim', [-2 2])
set(gca, 'YLim', [-2 2])

tOff = 0.1;
for c = 1 : numColors
    sprintf('%s',colorNames{c});
    hssv=rgb2hsv(colrs(c,:)./255.0);
    rad=hssv(3)*2;
    xPos = sind(hssv(1)*360)*rad;
    yPos = cosd(hssv(1)*360)*rad;
    colr=colrs(c,:)./255;
    line([0 xPos],[0 yPos],'Color',colr,...
        'Marker','o','LineStyle','none',...
        'MarkerFaceColor',colr,...
        'MarkerSize',24)
    text(xPos,yPos-tOff,colorNames{c},...
        'HorizontalAlignment','center')
end

drawScheme( schema, colrs(chosenColor,:) );

title( [schema, ' for ', chosenColorName] )

end

function drawScheme( scheme, colr )

colr=colr./255.0;
hssv=rgb2hsv(colr./255.0);
hue=hssv(1);
rad=2;
xPos = sind(hue*360)*rad;
yPos = cosd(hue*360)*rad;


switch scheme
   case 'warm'
      huel=0;
      huer=60;
      lxPos = sind(huel)*rad;
      lyPos = cosd(huel)*rad;
      rxPos = sind(huer)*rad;
      ryPos = cosd(huer)*rad;
      line([0,lxPos],[0,lyPos],'Color','k')
      line([0,rxPos],[0,ryPos],'Color','k')
   case 'cool'
      huel=90;
      huer=270;
      lxPos = sind(huel)*rad;
      lyPos = cosd(huel)*rad;
      rxPos = sind(huer)*rad;
      ryPos = cosd(huer)*rad;
      line([0,lxPos],[0,lyPos],'Color','k')
      line([0,rxPos],[0,ryPos],'Color','k')
   case 'analogous'
      rAng = (hue*360)-30;
      rxPos = sind(rAng)*rad;
      ryPos = cosd(rAng)*rad;
      lAng = (hue*360)+30;
      lxPos = sind(lAng)*rad;
      lyPos = cosd(lAng)*rad;
      line([0,lxPos],[0,lyPos],'Color',colr)
      line([0,rxPos],[0,ryPos],'Color',colr)
      line([0,xPos],[0,yPos],'Color',colr)
   case 'complimentary'
      line([0,xPos],[0,yPos],'Color',colr)
      line([0,-xPos],[0,-yPos],'Color',colr)
   case 'triadic'
      rAng = (hue*360)-120;
      rxPos = sind(rAng)*rad;
      ryPos = cosd(rAng)*rad;
      lAng = (hue*360)+120;
      lxPos = sind(lAng)*rad;
      lyPos = cosd(lAng)*rad;
      line([0,lxPos],[0,lyPos],'Color',colr)
      line([0,rxPos],[0,ryPos],'Color',colr)
      line([0,xPos],[0,yPos],'Color',colr)
   case 'tetradic'
      rAng = (hue*360)-90;
      rxPos = sind(rAng)*rad;
      ryPos = cosd(rAng)*rad;
      lAng = (hue*360)+90;
      lxPos = sind(lAng)*rad;
      lyPos = cosd(lAng)*rad;
      line([0,lxPos],[0,lyPos],'Color',colr)
      line([0,rxPos],[0,ryPos],'Color',colr)
      line([0,xPos],[0,yPos],'Color',colr)
      line([0,-xPos],[0,-yPos],'Color',colr)
   case 'split complements'
      rAng = (hue*360)-30;
      rxPos = sind(rAng)*rad;
      ryPos = cosd(rAng)*rad;
      lAng = (hue*360)+30;
      lxPos = sind(lAng)*rad;
      lyPos = cosd(lAng)*rad;
      line([0,-lxPos],[0,-lyPos],'Color',colr)
      line([0,-rxPos],[0,-ryPos],'Color',colr)
      line([0,xPos],[0,yPos],'Color',colr)
   case 'neutrals'
      sprintf('%s not implemented yet',scheme)
   case 'monochromatic'
      line([0,xPos],[0,yPos],'Color',colr)
   otherwise
      sprintf('%s unknown color scheme',scheme)
end

end

% some cool ones:
% colorWheel(colors{1},RGB,'Orchid','triadic')
% colorWheel(colors{1},RGB,'Daffodil','analogous')
% colorWheel(colors{1},RGB,'Daffodil','split complements')
