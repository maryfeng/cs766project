function feature_vec = shapeProperties(mask, feature_vec, i, mm_per_pixel)
% 1. Area
% 2. Roundness
% 3. Circularity
% 4. Diameter
perimeter = bwperim(mask);
measurements = regionprops(mask, 'centroid', 'MajorAxisLength',...
    'MinorAxisLength', 'area');
circularity = (sum(perimeter(:))^2)/(4*pi*measurements.Area);
roundness = measurements.MinorAxisLength/measurements.MajorAxisLength;
area = measurements.Area * mm_per_pixel^2;
diam = measurements.MajorAxisLength * mm_per_pixel;

feature_vec(i,1) = area;
feature_vec(i,2) = roundness;
feature_vec(i,3) = circularity;
feature_vec(i,4) = diam;
end