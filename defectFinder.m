% Not yet working
function feature_vec = defectFinder(r, g, b, feature_vec, img, i, mask)
close all;
r = imgaussfilt(r,7);
g = imgaussfilt(g,7);
b = imgaussfilt(b,7);

R = double(r);
G = double(g);
B = double(b);
figure; colormap(gray)
subplot(2,3,1); hist(R(R~=0),100);
subplot(2,3,2); hist(G(G~=0),100);
subplot(2,3,3); hist(B(B~=0),100);
subplot(2,3,4); imshow(r);
subplot(2,3,5); imshow(g);
subplot(2,3,6); imshow(b)

%% Find dark blemishes in red channel
red_avg = mean(r(r~=0));
dark_spots = r;
dark_spots(dark_spots > red_avg) = 0;
dark_spots = imbinarize(dark_spots);
% Remove perimeter from binarized image
perim = bwperim(mask);
se = strel('sphere',16);
perim = imdilate(perim,se);
dark_spots = dark_spots .* ~perim;
% Dilate slightly to connect small components
se = strel('sphere',2);
dark_spots = imdilate(dark_spots,se);
[labeled_img, nspots] = bwlabel(dark_spots);

% Remove calyx and if perimeter left in binarized image
for i = 1:nspots
   spot = labeled_img;
   spot(spot ~= i) = 0;
   
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
   if dist < 85 && roundness > 0.5
       labeled_img(labeled_img == i) = 0;
   elseif roundness < 0.1 || sum(spot(:))<40
       labeled_img(labeled_img == i) = 0;
   end
end
percent_blemished = sum(sum(labeled_img ~= 0))/sum(mask(:));

maxg = max(g(:));
d = g;
d(d<0.85*maxg) = 0;


maxb = max(b(:));
c = b; 
c(c<0.8*maxb) = 0;

figure; 
subplot(1,4,1); imshow(labeled_img);
subplot(1,4,2); imshow(d);
subplot(1,4,3); imshow(c);
subplot(1,4,4); imshow(img)
end