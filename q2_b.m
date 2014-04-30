load q2.mat

LINE_LENGTH = 15;
sigma_sqr = 0.5;
mu_bkp = mu;
W = [1;1];
n_iter = 100;
L = zeros(1,n_iter);

for k =1:n_iter
    C = W*W' + sigma_sqr*eye(HIGH_DIMENSION);

    % E step
    mu_rep = repmat(mu, [1, NUMBER_OF_POINTS]);
    z_x_mu = W'*inv(C)*(X-mu_rep);
    z_x_sigma = eye(LOW_DIMENSION) - W'*inv(C)*W;

    % M Step
    E_zzt = z_x_sigma + z_x_mu * z_x_mu';
%     E_zzt = cov(z_x_sigma,z_x_sigma') + z_x_mu * z_x_mu';

    term1 = (X-mu_rep) * z_x_mu';
    term2 = inv(sum(repmat(E_zzt, [1, NUMBER_OF_POINTS])));
%     term2 = inv(E_zzt);
    W = term1 * term2;

    term3 = (X-mu_rep)*(X-mu_rep)';
    term4 = W*(z_x_mu*(X-mu_rep)');
    sigma_sqr = trace(term3 - term4)/ ...
        (NUMBER_OF_POINTS * HIGH_DIMENSION);

    % Calculating log likelihood
    for i = 1:NUMBER_OF_POINTS
        L(k) = L(k) + logmvnpdf(X(:,i), mu, C);
    end
end
plot(L);

% Question 2c
plot (X(1,:), X(2,:), 'k.', 'markersize',30);
hold on;
plot (mu(1), mu(2), 'g.', 'markersize',45);
hold on;
point_1_for_plot = mu - LINE_LENGTH * W;
point_2_for_plot = mu + LINE_LENGTH * W;
line([point_1_for_plot(1), point_2_for_plot(1)],...
    [point_1_for_plot(2), point_2_for_plot(2)], 'Color', 'k');
hold on;

X_cap = W*z_x_mu + mu_rep;
plot (X_cap(1,:), X_cap(2,:), 'r.', 'markersize',30);
hold on;
for i=1:NUMBER_OF_POINTS
    line([X_cap(1, i), X(1, i) ], [X_cap(2, i), X(2, i) ], 'Color', 'r');
    hold on
end
axis equal