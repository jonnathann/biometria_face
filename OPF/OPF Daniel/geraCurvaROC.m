clear all
close all
clc
% Resolução da Curva ROC
 Roc=500;
% Face
load('Saida_Curvelet_Face_3_LSSVM.mat')
% Seleciona as classes verdadeiras
Saida(:,1)=ClasseSaida(:,1);
% Seleciona as classes do melhor classificador
Saida(:,2)=ClasseSaida(:,5);
% Cria a estrutura auxiliar para armazenar a semelhança e a decisão com
% base no limiar
Saida(:,3)=zeros(length(Saida),1);
% Cria um conjunto de Matrizes de Confusão
Mc=zeros(2,2,Roc);
% Carrega a matriz de semelhança
load('MaisSemelhantes_Face_Curvelet_Nivel_3.mat')
Semelhanca=MaisSemCurv;
% Verifica se cada dado foi classificado corretamente pelo sistema e se ele
% deve ser aceito ou não de acordo com um limiar variando de 0.01 até 1
for d=1:length(Saida)
    Saida(d,3)=Semelhanca(d,Saida(d,2));
    for i=1:Roc
        tr=(1/Roc)*i;
        %         Verdadeiro Positivo
        if(Saida(d,1)==Saida(d,2) && Saida(d,3)>=tr)
            Mc(1,1,i)=Mc(1,1,i)+1;
            %             Falso Negativo
        elseif(Saida(d,1)==Saida(d,2) && Saida(d,3)<tr)
            Mc(2,1,i)=Mc(2,1,i)+1;
            %             Falso Positivo
        elseif(Saida(d,1)~=Saida(d,2) && Saida(d,3)>=tr)
            Mc(1,2,i)=Mc(1,2,i)+1;
            %             Verdadeiro Negativo
        elseif(Saida(d,1)~=Saida(d,2) && Saida(d,3)<tr)
            Mc(2,2,i)=Mc(2,2,i)+1;
        end
    end
end
figure
% Calcula as taxas para a curva ROC
for tx=1:Roc
    %     Taxa de Falsa Aceitação
    FAR(tx)=Mc(1,2,tx)/(Mc(1,2,tx)+Mc(2,2,tx));
    %     Taxa de Falsa Rejeição
    FRR(tx)=Mc(2,1,tx)/(Mc(1,1,tx)+Mc(2,1,tx));
end
Y=1/Roc:1/Roc:1;
plot(Y,FAR,'r',Y,FRR,'b')
box off
set(gca,'FontSize',12)
axis([0,1.01,0,1.01])
title('Taxa de Falsa Aceitação X Taxa de Falsa Rejeição')
xlabel('Limiar de Semelhança');
ylabel('Valor da Taxa');
legend('Falsa Aceitação','Falsa Rejeição','Fontsize',8,'Location','southoutside');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\ROC\CurvaROC_Face_Unimodal.jpg');
% Salva a estrutura
resultado.MC=Mc;
resultado.FAR=FAR;
resultado.FRR=FRR;
resultado.Saida=Saida;
arqSaida='C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\ROC\Arquivo_ROC_Face_Curvelet_3_Unimodal.mat';
save(arqSaida,'resultado');
clear resultado

% Íris
load('Saida_Wavelet_Iris_DB2.mat')
Saida=ClasseSaida(:,1);
Saida(:,2)=ClasseSaida(:,5);
Saida(:,3)=zeros(length(Saida),1);
Mc=zeros(2,2,Roc);
load('MaisSemelhantes_Iris_Wavelet_DB2.mat')
Semelhanca=MaisSemWave;

