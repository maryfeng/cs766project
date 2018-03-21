function feature_vec = colorStatsRGB(r, g, b, feature_vec, i)
% 5. Mean R channel intensity
% 6. Mean G channel intensity 
% 7. Mean B channel intensity
% 8. Standard deviation of R channel
% 9. Standard deviation of G channel
% 10. Standard deviation of B channel
% 11. Range of R channel
% 12. Range of G channel
% 13. Range of B channel
rvec = double(r(r ~= 0));
gvec = double(g(g ~= 0));
bvec = double(b(b ~= 0));
feature_vec(i,5) = mean(rvec(:));
feature_vec(i,6) = mean(gvec(:));
feature_vec(i,7) = mean(bvec(:));
feature_vec(i,8) = std(rvec(:));
feature_vec(i,9) = std(gvec(:));
feature_vec(i,10) = std(bvec(:));
feature_vec(i,11) = range(rvec(:));
feature_vec(i,12) = range(gvec(:));
feature_vec(i,13) = range(bvec(:));
end