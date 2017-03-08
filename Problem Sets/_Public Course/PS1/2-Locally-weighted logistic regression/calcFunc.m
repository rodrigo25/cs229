function [ Gf, Hf ] = calcFunc( teta, X, y, w, lambda, n )

  h = 1 ./ (1 + exp(-X*teta));
  
  z = w.*(y-h);
  Gf = X'*z - lambda * teta;

  D = diag( -w.*h.*(1-h) );
  Hf = X'*D*X - lambda*eye(n);

end

