clear all
close all
clc
% Quantidade Face e Multimodal
QtdFace=84;
QtdIris=10;
QtdClasses=106;
QtdPoses=7;
QtdCategorias=12;
% Face
load('Saida_Curvelet_Face_3_LSSVM.mat')
% Seleciona as classes verdadeiras
Saida(:,1)=ClasseSaida(:,1);
% Seleciona as classes do melhor classificador
Saida(:,2)=ClasseSaida(:,5);
TaxaErroPessoa=zeros(1,QtdClasses);
% Taxa de Erro por pessoa
for p=1:QtdClasses
    K=find(Saida((p-1)*QtdFace+1:p*QtdFace,2)~=p);
    TaxaErroPessoa(p)=size(K,1)/QtdFace;
    if p==1
        Pessoa.Classe=p;
        Pessoa.Taxa=TaxaErroPessoa(p);
        Saidas=zeros(1,QtdClasses);
        for pAux=1:QtdClasses
            aux=find(Saida((p-1)*QtdFace+1:p*QtdFace,2)==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Pessoa.Saidas=Saidas;
    elseif TaxaErroPessoa(p)>Pessoa.Taxa
        Pessoa.Classe=p;
        Pessoa.Taxa=TaxaErroPessoa(p);
        Saidas=zeros(1,QtdClasses);
        for pAux=1:QtdClasses
            aux=find(Saida((p-1)*QtdFace+1:p*QtdFace,2)==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Pessoa.Saidas=Saidas;
    end
end
resultado.TaxaErroPessoa=TaxaErroPessoa;
resultado.Pessoa=Pessoa;

figure
bar(TaxaErroPessoa);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,1])
title('Taxa de Erro por Indivíduo - Face')
xlabel('Indivíduo');
ylabel('Taxa de Erro');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPessoa_Unimodal_Face.jpg');

figure
bar(Pessoa.Saidas);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,84])
title(['Saida das imagens do indivíduo ',int2str(Pessoa.Classe)])
xlabel('Saída do Classificador');
ylabel('Taxa de classificação');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPiorPessoa_Unimodal_Face.jpg');
close all

% Taxa de Erro por pose;
TaxaErroPose=zeros(1,QtdPoses);
for p=1:QtdPoses
    X=p:QtdPoses:QtdFace*QtdClasses;
    X=X';
    K=find(Saida(X,2)~=Saida(X,1));
    TaxaErroPose(p)=size(K,1)/size(X,1);
    if p==1
        Pose.Classe=p;
        Pose.Taxa=TaxaErroPose(p);
        Saidas=zeros(1,QtdClasses);
        auxSaida=ceil(X(K)/QtdFace);
        for pAux=1:QtdClasses
            aux=find(auxSaida==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Pose.Saidas=Saidas;
    elseif TaxaErroPose(p)>Pose.Taxa
        Pose.Classe=p;
        Pose.Taxa=TaxaErroPose(p);
        Saidas=zeros(1,QtdClasses);
        auxSaida=ceil(X(K)/QtdFace);
        for pAux=1:QtdClasses
            aux=find(auxSaida==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Pose.Saidas=Saidas;
    end
end
resultado.TaxaErroPose=TaxaErroPose;
resultado.PiorPose=Pose;

figure
bar(TaxaErroPose);
box off
set(gca,'FontSize',12)
axis([0.5,QtdPoses+0.5 , 0,1])
title('Taxa de Erro por Pose - Face')
xlabel('Pose');
ylabel('Taxa de Erro');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPorPose_Unimodal_Face.jpg');

figure
bar(Pose.Saidas);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,12])
title(['Taxa de imagens classificadas incorretas da pose ',int2str(Pose.Classe)])
xlabel('Classe');
ylabel('Taxa de erro');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPiorPose_Unimodal_Face.jpg');

