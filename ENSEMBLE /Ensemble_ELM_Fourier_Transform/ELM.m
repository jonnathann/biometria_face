function [predict, Yte] = ELM(Xtr, Ytr, Xte, Yte, nh)
ne = size(Xtr, 2);
[N, ~] = size(Ytr);
Xtr = [Xtr, ones(N, 1)];

W = rand(ne + 1, nh)/10;
Hi = Xtr * W;
H = 1./(1 + exp(-Hi));
Bi = pinv(H) * Ytr;
predict = test_ELM(Xte, W, Bi);
end


function Y = test_ELM(Xte, W, B)
[N, ~] = size(Xte);
Xte = [Xte, ones(N, 1)];

Hi = Xte * W;
H = 1./(1 + exp(-Hi));
Y = H * B;
end

