% Gera os arquivos de distâncias com base no arquivo que contém os dados e
% as classes no formato do OPF
Car={'Face','Iris'};
Abordagens={'MIN_MAX','MEAN_MAX','FACE_LL_IRIS','IRIS_LL_FACE','Concatenacao','EDGE','Soma','SomaPonderada'};
arq='C:\Users\Daniel\Desktop\OPF\OPF\GeraArquivoDistancia_Curvelet.bat';
Distancias={'Euclidiana','Chi-Square','Manhattan','Canberra','SquareChord','SquareChi-Squared','BrayCurtis'};
DistOP=[1,3,6];
fid=fopen(arq,'w');
%  for c=1:length(Car)
%      for w=1:3
%          for d=1:length(DistOP)
%              ArqEntrada=strcat('Completos\',Car{c},'_Curvelet_Nivel',int2str(4-w),'.opf');
%              fprintf(fid,'opf_distance %s %i 1 \n',ArqEntrada,DistOP(d));
%              ArqDist=strcat(Car{c},'_Curvelet_Nivel',int2str(4-w),'_',Distancias{DistOP(d)},'.dat');
%              fprintf(fid,'rename distances.dat %s \n',ArqDist);
%              fprintf(fid,'move %s Distancias \n',ArqDist);
%          end
%      end
%  end
for a=1:length(Abordagens)
    for w=1:1
        for d=1:length(DistOP)
            ArqEntrada=strcat('Completos\FaceIris_',Abordagens{a},'_Curvelet_Nivel',int2str(w),'.opf');
            fprintf(fid,'opf_distance %s %i 1 \n',ArqEntrada,DistOP(d));
            ArqDist=strcat('FaceIris_',Abordagens{a},'_Curvelet_Nivel',int2str(w),'_',Distancias{DistOP(d)},'.dat');
            fprintf(fid,'rename distances.dat %s \n',ArqDist);
            fprintf(fid,'move %s Distancias \n',ArqDist);
        end
    end
end
fclose(fid);