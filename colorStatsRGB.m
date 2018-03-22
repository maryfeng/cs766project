function feature_vec = colorStatsRGB(r, g, b, feature_vec, i)
% 4. Mean R channel intensity
% 5. Mean G channel intensity 
% 6. Mean B channel intensity
% 7. Standard deviation of R channel
% 8. Standard deviation of G channel
% 9. Standard deviation of B channel
% 10. Range of R channel
% 11. Range of G channel
% 12. Range of B channel
rvec = double(r(r ~= 0));
gvec = double(g(g ~= 0));
bvec = double(b(b ~= 0));
feature_vec(i,4) = mean(rvec(:));
feature_vec(i,5) = mean(gvec(:));
feature_vec(i,6) = mean(bvec(:));
feature_vec(i,7) = std(rvec(:));
feature_vec(i,8) = std(gvec(:));
feature_vec(i,9) = std(bvec(:));
feature_vec(i,10) = range(rvec(:));
feature_vec(i,11) = range(gvec(:));
feature_vec(i,12) = range(bvec(:));
end