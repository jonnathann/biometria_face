pessoas=50;
fotos=7;
poses=[3,4,7];
dir=12;
X=[];
qtdfotos=36;
nfold=10;
% Matriz Inteira
% for p=1:pessoas
%     for d=1:dir
%         X=[X,(p-1)*84+(poses+(d-1)*fotos)];
%     end
%     Dados(p,:)=X;
%     X=[];
% end


% % % % % % % % % % % % % % % % % % % % 
% Apenas frontal
for p=1:pessoas
    X(p,:)=randperm(36)+(p-1)*36;
end
DadosFold=floor(qtdfotos/nfold);

for k=1:nfold
    fold(k).teste=X(:,((k-1)*DadosFold)+1:(k*DadosFold));
    if k<=mod(qtdfotos,nfold)
        fold(k).teste=[fold(k).teste,X(:,((nfold)*DadosFold)+k)];
    end        
    fold(k).teste=reshape(fold(k).teste,1,numel(fold(k).teste))
    Treino=min(min(X)):max(max(X))
    Treino(fold(k).teste)=[];
    fold(k).treino=Treino;
end
saida='C:\users\daniel\dropbox\daniel\face\bases\shumlaDatabase\folds Cross\FoldsShumlaCrossFace_Frontal.mat';
save(saida,'fold');

