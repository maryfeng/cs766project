function feature_vec = defectFinder(r, feature_vec, img, i, mask)
close all;


%% Find dark blemishes in red channel, light spots in saturation channel
% Apply smoothing filter to red channel
r = imgaussfilt(r,7);
% Binarize red channel 
red_avg = mean(r(r~=0));
dark_spots = r;
dark_spots(dark_spots > red_avg) = 0;
dark_spots = imbinarize(dark_spots);

%% Find light blemishes using saturation channel of HSV
% use saturation as metric of light spots
hsv = rgb2hsv(img);
s = hsv(:,:,2);
s_avg = mean(s(s~=0));
light_spots = s;
% multiplier of 0.7 found to work well empirically
light_spots(light_spots > 0.7*s_avg) = 0;
light_spots = imbinarize(light_spots);

%% Combine dark & light defects and process
spots = dark_spots + light_spots;
% Remove perimeter from binarized image
perim = bwperim(mask);
se = strel('sphere',16);
perim = imdilate(perim,se);
spots = spots .* ~perim;
% Dilate slightly to connect small components
se = strel('sphere',2);
spots = imdilate(spots,se);
[labeled_img, nspots] = bwlabel(spots);

% Remove calyx and if perimeter left in binarized image
for k = 1:nspots
   spot = labeled_img;
   spot(spot ~= k) = 0;
   
   m = regionprops(spot, 'Centroid', 'MajorAxisLength', 'MinorAxisLength');
   for j = 1:length(m)
      if ~isnan(m(j).Centroid) 
          m = m(j);
          break
      end
   end
   % Remove segment if very close to center (calyx likely)
   dist = sqrt((500-m.Centroid(1))^2 + (500-m.Centroid(2))^2);
   % If line-like like perimeter, remove segment
   roundness = m.MinorAxisLength/m.MajorAxisLength;
   % If spot is close to center, round, and fairly small (less than 3% of 
   % total mask), consider it the calyx and remove from 
   % consideration as a blemish
   if dist < 85 && roundness > 0.5 && ...
           sum(sum(spot ~= 0))/sum(mask(:)) < 0.03
       labeled_img(labeled_img == k) = 0;
   elseif roundness < 0.1 || sum(spot(:))<40
       labeled_img(labeled_img == k) = 0;
   end
end
%% Add to feature vector 
percent_blemished = sum(sum(labeled_img ~= 0))/sum(mask(:));
feature_vec(i,19) = percent_blemished;
end