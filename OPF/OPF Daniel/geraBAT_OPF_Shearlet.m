% Gera o bat que converte os arquivos de treinamento e teste para o formato
% que o OPF trabalha
Car={'Face','Iris'};
Abordagens={'MIN_MAX','MEAN_MAX','FACE_LL_IRIS','IRIS_LL_FACE','Concatenacao','EDGE','Soma','SomaPonderada'};
nfold=10;
arq='C:\Users\Daniel\Desktop\OPF\geraOPF_Shearlet.bat';
fid=fopen(arq,'w');
 for c=2:length(Car)
     for w=1:3
         for k=1:nfold
             ArqETeste=strcat('BasesOriginais\',Car{c},'\',Car{c},'_Shearlet_Nivel',int2str(4-w),'_Fold_',int2str(k),'_Teste.txt');
             ArqSTeste=strcat('OPF\',Car{c},'\',Car{c},'_Shearlet_Nivel',int2str(4-w),'_Fold_',int2str(k),'_Teste.opf');            
             fprintf(fid,'txt2opf %s %s \n',ArqETeste,ArqSTeste);
             ArqETreino=strcat('BasesOriginais\',Car{c},'\',Car{c},'_Shearlet_Nivel',int2str(4-w),'_Fold_',int2str(k),'_Treino.txt');
             ArqSTreino=strcat('OPF\',Car{c},'\',Car{c},'_Cuvelet_Nivel',int2str(4-w),'_Fold_',int2str(k),'_Treino.opf');
             fprintf(fid,'txt2opf %s %s \n',ArqETreino,ArqSTreino);
         end
     end
 end
% for a=1:length(Abordagens)
%     for w=1:3
%         for k=1:10
%             ArqETeste=strcat('BasesOriginais\FaceIris\FaceIris_Shearlet_Nivel',int2str(4-w),'_',Abordagens{a},'_Fold_',int2str(k),'_Teste.txt');            
%             ArqSTeste=strcat('OPF\FaceIris\FaceIris_',Abordagens{a},'_Shearlet_Nivel',int2str(4-w),'_Fold_',int2str(k),'_Teste.opf');
%             fprintf(fid,'txt2opf %s %s \n',ArqETeste,ArqSTeste);
%             ArqETreino=strcat('BasesOriginais\FaceIris\FaceIris_Shearlet_Nivel',int2str(4-w),'_',Abordagens{a},'_Fold_',int2str(k),'_Treino.txt');
%             ArqSTreino=strcat('OPF\FaceIris\FaceIris_',Abordagens{a},'_Shearlet_Nivel',int2str(4-w),'_Fold_',int2str(k),'_Treino.opf');
%             fprintf(fid,'txt2opf %s %s \n',ArqETreino,ArqSTreino);
%         end
%     end
% end
fclose(fid)