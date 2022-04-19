function f = objectiveFun(optimInput)
    % parameters
    beta = optimInput(1);
    kappa = optimInput(2);
    t = optimInput(3);

    % fixed value
    sunThetaPi = [1.00098905523831 0.455283099528778];
    meanSun = [145.3634490717062 137.38402281416222 126.65857672808409]; 
    meanSky = [0.07414824917971413 0.08207401149751785 0.09193370140399203];
    addpath '/home/cvnar1/library/openexr-matlab'
    filename = 'envmapclear.exr';
    img = exrread(filename);
    img = img(1:512,:,:); % all color channel   

    % skyelement's zenith angle - theta
    % angulardiff with skyelement and sun - gamma
    [theta, gamma] = compute_theta_gamma(sunThetaPi);

    fmap = zeros(512,2048); % sum
    sunIntensity = zeros(512,2048);
    skyIntensity = zeros(512,2048);
    totalIntensity = zeros(512,2048);
    origin = zeros(512,2048);
    for i = 1:512
        for j = 1:2048
            
            % perez sky model(xyY)
            % sky parameters
            [skyparamY,skyparamx,skyparamy] = turbidityToSkyparam(t);

            aY = skyparamY(1);
            bY = skyparamY(2);
            cY = skyparamY(3);
            dY = skyparamY(4);
            eY = skyparamY(5);

            % model relative luminance of a light direction (i,j)
            skyIntensityY = perezSkyModel(aY,bY,cY,dY,eY,theta(i,j),gamma(i,j));
            skyIntensity(i,j) = skyIntensityY; % 기록용
            
            % expand to RGB channel
            skyIntensityRGB = skyIntensityY*meanSky; % TODO xyY to RGB
            
            % angular diff < 2 degree
            if gamma(i,j)*180/pi<2
                % empirical sun model from LM(luminance) 
                sunIntensityY = sunmodel(gamma(i,j), beta, kappa);
                
                % expand to RGB channel
                sunIntensityRGB = sunIntensityY*meanSun; % TODO xyY to RGB
                
                % surface brightness(log intensity domain)
                sunIntensityRGB = -log10(sunIntensityRGB);
                sunIntensityRGB = 10.^sunIntensityRGB;
                sunIntensity(i,j) = sunIntensityRGB(1); % 기록용
                
                totalIntensityRGB = sunIntensityRGB + skyIntensityRGB;
            else
                totalIntensityRGB = skyIntensityRGB;
            end
            totalIntensity(i,j) = totalIntensityRGB(1); % 기록용
            
            % (i,j) 위치의 각 채널별 밝기 
            currentRGB = reshape(img(i,j,:),1,[]);
            origin(i,j) = currentRGB(1);
            
            % dynamic range를 줄여서 최적화
            d = 5000; % encoding했을때 maximum luminance 값
            totalIntensityRGB = log10(1+d*totalIntensityRGB) / log10(1+d);
            currentRGB = log10(1+d*currentRGB) / log10(1+d);
            
            if gamma(i,j)*180/pi<10
                fmap(i,j) = sum(( totalIntensityRGB -  currentRGB ).^2);
            end
           

            if isinf(fmap(i,j))
                fprintf('inf')
            end
        end
    end
 
f = sum(fmap(:))
end
