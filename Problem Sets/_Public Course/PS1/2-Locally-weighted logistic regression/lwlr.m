function [y] = lwlr(X_train, y_train, x, tau)
x = x';

[m, n] = size(X_train);
X_train = [ones(m,1), X_train];
n=n+1;

mx = size(x, 1);
x = [ones(mx,1), x];

y = zeros(mx,1);

lambda = 1e-4;

for k=1:mx
  
  teta = zeros(n,1);
  
  % 1) compute weights w(i) for each training example, using the formula above
  xk= repelem(x(k,:),m,1); %cria uma matriz repetindo o exemplo de teste m vezes
  w = exp( -sum((xk-X_train).^2,2) /(2*tau^2) ); %calcula w
  %w = exp( (-sum(xi-X_train,2).^2) /(2*tau^2) ); %calcula w

  % 2) maximize ?(?) using Newton’s method
  Gf = ones(n,1);
  while (norm(Gf) > 1e-6)
    [Gf, Hf] = calcFunc(teta, X_train, y_train, w, lambda, n);
    teta = teta - Hf \ Gf;
  end
  
  % 3) output y = 1{h?(x) > 0.5} as the prediction.
  h_x = 1 ./ (1 + exp(-x(k,:)*teta));
  y(k) = h_x>.5;
  %y(k) = double(x(k,:)*teta > 0);
end

end