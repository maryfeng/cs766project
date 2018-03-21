% Not yet working
function feature_vec = defectFinder(r, g, b, feature_vec, img, i)
% Apply sobel gradient mask
% From "Defect Detection and Classification in Citrus Using Computer
% Vision"
close all;
gx = [-1 -2 -1; 0 0 0; 1 2 1];
gy = [-1 0 1; -2 0 2; -1 0 1];
% Use r channel as in above paper
gradient_r = sqrt(conv2(r,gx,'same').^2 + conv2(r,gy,'same').^2);
gradient_g = sqrt(conv2(g,gx,'same').^2 + conv2(g,gy,'same').^2);
gradient_b = sqrt(conv2(b,gx,'same').^2 + conv2(b,gy,'same').^2);
 
maxr = max(r(:));
a = r;
a(a<0.8*maxr) = 0;

maxg = max(g(:));
b = g;
b(b<0.8*maxg) = 0;

maxb = max(b(:));
c = b; 
c(c<0.8*maxb) = 0;
subplot(1,4,1); imshow(a);
subplot(1,4,2); imshow(b);
subplot(1,4,3); imshow(c);
subplot(1,4,4); imshow(img)


% edge_r = edge(r,'Sobel', 0.1);
% edge_g = edge(g,'Sobel', 0.1);
% edge_b = edge(b,'Sobel', 0.1);
% figure; 
% subplot(1,4,1); imshow(edge_r);
% subplot(1,4,2); imshow(edge_g);
% subplot(1,4,3); imshow(edge_b);
% subplot(1,4,4); imshow(img)
end