close all
% Erro por categoria de foto
TaxaErroCategoria=zeros(1,QtdCategorias);
for cat=1:QtdCategorias
    X=[];
    for p=1:QtdClasses
        if p==1
            X=(cat-1)*QtdPoses+1:cat*QtdPoses;
        else
            aux=((cat-1)*QtdPoses+1)+(p-1)*QtdFace:(cat*QtdPoses)+(p-1)*QtdFace;
            X=[X,aux];
        end
    end
    X=X';
    K=find(Saida(X,2)~=Saida(X,1));
    TaxaErroCategoria(cat)=size(K,1)/size(X,1);
    if cat==1
        Categoria.Classe=cat;
        Categoria.Taxa=TaxaErroCategoria(cat);
        Saidas=zeros(1,QtdClasses);
        auxSaida=ceil(X(K)/QtdFace);
        for pAux=1:QtdClasses
            aux=find(auxSaida==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Categoria.Saidas=Saidas;
    elseif TaxaErroCategoria(cat)>Categoria.Taxa
        Categoria.Classe=cat;
        Categoria.Taxa=TaxaErroCategoria(cat);
        Saidas=zeros(1,QtdClasses);
        auxSaida=ceil(X(K)/QtdFace);
        for pAux=1:QtdClasses
            aux=find(auxSaida==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Categoria.Saidas=Saidas;
    end
end
resultado.TaxaErroCategoria=TaxaErroCategoria;
resultado.PiorCategoria=Categoria;

figure
bar(TaxaErroCategoria);
box off
set(gca,'FontSize',12)
axis([0.5,QtdCategorias+0.5 , 0,1])
title('Taxa de Erro por Categoria - Face')
xlabel('Categoria');
ylabel('Valor da Taxa');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPorCategoria_Unimodal_Face.jpg');

figure
bar(Categoria.Saidas);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,7])
title(['Taxa de imagens classificadas incorretas da categoria ',int2str(Categoria.Classe)])
xlabel('Classe');
ylabel('Taxa de erro');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPiorCategoria_Unimodal_Face.jpg');
arqSaida='C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\Arquivo_DesempenhoFace_Unimodal.mat';
save(arqSaida,'resultado');
clear resultado
close all


% Íris
load('Saida_Wavelet_Iris_DB2.mat')
Saida=ClasseSaida(:,1);
Saida(:,2)=ClasseSaida(:,5);
TaxaErroPessoa=zeros(1,QtdClasses);
% Taxa de Erro por pessoa
for p=1:QtdClasses
    K=find(Saida((p-1)*QtdIris+1:p*QtdIris,2)~=p);
    TaxaErroPessoa(p)=size(K,1)/QtdIris;
    if p==1
        Pessoa.Classe=p;
        Pessoa.Taxa=TaxaErroPessoa(p);
        Saidas=zeros(1,QtdClasses);
        for pAux=1:QtdClasses
            aux=find(Saida((p-1)*QtdIris+1:p*QtdIris,2)==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Pessoa.Saidas=Saidas;
    elseif TaxaErroPessoa(p)>Pessoa.Taxa
        Pessoa.Classe=p;
        Pessoa.Taxa=TaxaErroPessoa(p);
        Saidas=zeros(1,QtdClasses);
        for pAux=1:QtdClasses
            aux=find(Saida((p-1)*QtdIris+1:p*QtdIris,2)==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Pessoa.Saidas=Saidas;
    end
end
resultado.TaxaErroPessoa=TaxaErroPessoa;
resultado.Pessoa=Pessoa;

figure
bar(TaxaErroPessoa);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,1])
title('Taxa de Erro por Indivíduo - Iris')
xlabel('Indivíduo');
ylabel('Taxa de Erro');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPessoa_Unimodal_Iris.jpg');

