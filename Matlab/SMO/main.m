%Carrega dados
load dados_svm.mat


%Define Constantes
Ker = 'poly';
param = 2;
C = .0000223;
%param = 5;
%C = .000000004;

Ker = 'rbf';
param = .2;
C = 1;

%[alfa, b] = traina_svm (Xtr, Ytr, C, Ker, param);

tol = 1e-5;
max_passes = 1;
%C = .005;
[alfa, b] = SMO (C, tol, max_passes, Xtr, Ytr, Ker, param);





%Classificação do Conjunto de Testes
m = size(Xts, 1);
ns = size(Yts,2);

Y = zeros(m,ns);

for i=1:m
  [~,Y(i,:)] = outputSVM(alfa, b, Xtr, Ytr, Xts(i,:), Ker, param);
end

resultado = abs(Y + Yts);

[Yts Y resultado]

% calculo da acuracia
acertos = sum(resultado == 2);
erros = sum(resultado == 0);
acuracia = acertos/m;

fprintf(' acertos:  %d\n erros:    %d\n acuracia: %2.2f\n', acertos, erros, acuracia)

