 load('Arquivo_DesempenhoFace_Unimodal.mat')
 X=resultado.PiorCategoria.Saidas;
 resultado.PiorCategoria.Classe
 load('Arquivo_DesempenhoFace_Unimodal_Ensemble.mat')
 X=[X;resultado.PiorCategoria.Saidas];
 resultado.PiorCategoria.Classe
%  load('Arquivo_DesempenhoIris_Unimodal.mat')
%  X=[X;resultado.PiorCategoria.Saidas];
%  load('Arquivo_DesempenhoIris_Unimodal_Ensemble.mat')
%   X=[X;resultado.PiorCategoria.Saidas];
 load('Arquivo_Desempenho_Multimodal_Concatenacao.mat')
 X=[X;resultado.PiorCategoria.Saidas];
 resultado.PiorCategoria.Classe
 load('Arquivo_Desempenho_Multimodal_Ensemble.mat')
 X=[X;resultado.PiorCategoria.Saidas];
 resultado.PiorCategoria.Classe
csvwrite('CSV_Taxas_PiorCategoria.csv',X);