figure
bar(Pessoa.Saidas);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,10])
title(['Saida das imagens do indivíduo ',int2str(Pessoa.Classe)])
xlabel('Saída do Classificador');
ylabel('Taxa de classificação');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPiorPessoa_Unimodal_Iris.jpg');
% Por Íris
TaxaErroCategoria=zeros(1,2);
for cat=1:2
    X=[];
    for p=1:QtdClasses
        if p==1
            X=(cat-1)*5+1:cat*5;
        else
            aux=((cat-1)*5+1)+(p-1)*QtdIris:(cat*5)+(p-1)*QtdIris;
            X=[X,aux];
        end
    end
    X=X';
    K=find(Saida(X,2)~=Saida(X,1));
    TaxaErroCategoria(cat)=size(K,1)/size(X,1);
    if cat==1
        Categoria.Classe=cat;
        Categoria.Taxa=TaxaErroCategoria(cat);
        Saidas=zeros(1,QtdClasses);
        auxSaida=ceil(X(K)/QtdIris);
        for pAux=1:QtdClasses
            aux=find(auxSaida==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Categoria.Saidas=Saidas;
    elseif TaxaErroCategoria(cat)>Categoria.Taxa
        Categoria.Classe=cat;
        Categoria.Taxa=TaxaErroCategoria(cat);
        Saidas=zeros(1,QtdClasses);
        auxSaida=ceil(X(K)/QtdIris);
        for pAux=1:QtdClasses
            aux=find(auxSaida==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Categoria.Saidas=Saidas;
    end
end
resultado.TaxaErroCategoria=TaxaErroCategoria;
resultado.PiorCategoria=Categoria;

figure
bar(TaxaErroCategoria);
box off
set(gca,'FontSize',12)
axis([0.5,2.5 , 0,1])
title('Taxa de Erro por Iris')
xlabel('Íris');
set(gca,'XTickLabel',{'Esquerda','Direita'})
ylabel('Valor da Taxa');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPorIris_Unimodal_Iris.jpg');

figure
bar(Categoria.Saidas);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,5])
if Categoria.Classe==1
    iris='esquerda';
else
    iris='direita';
end
title(['Taxa de imagens classificadas incorretas da íris ',iris])
xlabel('Classe');
ylabel('Taxa de erro');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPiorIris_Unimodal_Iris.jpg');
arqSaida='C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\Arquivo_DesempenhoIris_Unimodal.mat';
save(arqSaida,'resultado');
clear resultado
close all

% Face - Ensemble
load('Saida_Comitê_Classificadores_Curvelet_Face_Nivel_3.mat');
Saida=resultado.a(:,1);
Saida(:,2)=resultado.a(:,5);
TaxaErroPessoa=zeros(1,QtdClasses);
% Taxa de Erro por pessoa
for p=1:QtdClasses
    K=find(Saida((p-1)*QtdFace+1:p*QtdFace,2)~=p);
    TaxaErroPessoa(p)=size(K,1)/QtdFace;
    if p==1
        Pessoa.Classe=p;
        Pessoa.Taxa=TaxaErroPessoa(p);
        Saidas=zeros(1,QtdClasses);
        for pAux=1:QtdClasses
            aux=find(Saida((p-1)*QtdFace+1:p*QtdFace,2)==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Pessoa.Saidas=Saidas;
    elseif TaxaErroPessoa(p)>Pessoa.Taxa
        Pessoa.Classe=p;
        Pessoa.Taxa=TaxaErroPessoa(p);
        Saidas=zeros(1,QtdClasses);
        for pAux=1:QtdClasses
            aux=find(Saida((p-1)*QtdFace+1:p*QtdFace,2)==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Pessoa.Saidas=Saidas;
    end
end
resultado.TaxaErroPessoa=TaxaErroPessoa;
resultado.Pessoa=Pessoa;

figure
bar(TaxaErroPessoa);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,1])
title('Taxa de Erro por Indivíduo - Face Ensemble')
xlabel('Indivíduo');
ylabel('Taxa de Erro');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPessoa_Unimodal_Face_Ensemble.jpg');

figure
bar(Pessoa.Saidas);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,84])
title(['Saida das imagens do indivíduo ',int2str(Pessoa.Classe),' com a abordagem de Ensemble'])
xlabel('Saída do Classificador');
ylabel('Taxa de classificação');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPiorPessoa_Unimodal_Face_Ensemble.jpg');
close all