for d=1:length(Saida)
    Saida(d,3)=Semelhanca(d,Saida(d,2));
    for i=1:Roc
        tr=(1/Roc)*i;
        %         Verdadeiro Positivo
        if(Saida(d,1)==Saida(d,2) && Saida(d,3)>=tr)
            Mc(1,1,i)=Mc(1,1,i)+1;
            %             Falso Negativo
        elseif(Saida(d,1)==Saida(d,2) && Saida(d,3)<tr)
            Mc(2,1,i)=Mc(2,1,i)+1;
            %             Falso Positivo
        elseif(Saida(d,1)~=Saida(d,2) && Saida(d,3)>=tr)
            Mc(1,2,i)=Mc(1,2,i)+1;
            %             Verdadeiro Negativo
        elseif(Saida(d,1)~=Saida(d,2) && Saida(d,3)<tr)
            Mc(2,2,i)=Mc(2,2,i)+1;
        end
    end
end
figure
% Calcula as taxas para a curva ROC
for tx=1:Roc
    %     Taxa de Falsa Aceitação
    FAR(tx)=Mc(1,2,tx)/(Mc(1,2,tx)+Mc(2,2,tx));
    %     Taxa de Falsa Rejeição
    FRR(tx)=Mc(2,1,tx)/(Mc(1,1,tx)+Mc(2,1,tx));
end
Y=1/Roc:1/Roc:1;
plot(Y,FAR,'r',Y,FRR,'b')
box off
set(gca,'FontSize',12)
axis([0,1.01,0,1.01])
title('Taxa de Falsa Aceitação X Taxa de Falsa Rejeição')
xlabel('Limiar de Semelhança');
ylabel('Valor da Taxa');
legend('Falsa Aceitação','Falsa Rejeição','Fontsize',8,'Location','southoutside');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\ROC\CurvaROC_Iris_Unimodal.jpg');
resultado.MC=Mc;
resultado.FAR=FAR;
resultado.FRR=FRR;
resultado.Saida=Saida;
arqSaida='C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\ROC\Arquivo_ROC_Iris_Wavelet_DB2_Unimodal.mat';
save(arqSaida,'resultado');
clear resultado

% Face - Ensemble
 load('Saida_Comitê_Classificadores_Curvelet_Face_Nivel_3.mat');
 Saida=resultado.a(:,1);
 Saida(:,2)=resultado.a(:,5);
 Saida(:,3)=zeros(length(Saida),1);
 Mc=zeros(2,2,Roc);
 Semelhanca=resultado.MatSem(:,4);
 clear resultado
 
 for d=1:length(Saida)
     Saida(d,3)=Semelhanca(d);
     for i=1:Roc
         tr=(1/Roc)*i;
         %         Verdadeiro Positivo
        if(Saida(d,1)==Saida(d,2) && Saida(d,3)>=tr)
            Mc(1,1,i)=Mc(1,1,i)+1;
            %             Falso Negativo
        elseif(Saida(d,1)==Saida(d,2) && Saida(d,3)<tr)
            Mc(2,1,i)=Mc(2,1,i)+1;
            %             Falso Positivo
        elseif(Saida(d,1)~=Saida(d,2) && Saida(d,3)>=tr)
            Mc(1,2,i)=Mc(1,2,i)+1;
            %             Verdadeiro Negativo
        elseif(Saida(d,1)~=Saida(d,2) && Saida(d,3)<tr)
            Mc(2,2,i)=Mc(2,2,i)+1;
        end
    end
end
figure
% Calcula as taxas para a curva ROC
for tx=1:Roc
    %     Taxa de Falsa Aceitação
    FAR(tx)=Mc(1,2,tx)/(Mc(1,2,tx)+Mc(2,2,tx));
    %     Taxa de Falsa Rejeição
    FRR(tx)=Mc(2,1,tx)/(Mc(1,1,tx)+Mc(2,1,tx));
