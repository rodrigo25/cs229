%% Locally-weighted logistic regression com Newton's Method e Parameter Regularization

[X,y] = load_data;
m = size(X,1);


%% TESTE PLOT COM O CÓDIGO DADO

%plot_lwlr(X, y, .01, 30);
%return




%% TESTE COM CONJUNTO COMPLETO

%plota conj em preto
plot(X(y==0,1), X(y==0,2), 'ko');
hold on
plot((X(y==1,1)), (X(y==1,2)), 'kx');

[y2] = lwlr(X, y, X', 1);

[y y2]
fprintf('Acurácia: %f\n', sum(y-y2==0)/m)

%plota classificação retornada em vermelho para 0 e verde para 1
plot(X(y2==0,1), X(y2==0,2), 'ro');
hold on
plot((X(y2==1,1)), (X(y2==1,2)), 'gx');

return




%% TESTE COM HOLDOUT (Conjunto muito pequeno)

mX_train = round(m*0.85); %tamanho do holdout

X_tr = X(1:mX_train, :); % separa X de treinamento
y_tr = y(1:mX_train, :); % separa Y de treinamento
X_t = X(mX_train+1:m, :); % separa X de teste
y_t = y(mX_train+1:m, :); % separa Y de teste

y2 = lwlr(X_tr, y_tr, X_t', 0.12);
[y_t y2]
fprintf('Acurácia: %f\n', sum(y_t-y2==0)/size(y2,1))

%plota conj de treinamento preto
plot(X_tr(y_tr==0,1), X_tr(y_tr==0,2), 'ko');
hold on
plot((X_tr(y_tr==1,1)), (X_tr(y_tr==1,2)), 'kx');

%plota conj de teste azul
plot(X_t(y_t==0,1), X_t(y_t==0,2), 'bo');
hold on
plot((X_t(y_t==1,1)), (X_t(y_t==1,2)), 'bx');

%plota resultados do teste por cima em vermelho
plot(X_t(y2==0,1), X_t(y2==0,2), 'ro');
hold on
plot((X_t(y2==1,1)), (X_t(y2==1,2)), 'rx');