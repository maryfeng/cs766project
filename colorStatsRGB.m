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
feature_vec(i,4) = mean(r(:));
feature_vec(i,5) = mean(g(:));
feature_vec(i,6) = mean(b(:));
feature_vec(i,7) = std(r(:));
feature_vec(i,8) = std(g(:));
feature_vec(i,9) = std(b(:));
feature_vec(i,10) = range(r(:));
feature_vec(i,11) = range(g(:));
feature_vec(i,12) = range(b(:));
end