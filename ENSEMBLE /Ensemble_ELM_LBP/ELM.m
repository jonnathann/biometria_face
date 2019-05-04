function predict = ELM(Xtr, Ytr, Xte, Yte, nh)
ne = size(Xtr, 2);
[N, ~] = size(Ytr);
Xtr = [Xtr, ones(N, 1)];

W = rand(ne + 1, nh)/10;
Hi = Xtr * W;
H = 1./(1 + exp(-Hi));
Bi = pinv(H) * Ytr;
predict = test_ELM(Xte, Yte, W, Bi);
end


function Y = test_ELM(Xte, Yte, W, B)
[N, ~] = size(Yte);
Xte = [Xte, ones(N, 1)];

Hi = Xte * W;
H = 1./(1 + exp(-Hi));
Y = H * B;
end

