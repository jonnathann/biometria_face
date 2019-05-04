load('Arquivo_ROC_Face_Curvelet_3_Concatenacao_Multimodal.mat')
X=[resultado.FAR;resultado.FRR];
csvwrite('Multimodal_Taxas.csv',X);

load('Arquivo_ROC_Face_Curvelet_3_Unimodal.mat')
X=[resultado.FAR;resultado.FRR];
csvwrite('Face_Taxas.csv',X);

load('Arquivo_ROC_Face_Ensemble_Curvelet_3_Unimodal.mat')
X=[resultado.FAR;resultado.FRR];
csvwrite('Face_Ensemble_Taxas.csv',X);

load('Arquivo_ROC_Iris_Ensemble_MelhorClassificador_Unimodal.mat')
X=[resultado.FAR;resultado.FRR];
csvwrite('Iris_Ensemble_Taxas.csv',X);

load('Arquivo_ROC_Iris_Wavelet_DB2_Unimodal.mat')
X=[resultado.FAR;resultado.FRR];
csvwrite('Iris_Taxas.csv',X);

load('Arquivo_ROC_Multimodal_Ensemble.mat')
X=[resultado.FAR;resultado.FRR];
csvwrite('Multimodal_Ensemble_Taxas.csv',X);