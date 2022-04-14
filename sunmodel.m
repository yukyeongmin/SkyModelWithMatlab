% sun intensity model in LM model

% theta : zenith angle in radiance (matrix)
% pi : azimuth angle in radiance (matrix)
% beta, kappa : sun concentration parameter
% meanSunColor : mean color one scalar for each channel


function luminance = sunmodel(gamma, beta, kappa, meanSunColor)

luminance(1) = meanSunColor(1)*exp(-beta .* exp(-kappa./cos(gamma)));
luminance(2) = meanSunColor(2)*exp(-beta .* exp(-kappa./cos(gamma)));
luminance(3) = meanSunColor(3)*exp(-beta .* exp(-kappa./cos(gamma)));