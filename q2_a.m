clear;
load ps8_data.mat

LINE_LENGTH = 15;
X = Xsim';
NUMBER_OF_POINTS = size(X, 2);
HIGH_DIMENSION = size(X, 1);
LOW_DIMENSION = 1;

%  Q.1.a.1
plot (X(1,:), X(2,:), 'k.', 'markersize',30);
hold on;

mu = mean(X,2);
S = cov(X');

% Q.1.a.2
plot (mu(1), mu(2), 'g.', 'markersize',45);
hold on;

[U, Lambda] = eig(S);
% The dominant component
U1 = U(:,end);

% Q.1.a.3
point_1_for_plot = mu - LINE_LENGTH * U1;
point_2_for_plot = mu + LINE_LENGTH * U1;
line([point_1_for_plot(1), point_2_for_plot(1)],...
    [point_1_for_plot(2), point_2_for_plot(2)], 'Color', 'k');
hold on;

Z = zeros(LOW_DIMENSION, NUMBER_OF_POINTS);
X_cap = zeros(HIGH_DIMENSION, NUMBER_OF_POINTS);
for i=1:NUMBER_OF_POINTS
    Z(i) = U1' * (X(:,i) - mu);
    X_cap(:,i) = (U1 .* Z(i)) + mu;
end

% Q.1.a.4 and 5
plot (X_cap(1,:), X_cap(2,:), 'r.', 'markersize',30);
hold on;
for i=1:NUMBER_OF_POINTS
    line([X_cap(1, i), X(1, i) ], [X_cap(2, i), X(2, i) ], 'Color', 'r');
    hold on
end
axis equal;

save q2.mat
