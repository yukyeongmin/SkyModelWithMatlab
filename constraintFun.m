function [c, ceq] = constraintFun(optimInput)
%CONSTRAINTFUN Summary of this function goes here
%   Detailed explanation goes here

% parameters
beta = optimInput(1);
kappa = optimInput(2);
turbidity = optimInput(3);

% fixed value
sunThetaPi = [1.11798267124951 -0.769324041941732];
sunTheta = sunThetaPi(1);
meanSunColor = [500 500 500]; 
[theta, gamma] = compute_theta_gamma(sunThetaPi);

% sunIntensity
c(1) = -sunmodel(gamma, beta, kappa, meanSunColor);
% skyIntensity
[x, y, Y] = preethamSkyModel(sunTheta, theta, gamma, turbidity);

% each RGB value must be positive
c(2) = xyYToRGB(-[x y Y]);

ceq = [];
end

