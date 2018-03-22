function feature_vec = colorStatsHSI(img, feature_vec, i)
% 13. Mean of Hue (H)
% 14. Mean of Saturation (S)
% 15. Mean of Intensity (I)
% 16. Standard deviation of Hue (H)
% 17. Standard deviation of Saturation (S)
% 18. Standard deviation of Intensity (I)
img = double(img)/255;
R=img(:,:,1);
G=img(:,:,2);
B=img(:,:,3);

%% Hue
Htop=1/2*((R-G)+(R-B));
Hbottom=((R-G).^2+((R-B).*(G-B))).^0.5;

%To avoid divide by zero exception add a small number in the denominator
H=acosd(Htop./(Hbottom+0.000001));
%If B>G then H= 360-Theta
H(B>G)=360-H(B>G);
%Normalize to the range [0 1]
H=H/360;
%% Saturation
S = 1 - (3./(sum(img,3)+0.000001)).*min(img,[],3);

%% Intensity
I=sum(img,3)./3;

%% Feature vector
feature_vec(i,13) = mean(H(:));
feature_vec(i,16) = std(H(:));
feature_vec(i,14) = mean(S(:));
feature_vec(i,16) = std(S(:));
feature_vec(i,15) = mean(I(:));
feature_vec(i,18) = std(I(:));

end