end
Y=1/Roc:1/Roc:1;
plot(Y,FAR,'r',Y,FRR,'b')
box off
set(gca,'FontSize',12)
axis([0,1.01,0,1.01])
title('Taxa de Falsa Aceitação X Taxa de Falsa Rejeição')
xlabel('Limiar de Semelhança');
ylabel('Valor da Taxa');
legend('Falsa Aceitação','Falsa Rejeição','Fontsize',8,'Location','southoutside');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\ROC\CurvaROC_Face_Ensemble.jpg');
resultado.MC=Mc;
resultado.FAR=FAR;
resultado.FRR=FRR;
resultado.Saida=Saida;
arqSaida='C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\ROC\Arquivo_ROC_Face_Ensemble_Curvelet_3_Unimodal.mat';
save(arqSaida,'resultado');
clear resultado


% Íris - Ensemble
load('Saida_Comitê_MelhorClassificador_Iris_LSSVM.mat');
Saida=resultado.a;
clear resultado
Mc=zeros(2,2,Roc);
for d=1:length(Saida)
    for i=1:Roc
        tr=(1/Roc)*i;
        %         Verdadeiro Positivo
        if(Saida(d,1)==Saida(d,2) && Saida(d,3)>=tr)
            Mc(1,1,i)=Mc(1,1,i)+1;
            %             Falso Negativo
        elseif(Saida(d,1)==Saida(d,2) && Saida(d,3)<tr)
            Mc(2,1,i)=Mc(2,1,i)+1;
            %             Falso Positivo
        elseif(Saida(d,1)~=Saida(d,2) && Saida(d,3)>=tr)
            Mc(1,2,i)=Mc(1,2,i)+1;
            %             Verdadeiro Negativo
        elseif(Saida(d,1)~=Saida(d,2) && Saida(d,3)<tr)
            Mc(2,2,i)=Mc(2,2,i)+1;
        end
    end
end
figure
% Calcula as taxas para a curva ROC
for tx=1:Roc
    %     Taxa de Falsa Aceitação
    FAR(tx)=Mc(1,2,tx)/(Mc(1,2,tx)+Mc(2,2,tx));
    %     Taxa de Falsa Rejeição
    FRR(tx)=Mc(2,1,tx)/(Mc(1,1,tx)+Mc(2,1,tx));
end
Y=1/Roc:1/Roc:1;
plot(Y,FAR,'r',Y,FRR,'b')
box off
set(gca,'FontSize',12)
axis([0,1.01,0,1.01])
title('Taxa de Falsa Aceitação X Taxa de Falsa Rejeição')
xlabel('Limiar de Semelhança');
ylabel('Valor da Taxa');
legend('Falsa Aceitação','Falsa Rejeição','Fontsize',8,'Location','southoutside');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\ROC\CurvaROC_Iris_Ensemble.jpg');
resultado.MC=Mc;
resultado.FAR=FAR;
resultado.FRR=FRR;
resultado.Saida=Saida;
arqSaida='C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\ROC\Arquivo_ROC_Iris_Ensemble_MelhorClassificador_Unimodal.mat';
save(arqSaida,'resultado');
clear resultado

% Multimodal
load('Saida_Curvelet_Iris+Face_3_Concatenacao_LSSVM.mat');
Saida=ClasseSaida(:,1);
Saida(:,2)=ClasseSaida(:,6);
Saida(:,3)=zeros(length(Saida),1);
load('MaisSemelhantes_Concatenacao_Curvelet_Nivel_3.mat');
Mc=zeros(2,2,Roc);
Semelhanca=MaisSemCurv;

for d=1:length(Saida)
     Saida(d,3)=Semelhanca(d,Saida(d,2));
    for i=1:Roc
        tr=(1/Roc)*i;
        %         Verdadeiro Positivo
        if(Saida(d,1)==Saida(d,2) && Saida(d,3)>=tr)
            Mc(1,1,i)=Mc(1,1,i)+1;
            %             Falso Negativo
        elseif(Saida(d,1)==Saida(d,2) && Saida(d,3)<tr)
            Mc(2,1,i)=Mc(2,1,i)+1;
            %             Falso Positivo
        elseif(Saida(d,1)~=Saida(d,2) && Saida(d,3)>=tr)
            Mc(1,2,i)=Mc(1,2,i)+1;
            %             Verdadeiro Negativo
        elseif(Saida(d,1)~=Saida(d,2) && Saida(d,3)<tr)
            Mc(2,2,i)=Mc(2,2,i)+1;
        end
    end
