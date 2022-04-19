% theta: zenith angle of sky element (in sphere)
% pi : aximuth angle of sky element (in sphere)
% gamma: angular difference between sky element and sun
% X, Y : position in equirectangular image
% X, Y, Z : 3d point in sphere

function [anyTheta, gamma] = compute_theta_gamma(sunThetaPi)

% 구의 반지름 구하기
radius = 2048/(2*pi);

% angular difference를 구하기 위해 태양의 위치를 3차원 직교 좌표에 올린다.
sunXYZ = [radius*sin(sunThetaPi(1))*sin(sunThetaPi(2)) radius*sin(sunThetaPi(1))*cos(sunThetaPi(2)) radius*cos(sunThetaPi(1))];

% 이미지의 각 픽셀별 theta, pi와 태양과의 angular diff 계산
anyTheta = zeros(512, 2048);
gamma = zeros(512,2048);

for i=1:512
    for j = 1:2048
        % matlab은 index가 1부터 시작하고 python에서는 index가 0부터 시작
        anyThetaPi = [(i-1)/radius ((j-1)/radius)-pi];
        anyTheta(i,j) = anyThetaPi(1);

        anyXYZ = [radius*sin(anyThetaPi(1))*sin(anyThetaPi(2)) radius*sin(anyThetaPi(1))*cos(anyThetaPi(2)) radius*cos(anyThetaPi(1))];        
        gamma(i,j) = acos(sunXYZ * anyXYZ'/radius^2);
       
    end
end

end
