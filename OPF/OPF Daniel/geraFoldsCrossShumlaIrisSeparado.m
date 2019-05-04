clear all
clc
pessoas=106;
folds=10;
qtdimagens=10;
for p=1:106
    Imgs=randperm(qtdimagens);
    for k=1:folds
        fold(k).teste{p}=Imgs(k);
        treino=1:qtdimagens;
        treino(fold(k).teste{p})=[];
        fold(k).treino{p}=treino;
    end
end

saida='C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Folds Cross\SDUMLA_Iris_Separado.mat';
save(saida,'fold');