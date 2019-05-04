% Converte os arquivos que estavam no formato .txt e converte para o
% formato de entrada do .OPF
Car={'Face','Iris'};
Abordagens={'MIN_MAX','MEAN_MAX','FACE_LL_IRIS','IRIS_LL_FACE','Concatenacao','EDGE','Soma','SomaPonderada'};
nfold=10;
arq='C:\Users\Daniel\Desktop\OPF\geraOPF-Completos_Shearlet.bat';
fid=fopen(arq,'w');
 for c=2:length(Car)
     for w=1:3
         ArqEntrada=strcat('BasesOriginais\Completas\',Car{c},'_Shearlet_Nivel',int2str(4-w),'.txt');
         ArqSaida=strcat('OPF\Completos\',Car{c},'_Shearlet_',int2str(4-w),'.opf');
         fprintf(fid,'txt2opf %s %s \n',ArqEntrada,ArqSaida);
     end
 end
% for a=1:length(Abordagens)
%     for w=1:1
%         ArqEntrada=strcat('BasesOriginais\Completas\FaceIris_',Abordagens{a},'_Shearlet_Nivel',int2str(4-w),'.txt');
%         ArqSaida=strcat('OPF\Completos\FaceIris_',Abordagens{a},'_Shearlet_Nivel',int2str(4-w),'.opf');
%         fprintf(fid,'txt2opf %s %s \n',ArqEntrada,ArqSaida);
%     end
% end
fclose(fid);