% Taxa de Erro por pose;
TaxaErroPose=zeros(1,QtdPoses);
for p=1:QtdPoses
    X=p:QtdPoses:QtdFace*QtdClasses;
    X=X';
    K=find(Saida(X,2)~=Saida(X,1));
    TaxaErroPose(p)=size(K,1)/size(X,1);
    if p==1
        Pose.Classe=p;
        Pose.Taxa=TaxaErroPose(p);
        Saidas=zeros(1,QtdClasses);
        auxSaida=ceil(X(K)/QtdFace);
        for pAux=1:QtdClasses
            aux=find(auxSaida==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Pose.Saidas=Saidas;
    elseif TaxaErroPose(p)>Pose.Taxa
        Pose.Classe=p;
        Pose.Taxa=TaxaErroPose(p);
        Saidas=zeros(1,QtdClasses);
        auxSaida=ceil(X(K)/QtdFace);
        for pAux=1:QtdClasses
            aux=find(auxSaida==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Pose.Saidas=Saidas;
    end
end
resultado.TaxaErroPose=TaxaErroPose;
resultado.PiorPose=Pose;

figure
bar(TaxaErroPose);
box off
set(gca,'FontSize',12)
axis([0.5,QtdPoses+0.5 , 0,1])
title('Taxa de Erro por Pose - Face Ensemble')
xlabel('Pose');
ylabel('Taxa de Erro');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPorPose_Unimodal_Face_Ensemble.jpg');

figure
bar(Pose.Saidas);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,12])
title(['Taxa de imagens classificadas incorretas da pose ',int2str(Pose.Classe),'com o uso de ensemble'])
xlabel('Classe');
ylabel('Taxa de erro');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPiorPose_Unimodal_Face_Ensemble.jpg');
close all

% Erro por categoria de foto
TaxaErroCategoria=zeros(1,QtdCategorias);
for cat=1:QtdCategorias
    X=[];
    for p=1:QtdClasses
        if p==1
            X=(cat-1)*QtdPoses+1:cat*QtdPoses;
        else
            aux=((cat-1)*QtdPoses+1)+(p-1)*QtdFace:(cat*QtdPoses)+(p-1)*QtdFace;
            X=[X,aux];
        end
    end
    X=X';
    K=find(Saida(X,2)~=Saida(X,1));
    TaxaErroCategoria(cat)=size(K,1)/size(X,1);
    if cat==1
        Categoria.Classe=cat;
        Categoria.Taxa=TaxaErroCategoria(cat);
        Saidas=zeros(1,QtdClasses);
        auxSaida=ceil(X(K)/QtdFace);
        for pAux=1:QtdClasses
            aux=find(auxSaida==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Categoria.Saidas=Saidas;
    elseif TaxaErroCategoria(cat)>Categoria.Taxa
        Categoria.Classe=cat;
        Categoria.Taxa=TaxaErroCategoria(cat);
        Saidas=zeros(1,QtdClasses);
        auxSaida=ceil(X(K)/QtdFace);
        for pAux=1:QtdClasses
            aux=find(auxSaida==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Categoria.Saidas=Saidas;
    end
end
resultado.TaxaErroCategoria=TaxaErroCategoria;
resultado.PiorCategoria=Categoria;

figure
bar(TaxaErroCategoria);
box off
set(gca,'FontSize',12)
axis([0.5,QtdCategorias+0.5 , 0,1])
title('Taxa de Erro por Categoria - Face')
xlabel('Categoria');
ylabel('Valor da Taxa');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPorCategoria_Unimodal_Face_Ensemble.jpg');

figure
bar(Categoria.Saidas);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,7])
title(['Taxa de imagens classificadas incorretas da categoria ',int2str(Categoria.Classe),' com o uso de ensemble'])
xlabel('Classe');
ylabel('Taxa de erro');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPiorCategoria_Unimodal_Face_Ensemble.jpg');
arqSaida='C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\Arquivo_DesempenhoFace_Unimodal_Ensemble.mat';
save(arqSaida,'resultado');
clear resultado
close all


