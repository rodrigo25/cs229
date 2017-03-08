function [K] = kernel( X, x, Ker, param )
  if strcmp(Ker, 'linear')
    K = (X*x');
  elseif strcmp(Ker,'poly') 
    K =((X*x').^param + 1);
    
  elseif strcmp(Ker,'rbf')
    K= gaussianKernel_modificado(X,x,param);
  end
end 











function K = gaussianKernel_modificado(X1, X2, param)
    N = size(X2, 1);
    n = size(X1, 1);
    xny = zeros(N, n);
    for i = 1:N
        for j = 1:n
            dif = X2(i, :) - X1(j, :);
            norma = dif*dif';
            xny(i,j) = exp(-norma/(2*param^2));
        end
    end
    K = xny';
end


