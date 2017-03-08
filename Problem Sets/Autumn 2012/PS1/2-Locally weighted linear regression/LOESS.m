% Linear Regression & Locally Weighted Linear Regression

[X y] = loadData;

%Descobre tam dos indices
[m, n] = size(X);

%Adiciona col de 1
X = [ones(m,1) X];
n = n+1;

% i.  Implement (unweighted) linear regression (y = ?T x) on this dataset
%     (using the normal equations), and plot on the same figure the data and the
%     straight line resulting from your fit. (Remember to include the intercept term.)

%Normal Equation
teta = inv(X'*X)* X'*y;

%plota grafico
plot(X(:,2) ,y, 'k.','DisplayName','data'); %posiciona pontos do conj de dados
title('Linear Regression & Locally Weighted Linear Regression');
hold on

[Xsort,indXsort] = sortrows(X,2);
y2 = Xsort*teta;
plot(Xsort(:,2),y2,'b','DisplayName','linear');

% ii. Implement locally weighted linear regression on this dataset (using the
%     weighted normal equations you derived in part (b)), and plot on the same figure
%     the data and the curve resulting from your fit. When evaluating h(·) at a query
%     point x, use weights
%     w(i) = exp[? (x ? x(i))^2 / 2?^2 ],
%     with a bandwidth parameter ? = 0.8. (Again, remember to include the intercept
%     term.)

% iii. Repeat (ii) four times, with ? = 0.1, 0.3, 2 and 10. Comment briefly
%      on what happens to the fit when ? is too small or too large.

tau = [.1 .3 .8 2 10];
cor = ['r','g','y','m','c'];
y2 = zeros(1,m);

for t=1:length(tau) %repete o processo para os diferentes taus
  for k=1:m %realiza a regressão para cada valor do conj de dados
    xk = repmat(X(k,:),m,1);
    w = exp(- sum((xk - X).^2,2) / (2*tau(t)^2) );
    W = diag(w);
  
    teta = pinv(X'*W*X)*X'*W*y;
  
    y2(k) = X(k,:)*teta;
  end
  y2 = y2(indXsort); %
  legenda = ['\tau = ' num2str(tau(t))];
  plot(Xsort(:,2),y2,cor(t),'DisplayName',legenda);
end
legend('Location','southeast')
