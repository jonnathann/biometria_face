function [accuracy, predict] = ELM(Xtr, Ytr, Xte, Yte, nh)
ne = size(Xtr, 2);
[N, ~] = size(Ytr);
Xtr = [Xtr, ones(N, 1)];

W = rand(ne + 1, nh)/10;
Hi = Xtr * W;
H = 1./(1 + exp(-Hi));
Bi = pinv(H) * Ytr;
%Y = H * Bi;
[accuracy, predict] = test_ELM(Xte, Yte, W, Bi);
end


function [accuracy, Y] = test_ELM(Xte, Yte, W, B)
[N, ~] = size(Yte);
Xte = [Xte, ones(N, 1)];

Hi = Xte * W;
H = 1./(1 + exp(-Hi));
Y = H * B;
Ys = softmax(Y, ftp); %Funçao de ativação softmax
predict = [convert(Ys), convert(Yte)];

count = 0;
total_instances = size(predict, 1);
for i=1:total_instances
    
    if predict(i, 1) ==  predict(i, 2)
        count = count + 1;
    end
end
accuracy = (100*count)/total_instances;
end

