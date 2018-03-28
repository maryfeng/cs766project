% Not yet working
function feature_vec = defectFinder(r, g, b, feature_vec, img, i, mask)
close all;
r = imgaussfilt(r,7);
g = imgaussfilt(g,7);
b = imgaussfilt(b,7);

R = double(r);
G = double(g);
B = double(b);
% figure; colormap(gray)
% subplot(2,3,1); hist(R(R~=0),100);
% subplot(2,3,2); hist(G(G~=0),100);
% subplot(2,3,3); hist(B(B~=0),100);
% subplot(2,3,4); imshow(r);
% subplot(2,3,5); imshow(g);
% subplot(2,3,6); imshow(b)

%% Find dark blemishes in red channel, light spots in blue channel
red_avg = mean(r(r~=0));
dark_spots = r;
dark_spots(dark_spots > red_avg) = 0;
dark_spots = imbinarize(dark_spots);
blue_avg = mean(b(b~=0));
light_spots = b;
light_spots(light_spots < 1.75*blue_avg) = 0;
light_spots = imbinarize(light_spots);
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
percent_blemished = sum(sum(labeled_img ~= 0))/sum(mask(:));
feature_vec(i,19) = percent_blemished;

% 
% figure; 
% subplot(1,4,1); imshow(labeled_img);
% subplot(1,4,2); imshow(d);
% subplot(1,4,3); imshow(c);
% subplot(1,4,4); imshow(img)
end