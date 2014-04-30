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
plot(fliplr(sqrt(eigen_values_increasing)), '*');
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
plot3(Z1(91*0+1:91*1), Z2(91*0+1:91*1), Z3(91*0+1:91*1), '.b');hold on;
plot3(Z1(91*1+1:91*2), Z2(91*1+1:91*2), Z3(91*1+1:91*2), '.r');hold on;
plot3(Z1(91*2+1:91*3), Z2(91*2+1:91*3), Z3(91*2+1:91*3), '.g');hold on;
plot3(Z1(91*3+1:91*4), Z2(91*3+1:91*4), Z3(91*3+1:91*4), '.c');hold on;
plot3(Z1(91*4+1:91*5), Z2(91*4+1:91*5), Z3(91*4+1:91*5), '.k');hold on;
plot3(Z1(91*5+1:91*6), Z2(91*5+1:91*6), Z3(91*5+1:91*6), '.m');hold on;
plot3(Z1(91*6+1:91*7), Z2(91*6+1:91*7), Z3(91*6+1:91*7), '.y');hold on;
plot3(Z1(91*7+1:91*8), Z2(91*7+1:91*8), Z3(91*7+1:91*8), '.','Color',[1,0.4,0.6]);hold on;
legend('Reaching angle 1','Reaching angle 2','Reaching angle 3', ...
    'Reaching angle 4','Reaching angle 5','Reaching angle 6',...
    'Reaching angle 7','Reaching angle 8');
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