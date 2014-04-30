load q2.mat

LINE_LENGTH = 15;
psi = rand(HIGH_DIMENSION);
mu_bkp = mu;
W = [1;1];
n_iter = 20;
L = zeros(1,n_iter);

for k =1:n_iter
    C = W*W' + sigma_sqr*eye(HIGH_DIMENSION);

    % E step
    mu_rep = repmat(mu, [1, NUMBER_OF_POINTS]);
    z_x_mu = W'*inv(C)*(X-mu_rep);
    z_x_sigma = eye(LOW_DIMENSION) - W'*inv(C)*W;

    % M Step
    E_zzt = z_x_sigma + z_x_mu * z_x_mu';

    term1 = (X-mu_rep) * z_x_mu';
    term2 = inv(sum(repmat(E_zzt, [1, NUMBER_OF_POINTS])));
    W = term1 * term2;

    term3 = (X-mu_rep)*(X-mu_rep)';
    term4 = W*(z_x_mu*(X-mu_rep)');
    psi = diag(diag(term3 - term4))/NUMBER_OF_POINTS;

    % Calculating log likelihood
    for i = 1:NUMBER_OF_POINTS
        L(k) = L(k) - logmvnpdf(X(:,i), mu, C);
    end
end
plot(L);
xlabel('Iteration Number');
ylabel('Log Likelihood');
title('Q.2.e. Log likelihood v/s iteration number');
figure;

% Question 2d
plot (X(1,:), X(2,:), 'k.', 'markersize',30);
hold on;
plot (mu(1), mu(2), 'g.', 'markersize',30);
hold on;
point_1_for_plot = mu - LINE_LENGTH * W;
point_2_for_plot = mu + LINE_LENGTH * W;
line([point_1_for_plot(1), point_2_for_plot(1)],...
    [point_1_for_plot(2), point_2_for_plot(2)], 'Color', 'k');
hold on;

X_cap = W*z_x_mu + mu_rep;
plot (X_cap(1,:), X_cap(2,:), 'r.', 'markersize',15);
hold on;
for i=1:NUMBER_OF_POINTS
    line([X_cap(1, i), X(1, i) ], [X_cap(2, i), X(2, i) ], 'Color', 'r');
    hold on
end
xlabel('X1 in high-D');
ylabel('X2 in high-D');
title('Q.2.g. Illustrating Factor Analysis')
legend('Data Points(in high D)', 'Mean(in high D)', 'PC Space', ...
    'Low D projections', 'High-D to Low-D connection'...
    ,'Location','NorthWest');
axis equal