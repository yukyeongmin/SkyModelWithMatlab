function [x, y, Y] = preethamSkyModel(sunTheta, theta,gamma,turbidity)
%PREETHAMSKYMODEL Summary of this function goes here
%   sunTheta - zenith angle of sun
%   theta - zenith angle of sky element
%   gamma - angular difference b/t sun and sky element
%   t - turbidity(>=1)

% zenith value
zenithY = (4.0453*turbidity - 4.97100)*tan((4/9-turbidity/120) * (pi - 2*sunTheta)) -0.2155*turbidity + 2.4192;
zenithx = [turbidity^2 turbidity 1] * [0.00166 -0.00375 0.00209 0; -0.02903 0.06377 -0.03202 0.00394; 0.11693 -0.21196 0.06052 0.25886]*[sunTheta^3 sunTheta^2 sunTheta 1]';
zenithy = [turbidity^2 turbidity 1] * [0.00275 -0.00610 0.00317 0; -0.04214 0.08970 -0.04153 0.00516;0.15346 -0.26756 0.06670 0.26688]*[sunTheta^3 sunTheta^2 sunTheta 1]';

% sky parameters
[skyparamY,skyparamx,skyparamy] = turbidityToSkyparam(turbidity);

aY = skyparamY(1);
bY = skyparamY(2);
cY = skyparamY(3);
dY = skyparamY(4);
eY = skyparamY(5);

ax = skyparamx(1);
bx = skyparamx(2);
cx = skyparamx(3);
dx = skyparamx(4);
ex = skyparamx(5);

ay = skyparamy(1);
by = skyparamy(2);
cy = skyparamy(3);
dy = skyparamy(4);
ey = skyparamy(5);

zenithRelY = perezSkyModel(aY,bY,cY,dY,eY,0,sunTheta);
zenithRelx = perezSkyModel(ax,bx,cx,dx,ex,0,sunTheta);
zenithRely = perezSkyModel(ay,by,cy,dy,ey,0,sunTheta);

relY = perezSkyModel(aY,bY,cY,dY,eY,theta,gamma);
relx = perezSkyModel(ax,bx,cx,dx,ex,theta,gamma);
rely = perezSkyModel(ay,by,cy,dy,ey,theta,gamma);

Y = zenithY*relY/zenithRelY;
x = zenithx*relx/zenithRelx;
y = zenithy*rely/zenithRely;
end

