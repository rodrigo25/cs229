function main_c()
% (c) Predicting quasar spectra with functional regression
%load data
load_quasar_data;

load 'f_train';
%f_train = smoothData(train_qso, lambdas);
%f_test = smoothData(test_qso, lambdas);

%    ii. Construct the functional regression estimate (1) for each spectrum in the entire training
%         set using k = 3 nearest neighbors: for each j = 1,...,m, construct the estimator f_left
%         from (1) using f_right = f_right(j). Then compute the error d(f_left(j),f_left) between the true
%         spectrum f_left(j) and your estimated spectrum f_left for each j, and return the average
%         over the training data. What is your average training error?

[m, n] = size(train_qso);
k_size = 3;

global distances;

distances = zeros(m,m);
for i=1:m
  for j=1:m
    distances(i,j) = dist_d(f_train(i,151:end),f_train(j,151:end));
  end
end

errors = zeros(m,1);

for  j=1:m
  
  fj = f_train(j,:);
  
  fj_left = fj(1:50);
  fj_right = fj(151:end);
  
  
  
  h = max_d(j);
  k = neighb(j, k_size);
  
  ds = zeros(k_size,1);
  for i=1:k_size
    ds(i) = dist_d(fj_right, f_train(k(i),151:end))/h;
  end
  
  f_left_y = sum(repmat(ker(ds),1,50).*f_train(k, 1:50) )/ sum(ker(ds));
  
  errors(j) = dist_d(fj_left, f_left_y);
end

errors
mean(errors)

end

function [d] = dist_d(f1, f2)
  d = sum((f1 - f2).^2);
end

function [ker] = ker(t)
  ker = max (1-t, 0);
end

function [k] = neighb(f_ind, k_size)
  global distances;
  [~,sortedInd] = sort(distances(f_ind, [1:f_ind-1, f_ind+1:end]));
  k = sortedInd(1:k_size)';
end

function [h] = max_d(f_ind)
  global distances;
  h = max(distances(f_ind,:));
end