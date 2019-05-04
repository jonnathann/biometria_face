clear all;
close all;
clc;
qtdpessoas=106;
qtdimage=10;
nfold=10;
separados=zeros(qtdpessoas,qtdimage);
for i=1:qtdpessoas
    ind=randperm(10);
    separados(i,:)=ind;
end
elementos=zeros(nfold,qtdpessoas);
for f=1:nfold
    for tr=1:qtdpessoas;
        elemento=(tr-1)*10+separados(tr,f);
        elementos(f,tr)=elemento;
    end
end
for k=1:nfold
    selecionados(k).teste=elementos(k,:);
    treino=elementos;
    treino(k,:)=[];
    selecionados(k).treino=treino;
    selecionados(k).treino=reshape(selecionados(k).treino,1,size(selecionados(k).treino,1)*size(selecionados(k).treino,2));
    selecionados(k).teste=reshape(selecionados(k).teste,1,size(selecionados(k).teste,1)*size(selecionados(k).teste,2));
end
saida=strcat('C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Folds Cross\FoldsShumlaCrossIris.mat');
save(saida,'selecionados');

