function conj = normalizar(dados)

conj = [];

for i = 1:size(dados, 2)
    media = mean(dados(:,i));
    desvio = std(dados(:,i));
    x = dados(:,i);
    aux = (x-media)/desvio;
    conj = [conj, aux];
end