function [ output_args ] = drawWheel(h)
%DRAWWHEEL Draw simple hue wheel.


wheelRadius = 1;
wheelThickness = 0.05;
innerR = wheelRadius - wheelThickness;
outerR = wheelRadius + wheelThickness;
angleStep = 0.1; %deg

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