% Íris - Ensemble
load('Saida_Comitê_MelhorClassificador_Iris_LSSVM.mat');
Saida=resultado.a;
TaxaErroPessoa=zeros(1,QtdClasses);
% Taxa de Erro por pessoa
for p=1:QtdClasses
    K=find(Saida((p-1)*QtdIris+1:p*QtdIris,2)~=p);
    TaxaErroPessoa(p)=size(K,1)/QtdIris;
    if p==1
        Pessoa.Classe=p;
        Pessoa.Taxa=TaxaErroPessoa(p);
        Saidas=zeros(1,QtdClasses);
        for pAux=1:QtdClasses
            aux=find(Saida((p-1)*QtdIris+1:p*QtdIris,2)==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Pessoa.Saidas=Saidas;
    elseif TaxaErroPessoa(p)>Pessoa.Taxa
        Pessoa.Classe=p;
        Pessoa.Taxa=TaxaErroPessoa(p);
        Saidas=zeros(1,QtdClasses);
        for pAux=1:QtdClasses
            aux=find(Saida((p-1)*QtdIris+1:p*QtdIris,2)==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Pessoa.Saidas=Saidas;
    end
end
resultado.TaxaErroPessoa=TaxaErroPessoa;
resultado.Pessoa=Pessoa;

figure
bar(TaxaErroPessoa);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,1])
title('Taxa de Erro por Indivíduo - Iris Ensemble')
xlabel('Indivíduo');
ylabel('Taxa de Erro');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPessoa_Unimodal_Iris_Ensemble.jpg');

figure
bar(Pessoa.Saidas);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,10])
title(['Saida das imagens do indivíduo ',int2str(Pessoa.Classe),' com o uso de ensemble'])
xlabel('Saída do Classificador');
ylabel('Taxa de classificação');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPiorPessoa_Unimodal_Iris_Ensemle.jpg');

TaxaErroCategoria=zeros(1,2);
for cat=1:2
    X=[];
    for p=1:QtdClasses
        if p==1
            X=(cat-1)*5+1:cat*5;
        else
            aux=((cat-1)*5+1)+(p-1)*QtdIris:(cat*5)+(p-1)*QtdIris;
            X=[X,aux];
        end
    end
    X=X';
    K=find(Saida(X,2)~=Saida(X,1));
    TaxaErroCategoria(cat)=size(K,1)/size(X,1);
    if cat==1
        Categoria.Classe=cat;
        Categoria.Taxa=TaxaErroCategoria(cat);
        Saidas=zeros(1,QtdClasses);
        auxSaida=ceil(X(K)/QtdIris);
        for pAux=1:QtdClasses
            aux=find(auxSaida==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Categoria.Saidas=Saidas;
    elseif TaxaErroCategoria(cat)>=Categoria.Taxa
        Categoria.Classe=cat;
        Categoria.Taxa=TaxaErroCategoria(cat);
        Saidas=zeros(1,QtdClasses);
        auxSaida=ceil(X(K)/QtdIris);
        for pAux=1:QtdClasses
            aux=find(auxSaida==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Categoria.Saidas=Saidas;
    end
end
resultado.TaxaErroCategoria=TaxaErroCategoria;
resultado.PiorCategoria=Categoria;

figure
bar(TaxaErroCategoria);
box off
set(gca,'FontSize',12)
axis([0.5,2.5 , 0,1])
title('Taxa de Erro por Íris com o uso de Ensemble')
xlabel('Íris');
set(gca,'XTickLabel',{'Esquerda','Direita'})
ylabel('Valor da Taxa');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPorIris_Unimodal_Iris_Ensemble.jpg');

figure
bar(Categoria.Saidas);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,5])
if Categoria.Classe==1
    iris='esquerda';
else
    iris='direita';
end
title(['Taxa de imagens classificadas incorretas da íris ',iris,' com o uso de ensemble'])
xlabel('Classe');
ylabel('Taxa de erro');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPiorIris_Unimodal_Iris_Ensemble.jpg');
arqSaida='C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\Arquivo_DesempenhoIris_Unimodal_Ensemble.mat';
save(arqSaida,'resultado');
clear resultado
close all

