clear all;
close all;
clc;
qtdpessoas=106;
qtdimage=84;
nfold=10;
separados=zeros(qtdpessoas,qtdimage);
for i=1:qtdpessoas
    ind=randperm(qtdimage);
    separados(i,:)=ind+(i-1)*qtdimage;
end
for k=1:nfold
    if(k<5)
        fold(k).teste=separados(:,(k-1)*9+1:k*9);
        treino=separados;
        treino(:,(k-1)*9+1:k*9)=[];
        fold(k).treino=treino;
        aux=k*9;
    else
        fold(k).teste=separados(:,(k-1)*8+5:k*8+4);
        treino=separados;
        treino(:,(k-1)*8+5:k*8+4)=[];
        fold(k).treino=treino;
    end
    fold(k).treino=reshape(fold(k).treino',1,size(fold(k).treino,1)*size(fold(k).treino,2));
    fold(k).teste=reshape(fold(k).teste',1,size(fold(k).teste,1)*size(fold(k).teste,2));
end
saida=strcat('C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Folds Cross\FoldsShumlaCrossIrisFaceCompleto.mat');
save(saida,'fold');

