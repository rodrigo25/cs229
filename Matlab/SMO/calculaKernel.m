function [H,K] = calculaKernel(X,Y,Ker,param)
    if strcmp(Ker, 'linear')
        K = (X*X');
        H = (Y*Y').*K;
    elseif strcmp(Ker,'poly')
        K=((X*X').^param + 1);
        H = (Y*Y').*K;
    elseif strcmp(Ker,'rbf')
        % baseado em http://www.kernel-methods.net/matlab/kernels/rbf.m
        %{
        n=size(X,1);
        K = (X*X')/param^2;
        d = diag(K);
        K=K-ones(n,1)*d'/2;
        K=K-d*ones(1,n)/2;
        K=exp(K);
        %}
        %K = gaussianKernel(X,X,param);
        K= gaussianKernel_modificado(X,X,param);
        H = (Y*Y').*K;
    end
end

% Extraido de
% https://www.mathworks.com/matlabcentral/fileexchange/34864-decision-boundary-using-svms/content/Decision%20Boundary%20using%20SVMs/gaussianKernel.m
function K = gaussianKernel(X1, X2, param)
    X1 = X1(:); X2 = X2(:);
    xny = X1-X2;
    norma = xny'*xny;
    
    %Normxny =  pdist2(x1,x2,'euclidean');
    K = exp(-norma/(2*param^2));
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
    K = xny;
end