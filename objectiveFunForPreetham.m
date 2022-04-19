function f = objectiveFunForPreetham(optimInput)
    % parameters
    beta = optimInput(1);
    kappa = optimInput(2);
    turbidity = optimInput(3);

    % fixed value
    sunXY = [365 774];
    sunThetaPi = [1.11798267124951 -0.769324041941732];
    meanSun = [20000 20000 20000]; 
    meanSky = [0.12928224 0.13194651 0.13603392];
    addpath '/home/cvnar1/library/openexr-matlab'
    filename = 'envmapFromLM.exr';
    img = exrread(filename);
    img = img(1:512,:,:); % all color channel   

    % skyelement's zenith angle - theta
    % angulardiff with skyelement and sun - gamma
    [theta, gamma] = compute_theta_gamma(sunThetaPi, sunXY);

    fmap = zeros(512,2048); % sum
    for i = 1:512
        for j = 1:2048
            % preetham model returns xyY form            
            [skyIntensityx, skyIntensityy, skyIntensityY] = preethamSkyModel(sunThetaPi(1), theta(i,j), gamma(i,j), turbidity);
            skyIntensityRGB = xyYToRGB([skyIntensityx, skyIntensityy, skyIntensityY]);
            skyIntensityRGB = skyIntensityRGB' .* meanSky;
            
            % angular diff <= 2 degree
            if gamma(i,j)*180/pi<2
                % empirical sun model from LM(RGB) 
                sunIntensityRGB = sunmodel(gamma(i,j), beta, -kappa, meanSun);
%                 sunIntensityRGB = -log10(sunIntensityRGB);
%                 sunIntensityRGB = 10^sunIntensityRGB;
                totalIntensity = sunIntensityRGB + skyIntensityRGB;
            else
                totalIntensity = skyIntensityRGB;
            end
            
            % 3가지 채널의 mse를 한곳에 저장
            currentRGB = reshape(img(i,j,:),1,[]);
            fmap(i,j) = sum(( totalIntensity -  currentRGB ).^2);
           

            if isinf(fmap(i,j))
                fprintf('inf')
            end
        end
    end
 
f = sum(fmap(:))
end


