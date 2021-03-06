% Gera o bat que converte os arquivos de treinamento e teste para o formato
% que o OPF trabalha
Car={'Face','Iris'};
Wavelets={'DB2','DB4','SYM3','SYM4','SYM5'};
Abordagens={'MIN_MAX','MEAN_MAX','FACE_LL_IRIS','IRIS_LL_FACE','Concatenacao','EDGE','Soma'};
nfold=10;
arq='D:\OPF\geraOPF_Contourlet_Multimodal.bat';
fid=fopen(arq,'w');
  for c=1:length(Car)
      for w=1:length(Wavelets)
          for k=1:nfold
              ArqETeste=strcat('BasesOriginais\',Car{c},'\',Car{c},'_Contourlet_',Wavelets{w},'_Fold_',int2str(k),'_Teste.txt');
              ArqSTeste=strcat('OPF\',Car{c},'\',Car{c},'_Contourlet_',Wavelets{w},'_Fold_',int2str(k),'_Teste.opf');            
              fprintf(fid,'txt2opf %s %s \n',ArqETeste,ArqSTeste);
              ArqETreino=strcat('BasesOriginais\',Car{c},'\',Car{c},'_Contourlet_',Wavelets{w},'_Fold_',int2str(k),'_Treino.txt');
              ArqSTreino=strcat('OPF\',Car{c},'\',Car{c},'_Contourlet_',Wavelets{w},'_Fold_',int2str(k),'_Treino.opf');
              fprintf(fid,'txt2opf %s %s \n',ArqETreino,ArqSTreino);
          end
      end
  end
for a=5:length(Abordagens)
    for w=1:length(Wavelets)
        for k=1:nfold
            ArqETeste=strcat('BasesOriginais\FaceIris\FaceIris_',Abordagens{a},'_Contourlet_',Wavelets{w},'_Fold_',int2str(k),'_Teste.txt');
            ArqSTeste=strcat('OPF\FaceIris\Contourlet\FaceIris_',Abordagens{a},'_Contourlet_',Wavelets{w},'_Fold_',int2str(k),'_Teste.opf');
            fprintf(fid,'txt2opf %s %s \n',ArqETeste,ArqSTeste);
            ArqETreino=strcat('BasesOriginais\FaceIris\FaceIris_',Abordagens{a},'_Contourlet_',Wavelets{w},'_Fold_',int2str(k),'_Treino.txt');
            ArqSTreino=strcat('OPF\FaceIris\Contourlet\FaceIris_',Abordagens{a},'_Contourlet_',Wavelets{w},'_Fold_',int2str(k),'_Treino.opf');
            fprintf(fid,'txt2opf %s %s \n',ArqETreino,ArqSTreino);
        end
    end
end
fclose(fid);