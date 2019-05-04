% Converte os arquivos que estavam no formato .txt e converte para o
% formato de entrada do .OPF
Car={'Face','Iris'};
Wavelets={'DB2','DB4','SYM3','SYM4','SYM5'};
Abordagens={'MIN_MAX','MEAN_MAX','FACE_LL_IRIS','IRIS_LL_FACE','Concatenacao','EDGE','Soma','SomaPonderada'};
nfold=10;
arq='C:\Users\Daniel\Desktop\OPF\geraOPF-Completos.bat';
fid=fopen(arq,'w');
  for c=1:length(Car)
      for w=1:length(Wavelets)
          ArqEntrada=strcat('BasesOriginais\Completas\',Car{c},'_Wavelet_',Wavelets{w},'.txt');
          ArqSaida=strcat('OPF\Completos\',Car{c},'_Wavelet_',Wavelets{w},'.opf');
          fprintf(fid,'txt2opf %s %s \n',ArqEntrada,ArqSaida);
      end
  end
for a=1:length(Abordagens)
    for w=1:length(Wavelets)
        ArqEntrada=strcat('BasesOriginais\Completas\FaceIris_',Abordagens{a},'_Wavelet_',Wavelets{w},'.txt');
        ArqSaida=strcat('OPF\Completos\FaceIris_',Abordagens{a},'_Wavelet_',Wavelets{w},'.opf');
        fprintf(fid,'txt2opf %s %s \n',ArqEntrada,ArqSaida);
    end
end
fclose(fid);