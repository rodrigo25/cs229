function [ Gl, Hl ] = calcFunc( X, y, teta )
  h = 1 ./ (1 + exp(-X*teta));
  
  Gl = X'*(y-h);
  
  n = size(X,2);
  %Hl = - X'*(repmat(h.*(1-h),1,n).*X);
  
  Hl = - X'* diag(h.*(1-h)) *X;
end

