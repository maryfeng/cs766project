function feature_vec = colorStatsHSI(r, g, b, feature_vec, i)
% 13. Mean of Hue (H)
% 14. Mean of Saturation (S)
% 15. Mean of Intensity (I)
% 16. Standard deviation of Hue (H)
% 17. Standard deviation of Saturation (S)
% 18. Standard deviation of Intensity (I)

% Compute H from RGB
Htop = (r-g) + (r-b)/2;
Hbot = sqrt((r-g).^2 + (r-b).*(g-b));
H = acos(Htop./Hbot);

feature_vec(i,13) = mean(H(:));
feature_vec(i,16) = std(H(:));

% Compute S
min_channel = min(r,g,b);
S = 1 - (3/(r+g+b)) .* min_channel;

feature_vec(i,14) = mean(H(:));
feature_vec(i,17) = std(H(:));

% Compute I
I = (r+g+b)/3;
feature_vec(i,15) = mean(I(:));
feature_vec(i,18) = std(I(:));

end

