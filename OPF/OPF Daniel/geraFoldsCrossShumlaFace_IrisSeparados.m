clear all
clc
load('D:\Bases De Dados\Shumla\CombinaIrisFace.mat');
pessoas=106;
folds=10;
qtdimagens=84;
for k=1:folds
    for p=1:106
            fold(k).teste{p}=(find(IrisEscolhida(p,:)==k));
            treino=1:84;
            treino(fold(k).teste{p})=[];
            fold(k).treino{p}=treino;            
    end
end

saida='C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Folds Cross\SDUMLA_Iris+Face_IrisPorFinal.mat';
save(saida,'fold');