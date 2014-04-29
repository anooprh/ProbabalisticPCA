load q2.mat

sigma_sqr = 1;
mu_bkp = mu;
W = U1;

L = 0;

C = W*W' + sigma_sqr*eye(HIGH_DIMENSION);

% Calculating log likelihood
for i = 1:NUMBER_OF_POINTS
    L = L + logmvnpdf(X(:,i), mu, C);
end



% E step
mu_rep = repmat(mu, [1, NUMBER_OF_POINTS]);
z_x_mu = W'*inv(C)*(X-mu_rep);
z_x_sigma = eye(LOW_DIMENSION) - W'*inv(C)*W;

E_zzt = z_x_sigma + z_x_mu * z_x_mu';

term1 = (X-mu_rep) * z_x_mu';
term2 = inv(sum(repmat(E_zzt, [1, NUMBER_OF_POINTS])));

W = term1 * term2;