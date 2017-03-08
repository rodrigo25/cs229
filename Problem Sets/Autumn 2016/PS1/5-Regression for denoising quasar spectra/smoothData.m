function [ f ] = smoothData( qso, lambdas )

%     i. First, we must smooth the data in the training dataset to make it more useful
%         for prediction. For each i = 1,...,m, define f(i)(lambda) to be the weighted linear regression
%         estimate the ith spectrum. Use your code from part (b)(ii) above to smooth all spectra
%         in the training set using tau = 5. Do the same for the test set. We will now operate on
%         these smoothed spectra.

[m, n] = size(qso);

X = [ones(n,1) lambdas];

tau = 5;

f = zeros(m,n);

% Smoothing training dataset
for i=1:m
  y = qso(i,:)';
  y2 = zeros(1,n);
  for k=1:n
    xk = repmat(X(k,:),n,1);
    w = exp(- sum((xk - X).^2,2) / (2*tau^2) );
    W = diag(w);
  
    teta = pinv(X'*W*X)*X'*W*y;
  
    y2(k) = X(k,:)*teta;
  end
  f(i,:) = y2;
end



end

