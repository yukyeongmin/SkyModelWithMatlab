% sun intensity model in LM model

% theta : zenith angle in radiance (matrix)
% pi : azimuth angle in radiance (matrix)
% beta, kappa : sun concentration parameter
% meanSunColor : mean color one scalar for each channel


function luminance = sunmodel(gamma, beta, kappa)

luminance = exp(-beta .* exp(-kappa./cos(gamma)));
