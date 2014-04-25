load ps8_data.mat
NUM_PRINCOMP = 3;

NUM_TRIALS = size(Xplan, 1);
DIMENSION = size(Xplan, 2);

mean_spike_counts = mean(Xplan, 1);
cov_spike_counts = cov(Xplan);

[U, Lambda] = eig(cov_spike_counts);

eigen_values = diag(Lambda);
eigen_values_increasing = fliplr(eigen_values')';
plot(fliplr(sqrt(eigen_values_increasing)));
hold on
plot(fliplr(sqrt(eigen_values_increasing)), '*k');
xlabel('Component Number');
ylabel('sqrt - eigen value');
title('Square Rooted Eigen Value Spectrum');

percentage_in_top_PrinComp = sum(eigen_values_increasing ...
    (1:NUM_PRINCOMP))./ sum(eigen_values_increasing);
%  This is 44.79% for top 3 components


% Question 1b
figure
PC1 = U(:,end);
PC2 = U(:,end-1);
PC3 = U(:,end-2);
mean_repeated = repmat(mean_spike_counts, NUM_TRIALS, 1);
Z1 = PC1' * (Xplan - mean_repeated)';
Z2 = PC2' * (Xplan - mean_repeated)';
Z3 = PC3' * (Xplan - mean_repeated)';
plot3(Z1, Z2, Z3, '.');
xlabel('1st Component Score');
ylabel('2nd Component Score');
zlabel('3rd Component Score');
title('Scatter plot of Scores From First 3 components');


% Question 1c
figure
U_m = [PC1 PC2 PC3];
imagesc(U_m);
colorbar
title('Not sure how to interpret this');