% Multimodal
load('Saida_Curvelet_Iris+Face_3_Concatenacao_LSSVM.mat');
Saida=ClasseSaida(:,1);
Saida(:,2)=ClasseSaida(:,6);
TaxaErroPessoa=zeros(1,QtdClasses);
% Taxa de Erro por pessoa
for p=1:QtdClasses
    K=find(Saida((p-1)*QtdFace+1:p*QtdFace,2)~=p);
    TaxaErroPessoa(p)=size(K,1)/QtdFace;
    if p==1
        Pessoa.Classe=p;
        Pessoa.Taxa=TaxaErroPessoa(p);
        Saidas=zeros(1,QtdClasses);
        for pAux=1:QtdClasses
            aux=find(Saida((p-1)*QtdFace+1:p*QtdFace,2)==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Pessoa.Saidas=Saidas;
    elseif TaxaErroPessoa(p)>Pessoa.Taxa
        Pessoa.Classe=p;
        Pessoa.Taxa=TaxaErroPessoa(p);
        Saidas=zeros(1,QtdClasses);
        for pAux=1:QtdClasses
            aux=find(Saida((p-1)*QtdFace+1:p*QtdFace,2)==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Pessoa.Saidas=Saidas;
    end
end
resultado.TaxaErroPessoa=TaxaErroPessoa;
resultado.Pessoa=Pessoa;

figure
bar(TaxaErroPessoa);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,1])
title('Taxa de Erro por Indivíduo - Estratégia de Concatenação')
xlabel('Indivíduo');
ylabel('Taxa de Erro');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPessoa_Multimodal_Concatenacao.jpg');

figure
bar(Pessoa.Saidas);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,84])
title(['Saida das imagens do indivíduo ',int2str(Pessoa.Classe),' com a estratégia de Concatenação'])
xlabel('Saída do Classificador');
ylabel('Taxa de classificação');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPiorPessoa_Multimodal_Concatenacao.jpg');
close all


% Taxa de Erro por pose;
TaxaErroPose=zeros(1,QtdPoses);
for p=1:QtdPoses
    X=p:QtdPoses:QtdFace*QtdClasses;
    X=X';
    K=find(Saida(X,2)~=Saida(X,1));
    TaxaErroPose(p)=size(K,1)/size(X,1);
    if p==1
        Pose.Classe=p;
        Pose.Taxa=TaxaErroPose(p);
        Saidas=zeros(1,QtdClasses);
        auxSaida=ceil(X(K)/QtdFace);
        for pAux=1:QtdClasses
            aux=find(auxSaida==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Pose.Saidas=Saidas;
    elseif TaxaErroPose(p)>Pose.Taxa
        Pose.Classe=p;
        Pose.Taxa=TaxaErroPose(p);
        Saidas=zeros(1,QtdClasses);
        auxSaida=ceil(X(K)/QtdFace);
        for pAux=1:QtdClasses
            aux=find(auxSaida==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Pose.Saidas=Saidas;
    end
end
resultado.TaxaErroPose=TaxaErroPose;
resultado.PiorPose=Pose;

figure
bar(TaxaErroPose);
box off
set(gca,'FontSize',12)
axis([0.5,QtdPoses+0.5 , 0,1])
title('Taxa de Erro por Pose - Estratégia de Concatenação')
xlabel('Pose');
ylabel('Taxa de Erro');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPorPose_Multimodal_Concatenacao.jpg');
figure
bar(Pose.Saidas);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,12])
title(['Taxa de imagens classificadas incorretas da pose ',int2str(Pose.Classe)])
xlabel('Classe');
ylabel('Taxa de erro');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPiorPose_Multimodal_Concatenacao.jpg');
close all

