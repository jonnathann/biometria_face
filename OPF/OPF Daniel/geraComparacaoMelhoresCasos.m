clear all
close all
clc
load('Arquivo_Desempenho_Multimodal_Ensemble.mat');
Multimodal=resultado;
clear resultado
load('Arquivo_DesempenhoFace_Unimodal.mat');
Unimodal=resultado;
clear resultado

Classes=1:106;
figure
plot(Classes,Unimodal.TaxaErroPessoa,'r',Classes,Multimodal.TaxaErroPessoa,'b');
box off
set(gca,'FontSize',12)
axis([1,106,0,1])
xlabel('Classes');
ylabel('Taxa de Erro');
title('Comparação Face x Multimodal');
legend('Face','Multimodal+Ensemble','Fontsize',8,'Location','southoutside');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ComparacaoPorClasse.jpg');

Classes=1:7;
figure
plot(Classes,Unimodal.TaxaErroPose,'r',Classes,Multimodal.TaxaErroPose,'b');
box off
set(gca,'FontSize',12)
axis([1,7,0,1])
xlabel('Poses');
ylabel('Taxa de Erro');
title('Comparação Face x Multimodal');
legend('Face','Multimodal+Ensemble','Fontsize',8,'Location','southoutside');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ComparacaoPorPose.jpg');

Classes=1:12;
figure
plot(Classes,Unimodal.TaxaErroCategoria,'r',Classes,Multimodal.TaxaErroCategoria,'b');
set(gca,'FontSize',12)
box off
axis([1,12,0,1])
xlabel('Categorias');
ylabel('Taxa de Erro');
title('Comparação Face x Multimodal');
legend('Face','Multimodal+Ensemble','Fontsize',8,'Location','southoutside');
saveas(gcf,'C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Scripts\Auxiliares\GraficoMatConfusao\ComparacaoPorCategoria.jpg');

