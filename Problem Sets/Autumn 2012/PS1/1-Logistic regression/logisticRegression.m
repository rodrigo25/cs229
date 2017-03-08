[X y] = loadData;

%Descobre tam dos indices
[m, n] = size(X);
%Adiciona col de 1
X = [ones(m,1) X];
n = n+1;

%inicia variáveis
teta = zeros(n,1);
Gl = ones(n,1);

%Newton iterations
while (norm(Gl) > 1e-6)
  [Gl, Hl] = calcFunc(X, y, teta);
  teta = teta - Hl \ Gl;
end

%Output function
h_x = 1 ./ (1 + exp(-X*teta));
y2 = h_x>.5;

%Imprime
[y y2]
fprintf('Acurácia: %f\n', sum(y-y2==0)/m)
fprintf('Teta: %f\n      %f\n      %f\n', teta)

%plota grafico
plot(X(y==0,2), X(y==0,3), 'ro');
hold on
plot((X(y==1,2)), (X(y==1,3)), 'bx');

db = @(x1,x2) teta(1) + teta(2)*x1 + teta(3)*x2;
ezplot(db,[0,8,-5,4])
title('Logistic Regression (Newton''s Method)')