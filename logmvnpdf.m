function [logp] = logmvnpdf(x,mu,Sigma)
% Computes log(N(xn|mu, Sigma)) 

    [D,~] = size(x);
    const = -0.5 * D * log(2*3.1416);

    term1 = -0.5 * ((x - mu)' * (inv(Sigma) * (x - mu)));
    term2 = - 0.5 * logdet(Sigma);    
    logp = const + term1 + term2;
end

function y = logdet(A)
    y = log(det(A));
end