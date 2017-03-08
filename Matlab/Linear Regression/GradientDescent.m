%teta = [teta0 teta1 ... tetam];
teta = [1;1];
x = [1 5; 1 6; 1 7; 1 15; 1 18];
y = [33;38;43;83;98];

alfa = 0.001;
err=1;
it = 0;
maxit = 20000;
Jit = zeros(maxit,1);

tetaNormalEq = inv(x'*x)*x'*y;

while (err>.01)
    it = it +1;
    h = x*teta;
    
    teta = teta + alfa * ( x' * (y-h) );
    
    err = sum((y-h).^2);
    Jit(it) = err;
end
fprintf('Gradient Descent:\nteta0: %f\nteta1 %f\n', teta)
fprintf('Nº It: %d\n', it)
plot ((1:10), Jit(1:10))

fprintf('\n\nNormal Equations:\nteta0: %f\nteta1 %f\n', tetaNormalEq)