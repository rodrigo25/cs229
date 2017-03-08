%% (b) Visualizing the data
%load data
load_quasar_data;

%%     i. Use the normal equations to implement (unweighted) linear regression
%        on the rst training example (i.e. rst non-header row). On one fig ure, plot both
%        the raw data and the straight line resulting from your fit. State the optimal teta
%        resulting from the linear regression.

n = size(lambdas,1);

X1 = [ones(n,1) lambdas];
y = train_qso(1,:)';

teta = inv(X1'*X1)* X1'*y;

%plota grafico
%plot(lambdas ,y, 'k+ ' ); %posiciona pontos do conj de dados
%title('Linear Regression');
%hold on

%y2 = X1*teta;
%plot(lambdas ,y2 ,'b');

%fprintf('Teta: (%2.4f, %2.4f)\n', teta)




%%     ii. Implement locally weighted linear regression on the first training example.
%        Use the normal equations you derived in part (a)(ii). On a dierent figure, plot both
%        the raw data and the smooth curve resulting from your fit. When evaluating h(.) at a
%        query point x, use weights w(i) with bandwidth parameter tau = 5.
%
%     iii. Repeat (b)(ii) four more times with tau = 1; 10; 100 and 1000. Plot the resulting curves.

plot(lambdas ,y, 'k.','DisplayName','data'); %posiciona pontos do conj de dados
title('Locally Weighted Linear Regression');
hold on

tau = [1 5 10 100 1000];
cor = ['r' 'b' 'g' 'm' 'c'];
y2 = zeros(1,n);

for t=1:length(tau)
  for k=1:n
    xk = repmat(X1(k,:),n,1);
    w = exp(- sum((xk - X1).^2,2) / (2*tau(t)^2) );
    W = diag(w);
  
    teta = pinv(X1'*W*X1)*X1'*W*y;
  
    y2(k) = X1(k,:)*teta;
  end
  legenda = ['\tau = ' num2str(tau(t))];
  plot(lambdas, y2, cor(t), 'DisplayName', legenda);
end
legend('Location','northeast')
