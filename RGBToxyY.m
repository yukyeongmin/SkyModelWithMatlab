function [xyY] = RGBtoxyY(RGB)
%RGBTOXYY Summary of this function goes here
% (1,3) -> (1,3)
% RGB -> XYZ
XYZ = [0.4124 0.3576 0.1805; 0.2126 0.7152 0.0722; 0.0193 0.1192 0.9505]*RGB';

% XYZ -> xyY
xyY(1) = XYZ(1)/sum(XYZ);
xyY(2) = XYZ(2)/sum(XYZ);
xyY(3) = XYZ(2);

end

