function [accuracy, predict_classe, predict_prob] = MLP(Xtr, Ytr, Xte, Yte, nh, epochs)

ne = size(Xtr, 2);
[N, ns] = size(Ytr);
Xtr = [ones(N, 1), Xtr];

A = rands(nh, ne + 1)/10;
B = rands(ns, nh + 1)/10;

[~, erro, ~, ~, ~] = gradient(Xtr, Ytr, A, B, N);

EQM = sum(sum(erro.*erro))/N;
epoch = 0;
while(EQM >= 1e-5 && epoch < epochs)
    
    [~, erro, g, gradA, gradB] = gradient(Xtr, Ytr, A, B, N);
    
    EQM = sum(sum(erro.*erro))/N;
    d = -g;
    
    alpha = calc_alfa(Xtr,Ytr, A, B,gradA, gradB, d, N);
    B = B - alpha*gradB;
    A = A - alpha*gradA;
    
    fprintf('EQM =%2.7f | Epochs=%i\n', EQM, epoch);
    epoch = epoch + 1;
    
end
[accuracy, predict_classe, predict_prob] = test_MLP(Xte, Yte, A, B);
end

function [Y, erro, g, gradA, gradB] = gradient(Xtr, Ytr, A, B, N)

Zin = Xtr * A';
Z = 1./(1 + exp(-Zin));

Yin = [ones(N, 1), Z] * B';
Y = 1./(1 + exp(-Yin));

erro = Y - Ytr;

gradB = 1/N*(erro.*(Y.*(1-Y)))'*[ones(N,1),Z];
djdz = (erro.* (Y.*(1-Y)))*B(:,2:end);
gradA = 1/N*(djdz.*(Z.*(1-Z)))'*Xtr;

g = [gradA(:); gradB(:)];
end

function alfa = calc_alfa(Xtr, Ytr, A, B, gA, gB, d, N)

alfa_l= 0;
alfa_u = rand(1, 1);
Aaux = A - alfa_u*gA;
Baux = B - alfa_u*gB;
[~, ~, g, ~, ~]=gradient(Xtr, Ytr, Aaux, Baux, N);
hl = g'*d;

while hl<0 
    alfa_u = alfa_u*2;
    Aaux = A - alfa_u*gA;
    Baux = B - alfa_u*gB;
    [~, ~, g, ~, ~]=gradient(Xtr,Ytr,Aaux,Baux,N);
    hl = g'*d;
end
epsilon = 1e-8;
alfa_m = alfa_u;
nitmax = ceil(log(alfa_u - alfa_l/epsilon));
nit = 0;

while abs(hl)>epsilon && nit < nitmax
    nit = nit + 1;
    alfa_m = (alfa_l+alfa_u)/2;
    Aaux = A - alfa_m*gA;
    Baux = B - alfa_m*gB;
    [~, ~, g, ~, ~]=gradient(Xtr,Ytr,Aaux,Baux,N);
    hl = g'*d;
    
    if hl<0
        alfa_l = alfa_m;
    else 
        alfa_u = alfa_m;
    end
end
alfa = alfa_m;
end

function [accuracy, predict_classe, predict_prob] = test_MLP(Xte, Yte, A, B)

[N, ~] = size(Yte);
X = [ones(N, 1), Xte];
Zin = X * A';
Z = 1./(1 + exp(-Zin));
Yin = [ones(N, 1), Z] * B';
Y = 1./(1 + exp(-Yin));

[predict_classe, predict_prob] = convert(Y);
predict = [predict_classe, convert(Yte)];

count = 0;
total_instances = size(predict, 1);
for i=1:total_instances
    
    if predict(i, 1) == predict(i, 2)
        count = count + 1;
    end
end
accuracy = (count * 100)/total_instances;
end







