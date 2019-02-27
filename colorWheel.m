function [ output_args ] = colorWheel()
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

colorNames = getColorNames();
colrs = getColors();
baseColor = getBaseColor();
schema = getColorScheme();

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
    if( strcmpi(colorNames{c},baseColor(1).colorNames) )
        chosenColor = c;
        chosenColorName = colorNames{c};
        %colrs(c,:)
        %break
    end
end

if(isempty(chosenColor))
    error(['Specified color: ', baseColor(1).colorNames, ' not found!'])
end

drawWheel();

% Create a small circle to be used for all swatches
swatchRadius = 0.075;
angleStep = 20; %deg
numSteps = 360/angleStep+1;
circle = zeros(numSteps,2);
steps = 1:numSteps;
thetas = (steps-1)*angleStep;
circle(:,1) = swatchRadius * cosd(thetas);
circle(:,2) = swatchRadius * sind(thetas);
%plot(circle(:,1),circle(:,2))

% Now create two matrices to hold all color positions
swatchesX = zeros(numSteps,numColors);
swatchesY = swatchesX;
for c = 1 : numColors
    swatchesX(:,c) = circle(:,1);
    swatchesY(:,c) = circle(:,2);
end
% And colors
colors = zeros(numColors,3);
cIdxs = 1 : numColors;
%colors=colrs(cIdxs,:)./255;


for c = 1 : numColors
    %sprintf('%s',colorNames{c});
    hssv=rgb2hsv(colrs(c,:));
    rad=hssv(3)*2;
    xPos = sind(hssv(1)*360)*rad;
    yPos = cosd(hssv(1)*360)*rad;
%     swatchesX(:,c) = swatchesX(:,c) + sind(hssv(1)*360)*rad;
%     swatchesY(:,c) = swatchesY(:,c) + cosd(hssv(1)*360)*rad;
    colr=colrs(c,:);
%    line([0 xPos],[0 yPos],'Color',colr,...
%     line([xPos],[yPos],'Color',colr,...
%         'Marker','o','LineStyle','none',...
%         'MarkerFaceColor',colr,...
%         'MarkerSize',24,...
%         'UserData',colorNames{c},...
%         'ButtonDownFcn',@colorCallback...
%     )
      s=struct('colorNames',{colorNames{c}},'colors',{colr});
      patch(circle(:,1)+xPos,circle(:,2)+yPos,colr,...
          'EdgeColor','none',...
          'UserData',s,...
          'ButtonDownFcn',@colorCallback);
end
% size(swatchesX)
% size(swatchesY)
% size(colors')
% patch(swatchesX,swatchesY,colors',)
%patch(swatchesX,swatchesY)

if getLabels()
  % Draw text
  tOff = 0.075;
  for c = 1 : numColors
      sprintf('%s',colorNames{c});
      hssv=rgb2hsv(colrs(c,:));
      rad=hssv(3)*2;
      xPos = sind(hssv(1)*360)*rad;
      yPos = cosd(hssv(1)*360)*rad;
      text(xPos,yPos-tOff,colorNames{c},...
          'HorizontalAlignment','center')
  end
end

drawScheme( schema(1).schemeName, colrs(chosenColor,:) );

title( { [schema(1).schemeName, ' for ', chosenColorName] ; '' }, 'FontSize', 14 );

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
% close('all');colorWheel(colors{1},RGB,'Orchid','triadic')
% close('all');colorWheel(colors{1},RGB,'Daffodil','analogous')
% close('all');colorWheel(colors{1},RGB,'Daffodil','split complements')
