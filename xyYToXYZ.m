function [XYZ] = xyYToXYZ(xyY)
%XYYTORGB Summary of this function goes here

% if xyY(1)>1
%    fprintf('range chek') 
% end

% xyY -> XYZ
XYZ(1) = xyY(1)*xyY(3)/xyY(2);
XYZ(2) = xyY(3);
XYZ(3) = (1-xyY(1)-xyY(2))*xyY(3)/xyY(2);

end