% Erro por categoria de foto
TaxaErroCategoria=zeros(1,QtdCategorias);
for cat=1:QtdCategorias
    X=[];
    for p=1:QtdClasses
        if p==1
            X=(cat-1)*QtdPoses+1:cat*QtdPoses;
        else
            aux=((cat-1)*QtdPoses+1)+(p-1)*QtdFace:(cat*QtdPoses)+(p-1)*QtdFace;
            X=[X,aux];
        end
    end
    X=X';
    K=find(Saida(X,2)~=Saida(X,1));
    TaxaErroCategoria(cat)=size(K,1)/size(X,1);
    if cat==1
        Categoria.Classe=cat;
        Categoria.Taxa=TaxaErroCategoria(cat);
        Saidas=zeros(1,QtdClasses);
        auxSaida=ceil(X(K)/QtdFace);
        for pAux=1:QtdClasses
            aux=find(auxSaida==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Categoria.Saidas=Saidas;
    elseif TaxaErroCategoria(cat)>Categoria.Taxa
        Categoria.Classe=cat;
        Categoria.Taxa=TaxaErroCategoria(cat);
        Saidas=zeros(1,QtdClasses);
        auxSaida=ceil(X(K)/QtdFace);
        for pAux=1:QtdClasses
            aux=find(auxSaida==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Categoria.Saidas=Saidas;
    end
end
resultado.TaxaErroCategoria=TaxaErroCategoria;
resultado.PiorCategoria=Categoria;

figure
bar(TaxaErroCategoria);
box off
set(gca,'FontSize',12)
axis([0.5,QtdCategorias+0.5 , 0,1])
title('Taxa de Erro por Categoria - Estratégia de Concatenação')
xlabel('Categoria');
ylabel('Valor da Taxa');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPorCategoria_Multimodal_Concatenacao.jpg');

figure
bar(Categoria.Saidas);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,7])
title(['Taxa de imagens classificadas incorretas da categoria ',int2str(Categoria.Classe)])
xlabel('Classe');
ylabel('Taxa de erro');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPiorCategoria_Multimodal_Concatenacao.jpg');
arqSaida='C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\Arquivo_Desempenho_Multimodal_Concatenacao.mat';
save(arqSaida,'resultado');
clear resultado
close all

% Multimodal - Ensemble
load('Saida_Comitê_MelhorClassificador__SVM.mat');
Saida=resultado.a;
clear resultado
TaxaErroPessoa=zeros(1,QtdClasses);
% Taxa de Erro por pessoa
for p=1:QtdClasses
    K=find(Saida((p-1)*QtdFace+1:p*QtdFace,2)~=p);
    TaxaErroPessoa(p)=size(K,1)/QtdFace;
    if p==1
        Pessoa.Classe=p;
        Pessoa.Taxa=TaxaErroPessoa(p);
        Saidas=zeros(1,QtdClasses);
        for pAux=1:QtdClasses
            aux=find(Saida((p-1)*QtdFace+1:p*QtdFace,2)==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Pessoa.Saidas=Saidas;
    elseif TaxaErroPessoa(p)>Pessoa.Taxa
        Pessoa.Classe=p;
        Pessoa.Taxa=TaxaErroPessoa(p);
        Saidas=zeros(1,QtdClasses);
        for pAux=1:QtdClasses
            aux=find(Saida((p-1)*QtdFace+1:p*QtdFace,2)==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Pessoa.Saidas=Saidas;
    end
end
resultado.TaxaErroPessoa=TaxaErroPessoa;
resultado.Pessoa=Pessoa;

figure
bar(TaxaErroPessoa);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,1])
title('Taxa de Erro por Indivíduo - Multimodal Ensemble')
xlabel('Indivíduo');
ylabel('Taxa de Erro');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPessoa_Multimodal_Ensemble.jpg');

figure
bar(Pessoa.Saidas);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,84])
title(['Saida das imagens do indivíduo ',int2str(Pessoa.Classe),' com Ensemble'])
xlabel('Saída do Classificador');
ylabel('Taxa de classificação');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPiorPessoa_Multimodal_Ensemble.jpg');
close all


