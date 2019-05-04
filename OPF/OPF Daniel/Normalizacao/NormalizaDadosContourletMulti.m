clear all
clc
pessoas=106;
Piramide={'DB2','DB4','SYM3','SYM4','SYM5'};
Direcional={'5-3','9-7','PKVA','HAAR'};
Combinacoes={'MIN_MAX','MEAN_MAX','FACE_LL_IRIS','IRIS_LL_FACE','Concatenacao','EDGE','Soma','SomaPonderada'};
qtdFace=84;
for car=8:length(Combinacoes)
    for pir=1:length(Piramide)
        for dir=3:3
            Dados=[];
            for p=1:pessoas
                load(strcat('D:\bases De Dados\shumla\bases Construidas\faceIris\',Combinacoes{car},'\Contourlet\',Piramide{pir},...
                    '\SDUMLA_Iris+Face.',Combinacoes{car},'.Contourlet.',Piramide{pir},...
                    '.pessoa.',int2str(p),'.mat'));
                if car==1
                    Dados=[Dados;BaseDados.X];
                else
                    Dados=[Dados;BaseDados.X];
                end
            end
            XM=mean(Dados);
            Dados=Dados-repmat(XM,size(Dados,1),1);
            Xstd=std(Dados);
            Dados=Dados./repmat(Xstd,size(Dados,1),1);
            for p=1:pessoas                
                arq=strcat('D:\bases De Dados\shumla\bases Construidas\faceIris\',Combinacoes{car},'\Contourlet\',Piramide{pir},...
                    '\SDUMLA_Iris+Face.',Combinacoes{car},'.Contourlet.',Piramide{pir},...
                    '.pessoa.',int2str(p),'.mat');
                load(arq);
                BaseDados.X=Dados((p-1)*qtdFace+1:p*qtdFace,:);
                save(arq,'BaseDados');                
            end
        end
    end
end