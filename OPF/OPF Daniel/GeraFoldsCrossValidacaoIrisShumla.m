clear all;
close all;
clc;
% Quantidade de Classes
qtdpessoas=106;
% Quantidade de Dados por Classe
qtdimage=10;
% Número de Folds
nfold=10;
% Armazena uma ordem aleatória dos dados a serem escolhidos
separados=zeros(qtdimage,qtdpessoas);
for i=1:qtdpessoas
    ind=randperm(qtdimage);
    ind=(i-1)*qtdimage+ind;
    separados(:,i)=ind;
end
% Quantidade de Folds Maiores
FoldsMaiores=mod(qtdimage*qtdpessoas,nfold);
% Quantidade de Dados por Classe por Fold
ElementosFold=floor(qtdimage/nfold);
for k=1:nfold
    if k<=FoldsMaiores
%         Seleciona os elementos de teste, adicionando um elemento extra de
%         cada classe no caso de um fold maior
        DadosTeste=[(k-1)*ElementosFold+1:k*ElementosFold,nfold*ElementosFold+k];
        fold(k).teste=separados(DadosTeste,:);
%       Faz uma cópia da matriz dos dados        
        treino=separados;
%         Retira os elementos de teste da matriz de treinamento
        treino(DadosTeste,:)=[];
%         Gera um vetor permutação sobre a quantidade de dados de treino
%         por classe
        ind=randperm(size(treino,1));
%         Seleciona 1/3 da quantidade de dados de treino para validação,
%         mantendo a proporção por classe
        DadosValidacao=ind(1:floor(length(ind)/3));
        fold(k).validacao=treino(DadosValidacao,:);
        DadosTreino=ind(floor(length(ind)/3)+1:end);
%         Seleciona o restante dos dados para o treinamento, mantendo a
%         proporção por classe.
        fold(k).treino=treino(DadosTreino,:);
    else
%         Seleciona os elementos de teste, adicionando um elemento extra de
%         cada classe no caso de um fold maior
        DadosTeste=[(k-1)*ElementosFold+1:k*ElementosFold];
        fold(k).teste=separados(DadosTeste,:);
%       Faz uma cópia da matriz dos dados        
        treino=separados;
%         Retira os elementos de teste da matriz de treinamento
        treino(DadosTeste,:)=[];
%         Gera um vetor permutação sobre a quantidade de dados de treino
%         por classe
        ind=randperm(size(treino,1));
%         Seleciona 1/3 da quantidade de dados de treino para validação,
%         mantendo a proporção por classe
        DadosValidacao=ind(1:floor(length(ind)/3));
        fold(k).validacao=treino(DadosValidacao,:);
        DadosTreino=ind(floor(length(ind)/3)+1:end);
%         Seleciona o restante dos dados para o treinamento, mantendo a
%         proporção por classe.
        fold(k).treino=treino(DadosTreino,:);
    end
    %     
    fold(k).validacao=reshape(fold(k).validacao,1,size(fold(k).validacao,1)*size(fold(k).validacao,2));    
    fold(k).treino=reshape(fold(k).treino,1,size(fold(k).treino,1)*size(fold(k).treino,2));
    fold(k).teste=reshape(fold(k).teste,1,size(fold(k).teste,1)*size(fold(k).teste,2));
end
    saida=strcat('C:\users\daniel\dropbox\daniel\face\bases\ShumlaDatabase\Folds Cross\SDUMLA_Iris_Treino_Validacao_Teste.mat');
    save(saida,'fold');