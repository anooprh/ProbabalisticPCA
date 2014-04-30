clear;
load ps8_data.mat

LINE_LENGTH = 15;
X = Xsim';
NUMBER_OF_POINTS = size(X, 2);
HIGH_DIMENSION = size(X, 1);
LOW_DIMENSION = 1;

%  Q.1.a.1
plot (X(1,:), X(2,:), 'k.', 'markersize',15);
hold on;

mu = mean(X,2);
S = cov(X');


[U, Lambda] = eig(S);
% The dominant component
U1 = U(:,end);

% Q.1.a.3
point_1_for_plot = mu - LINE_LENGTH * U1;
point_2_for_plot = mu + LINE_LENGTH * U1;
line([point_1_for_plot(1), point_2_for_plot(1)],...
    [point_1_for_plot(2), point_2_for_plot(2)], 'Color', 'k');
hold on;

% Q.1.a.2
plot (mu(1), mu(2), 'g.', 'markersize',25);
hold on;


mu_rep = repmat(mu, [1, NUMBER_OF_POINTS]);
Z = U1'*(X-mu_rep);
X_cap = (U1 * Z) + mu_rep;

% Q.1.a.4 and 5
plot (X_cap(1,:), X_cap(2,:), 'r.', 'markersize',15);
hold on;
for i=1:NUMBER_OF_POINTS
    line([X_cap(1, i), X(1, i) ], [X_cap(2, i), X(2, i) ], 'Color', 'r');
    hold on
end
axis equal;
xlabel('X1 in high-D');
ylabel('X2 in high-D');
title('Q.2.d. Illustrating PCA')
legend('Data Points(in high D)', 'Mean(in high D)', 'PC Space', ...
    'Low D projections', 'High-D to Low-D connection'...
    ,'Location','NorthWest');

save q2.mat
