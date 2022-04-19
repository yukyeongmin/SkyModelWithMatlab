function [RGB] = xyYToRGB(xyY)
%XYYTORGB Summary of this function goes here

% if xyY(1)>1
%    fprintf('range chek') 
% end

% xyY -> XYZ
XYZ(1) = xyY(1)*xyY(3)/xyY(2);
XYZ(2) = xyY(3);
XYZ(3) = (1-xyY(1)-xyY(2))*xyY(3)/xyY(2);

% XYZ -> RGB
% RGB = [3.2405 -1.5371 -0.4985; -0.9693 1.8760 0.0416; 0.0556 -0.2040 1.0572]*XYZ';
RGB = [3.2406 -1.5372 -0.4986; -0.9689 1.8758 0.0415; 0.0557 -0.2040 1.0570]*XYZ'; % linear RGB


% to prevent negative value
% for i=1:3
%     if RGB(i)<=0
%         RGB(i) = 0.000001;
%     end
% end

end

