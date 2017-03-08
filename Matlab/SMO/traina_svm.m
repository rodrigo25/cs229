function [alfa,b] = traina_svm (X, Y, C, Ker, param)

K = kernel( X, X, Ker, param );
H = (Y*Y').*K;

[N,ne]=size(X);
c = -ones(N,1);
A = Y';
%options = optimset('Display','off');
%alfa = quadprog(H, c, [], [], A, 0, zeros(N,1), C*ones(N, 1), [], options);
alfa = quadprog(H, c, [], [], A, 0, zeros(N,1), C*ones(N,1));
NSV = sum(alfa>0);
id = find(alfa>0);
b = (1/NSV)*sum((K*(alfa.*Y) - Y));
end

