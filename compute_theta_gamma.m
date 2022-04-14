% theta: zenith angle of sky element(1024,2048)
% gamma: angular difference between sky element and sun (1024,2048)

% X, Y : position in equirectangular image

function [anyTheta, gamma] = compute_theta_gamma(sunThetaPi)

radius = 2048/(2*pi);

%sunThetaPi = [sunXY(1)/radius sunXY(2)/radius]; % zenith , azimuth
sunXYZ = [radius*sin(sunThetaPi(1))*sin(sunThetaPi(2)) radius*sin(sunThetaPi(1))*cos(sunThetaPi(2)) radius*cos(sunThetaPi(1))];

anyTheta = zeros(512, 2048);
gamma = zeros(512,2048);

for i=1:512
    for j = 1:2048
        anyThetaPi = [(i-1)/radius (j-1)/radius+sunThetaPi(2)];
        anyTheta(i,j) = anyThetaPi(1);

        anyXYZ = [radius*sin(anyThetaPi(1))*sin(anyThetaPi(2)) radius*sin(anyThetaPi(1))*cos(anyThetaPi(2)) radius*cos(anyThetaPi(1))];        
        gamma(i,j) = acos(sunXYZ * anyXYZ'/radius^2);
        
    end
end

end
