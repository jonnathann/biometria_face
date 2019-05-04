clear all
clc
pessoas=106;
Wavelets={'DB2','DB4','SYM3','SYM4','SYM5'};
Caracteristicas={'Face','Iris'};
qtdIris=10;
qtdFace=84;
for car=1:length(Caracteristicas)
    for w=1:length(Wavelets)
        Dados=[];
        for p=1:pessoas
            load(strcat('D:\Bases De Dados\Shumla\Bases Construidas\',Caracteristicas{car},'\Wavelet\',Wavelets{w},...
                '\',Caracteristicas{car},'_Wavelet_',Wavelets{w},'.pessoa',int2str(p),'.mat'));
            Dados=[Dados;BaseDados.X];
        end
        XM=mean(Dados);
        Dados=Dados-repmat(XM,size(Dados,1),1);
        Xstd=std(Dados);
        Dados=Dados./repmat(Xstd,size(Dados,1),1);
        for p=1:pessoas
            if car==1
                arq=strcat('D:\Bases De Dados\Shumla\Bases Construidas\',Caracteristicas{car},'\Wavelet\',Wavelets{w},...
                    '\Face_Wavelet_',Wavelets{w},'.pessoa',int2str(p),'.mat');
                load(arq);
                BaseDados.X=Dados((p-1)*qtdFace+1:p*qtdFace,:);
                save(arq,'BaseDados');
            else
                arq=strcat('D:\Bases De Dados\Shumla\Bases Construidas\',Caracteristicas{car},'\Wavelet\',Wavelets{w},...
                    '\Iris_Wavelet_',Wavelets{w},'.pessoa',int2str(p),'.mat');
                load(arq);
                BaseDados.X=Dados((p-1)*qtdIris+1:p*qtdIris,:);
                save(arq,'BaseDados');
            end
        end
    end
end