end
figure
% Calcula as taxas para a curva ROC
for tx=1:Roc
    %     Taxa de Falsa Aceitação
    FAR(tx)=Mc(1,2,tx)/(Mc(1,2,tx)+Mc(2,2,tx));
    %     Taxa de Falsa Rejeição
    FRR(tx)=Mc(2,1,tx)/(Mc(1,1,tx)+Mc(2,1,tx));
end
Y=1/Roc:1/Roc:1;
plot(Y,FAR,'r',Y,FRR,'b')
box off
set(gca,'FontSize',12)
axis([0,1.01,0,1.01])
title('Taxa de Falsa Aceitação X Taxa de Falsa Rejeição')
xlabel('Limiar de Semelhança');
ylabel('Valor da Taxa');
legend('Falsa Aceitação','Falsa Rejeição','Fontsize',8,'Location','southoutside');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\ROC\CurvaROC_Multimodal_Concatenacao.jpg');
% Salva a estrutura
resultado.MC=Mc;
resultado.FAR=FAR;
resultado.FRR=FRR;
resultado.Saida=Saida;
arqSaida='C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\ROC\Arquivo_ROC_Face_Curvelet_3_Concatenacao_Multimodal.mat';
save(arqSaida,'resultado');
clear resultado

% Multimodal - Ensemble
load('Saida_Comitê_MelhorClassificador__SVM.mat');
Saida=resultado.a;
clear resultado
Mc=zeros(2,2,Roc);
for d=1:length(Saida)
%      if Saida(d,3)>=0.9
%          Saida(d,3)=Saida(d,3)-rand*0.3;
%      end
    for i=1:Roc
        tr=(1/Roc)*i;
        %         Verdadeiro Positivo
        if(Saida(d,1)==Saida(d,2) && Saida(d,3)>=tr)
            Mc(1,1,i)=Mc(1,1,i)+1;
            %             Falso Negativo
        elseif(Saida(d,1)==Saida(d,2) && Saida(d,3)<tr)
            Mc(2,1,i)=Mc(2,1,i)+1;
            %             Falso Positivo
        elseif(Saida(d,1)~=Saida(d,2) && Saida(d,3)>=tr)
            Mc(1,2,i)=Mc(1,2,i)+1;
            %             Verdadeiro Negativo
        elseif(Saida(d,1)~=Saida(d,2) && Saida(d,3)<tr)
            Mc(2,2,i)=Mc(2,2,i)+1;
        end
    end
end
figure
% Calcula as taxas para a curva ROC
for tx=1:Roc
    %     Taxa de Falsa Aceitação
    FAR(tx)=Mc(1,2,tx)/(Mc(1,2,tx)+Mc(2,2,tx));
    %     Taxa de Falsa Rejeição
    FRR(tx)=Mc(2,1,tx)/(Mc(1,1,tx)+Mc(2,1,tx));
end
Y=1/Roc:1/Roc:1;
plot(Y,FAR,'r',Y,FRR,'b')
box off
set(gca,'FontSize',12)
axis([0,1.01,0,1.01])
title('Taxa de Falsa Aceitação X Taxa de Falsa Rejeição')
xlabel('Limiar de Semelhança');
ylabel('Valor da Taxa');
legend('Falsa Aceitação','Falsa Rejeição','Fontsize',8,'Location','southoutside');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\ROC\CurvaROC_Multimodal_Ensemble.jpg');
resultado.MC=Mc;
resultado.FAR=FAR;
resultado.FRR=FRR;
resultado.Saida=Saida;
arqSaida='C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\ROC\Arquivo_ROC_Multimodal_Ensemble.mat';
save(arqSaida,'resultado');
clear resultado
close all
