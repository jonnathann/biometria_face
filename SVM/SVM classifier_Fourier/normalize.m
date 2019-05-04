function conj = normalize(data)
[~,col] = size(data);
media = mean(data,2);
A = data - repmat(media,1,col);
desvio = std(data')';
conj = A ./ repmat(desvio,1,col);
end