% Taxa de Erro por pose;
TaxaErroPose=zeros(1,QtdPoses);
for p=1:QtdPoses
    X=p:QtdPoses:QtdFace*QtdClasses;
    X=X';
    K=find(Saida(X,2)~=Saida(X,1));
    TaxaErroPose(p)=size(K,1)/size(X,1);
    if p==1
        Pose.Classe=p;
        Pose.Taxa=TaxaErroPose(p);
        Saidas=zeros(1,QtdClasses);
        auxSaida=ceil(X(K)/QtdFace);
        for pAux=1:QtdClasses
            aux=find(auxSaida==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Pose.Saidas=Saidas;
    elseif TaxaErroPose(p)>Pose.Taxa
        Pose.Classe=p;
        Pose.Taxa=TaxaErroPose(p);
        Saidas=zeros(1,QtdClasses);
        auxSaida=ceil(X(K)/QtdFace);
        for pAux=1:QtdClasses
            aux=find(auxSaida==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Pose.Saidas=Saidas;
    end
end
resultado.TaxaErroPose=TaxaErroPose;
resultado.PiorPose=Pose;

figure
bar(TaxaErroPose);
box off
set(gca,'FontSize',12)
axis([0.5,QtdPoses+0.5 , 0,1])
title('Taxa de Erro por Pose - Multimodal Ensemble')
xlabel('Pose');
ylabel('Taxa de Erro');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPorPose_Multimodal_Ensemble.jpg');
figure
bar(Pose.Saidas);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,12])
title(['Taxa de imagens classificadas incorretas da pose ',int2str(Pose.Classe)])
xlabel('Classe');
ylabel('Taxa de erro');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPiorPose_Multimodal_Ensemble.jpg');
close all

% Erro por categoria de foto
TaxaErroCategoria=zeros(1,QtdCategorias);
for cat=1:QtdCategorias
    X=[];
    for p=1:QtdClasses
        if p==1
            X=(cat-1)*QtdPoses+1:cat*QtdPoses;
        else
            aux=((cat-1)*QtdPoses+1)+(p-1)*QtdFace:(cat*QtdPoses)+(p-1)*QtdFace;
            X=[X,aux];
        end
    end
    X=X';
    K=find(Saida(X,2)~=Saida(X,1));
    TaxaErroCategoria(cat)=size(K,1)/size(X,1);
    if cat==1
        Categoria.Classe=cat;
        Categoria.Taxa=TaxaErroCategoria(cat);
        Saidas=zeros(1,QtdClasses);
        auxSaida=ceil(X(K)/QtdFace);
        for pAux=1:QtdClasses
            aux=find(auxSaida==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Categoria.Saidas=Saidas;
    elseif TaxaErroCategoria(cat)>Categoria.Taxa
        Categoria.Classe=cat;
        Categoria.Taxa=TaxaErroCategoria(cat);
        Saidas=zeros(1,QtdClasses);
        auxSaida=ceil(X(K)/QtdFace);
        for pAux=1:QtdClasses
            aux=find(auxSaida==pAux);
            Saidas(pAux)=size(aux,1);
        end
        Categoria.Saidas=Saidas;
    end
end
resultado.TaxaErroCategoria=TaxaErroCategoria;
resultado.PiorCategoria=Categoria;

figure
bar(TaxaErroCategoria);
box off
set(gca,'FontSize',12)
axis([0.5,QtdCategorias+0.5 , 0,1])
title('Taxa de Erro por Categoria - Multimodal Ensemble')
xlabel('Categoria');
ylabel('Valor da Taxa');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPorCategoria_Multimodal_Ensemble.jpg');

figure
bar(Categoria.Saidas);
box off
set(gca,'FontSize',12)
axis([0.5,QtdClasses+0.5 , 0,7])
title(['Taxa de imagens classificadas incorretas da categoria ',int2str(Categoria.Classe)])
xlabel('Classe');
ylabel('Taxa de erro');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ErroPiorCategoria_Multimodal_Ensemble.jpg');
arqSaida='C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\Arquivo_Desempenho_Multimodal_Ensemble.mat';
save(arqSaida,'resultado');
clear resultado
