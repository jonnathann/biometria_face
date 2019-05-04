clear all
clc
pessoas=106;
Piramide={'DB2','DB4','SYM3','SYM4','SYM5'};
Direcional={'5-3','9-7','PKVA','HAAR'};
Caracteristicas={'Face','Iris'};
qtdIris=10;
qtdFace=84;
for car=1:length(Caracteristicas)
    for pir=1:length(Piramide)
        for dir=3:3
            Dados=[];
            for p=1:pessoas
                load(strcat('D:\Bases De Dados\Shumla\Bases Construidas\',Caracteristicas{car},'\Contourlet\',Piramide{pir},...
                    '\',Caracteristicas{car},'_Contourlet_',Piramide{pir},'_',Direcional{dir},...
                    '.pessoa',int2str(p),'.mat'));
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
                if car==1
                    arq=strcat('D:\Bases De Dados\Shumla\Bases Construidas\',Caracteristicas{car},'\Contourlet\',Piramide{pir},...
                    '\',Caracteristicas{car},'_Contourlet_',Piramide{pir},'_',Direcional{dir},...
                    '.pessoa',int2str(p),'.mat');
                    load(arq);
                    BaseDados.X=Dados((p-1)*qtdFace+1:p*qtdFace,:);
                    save(arq,'BaseDados');
                else
                    arq=strcat('D:\Bases De Dados\Shumla\Bases Construidas\',Caracteristicas{car},'\Contourlet\',Piramide{pir},...
                    '\',Caracteristicas{car},'_Contourlet_',Piramide{pir},'_',Direcional{dir},...
                    '.pessoa',int2str(p),'.mat');
                    load(arq);
                    BaseDados.X=Dados((p-1)*qtdIris+1:p*qtdIris,:);
                    save(arq,'BaseDados');
                end
            end
        end
    end
end