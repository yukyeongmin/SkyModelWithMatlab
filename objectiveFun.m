function f = objectiveFun(optimInput)
    % parameters
    beta = optimInput(1);
    kappa = optimInput(2);
    t = optimInput(3);

    % fixed value
    sunThetaPi = [1.11798267124951 -0.769324041941732];
    meanSun = [500 500 500]; 
    addpath '/home/cvnar1/library/openexr-matlab'
    filename = 'envmapFromLM.exr';
    img = exrread(filename);
    img = img(1:512,:,:); % all color channel   

    % skyelement's zenith angle - theta
    % angulardiff with skyelement and sun - gamma
    [theta, gamma] = compute_theta_gamma(sunThetaPi);

    fmap = zeros(512,2048); % sum
    for i = 1:400
        for j = 1:2048

            % empirical sun model from LM(RGB) 
            sunIntensityRGB = sunmodel(gamma(i,j), beta, kappa, meanSun);
            % preetham sky model(xyY)
            [preethamx,preethamy,preethamY] = preethamSkyModel(sunThetaPi(1), theta(i,j), gamma(i,j),t);
            preethamRGB = xyYToRGB([preethamx preethamy preethamY]); %col vec

            totalIntensity = -log(sunIntensityRGB) + log(preethamRGB');
            currentRGB = log(reshape(img(i,j,:),1,[]));
            fmap(i,j) = sum(( totalIntensity -  currentRGB ).^2);
            if fmap(i,j)>100
                fprintf('problem')
            end

        end
        f = sum(fmap(:))
    end
 
    
end
