clear all;
close all;
clc;
qtdpessoas=106;
qtdimage=10;
nfold=10;
separados=zeros(qtdpessoas,qtdimage);
for k=1:nfold
    for i=1:qtdpessoas
        ind=randperm(qtdimage);
        separados(i,:)=ind+(i-1)*qtdimage;
    end
    selecionados(k).treino=separados(:,1:7);
    selecionados(k).teste=separados(:,8:end);
    selecionados(k).treino=reshape(selecionados(k).treino',1,size(selecionados(k).treino,1)*size(selecionados(k).treino,2));
    selecionados(k).teste=reshape(selecionados(k).teste',1,size(selecionados(k).teste,1)*size(selecionados(k).teste,2));
end
saida=strcat('C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Folds Holdout\FoldsShumlaHoldOutFace.mat');
save(saida,'selecionados');
