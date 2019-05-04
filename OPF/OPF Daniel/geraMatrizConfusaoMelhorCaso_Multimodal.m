QtdClasses=106;
QtdFace=84;
QtdPoses=7;
QtdCategorias=12;

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