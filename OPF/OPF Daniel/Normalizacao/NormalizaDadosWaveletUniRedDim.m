clear all
clc
pessoas=106;
Wavelets={'DB2','DB4','SYM3','SYM4','SYM5'};
TecRed={'2DLDA','2DPCA','BDPCA'};
Caracteristicas={'Face','Iris'};
qtdIris=10;
qtdFace=84;
for Tec=1:length(TecRed)
    for car=1:1
        for w=1:length(Wavelets)
            Dados=[];
            for p=1:pessoas
                load(strcat('C:\Users\Daniel\Documents\Documentos\Mestrado - Backup\SDUMLA\Bases Construidas\',...
                    Caracteristicas{car},'\Wavelet\RedDim\',TecRed{Tec},'\',...
                    Wavelets{w},'\',Caracteristicas{car},'_Wavelet_',Wavelets{w},'_',TecRed{Tec},'.pessoa',int2str(p),'.mat'));
                Dados=[Dados;BaseDados.X];
            end
            XM=mean(Dados);
            Dados=Dados-repmat(XM,size(Dados,1),1);
            Xstd=std(Dados);
            Dados=Dados./repmat(Xstd,size(Dados,1),1);
            for p=1:pessoas
                if car==1
                    arq=strcat('C:\Users\Daniel\Documents\Documentos\Mestrado - Backup\SDUMLA\Bases Construidas\',...
                        Caracteristicas{car},'\Wavelet\RedDim\',TecRed{Tec},'\',...
                    Wavelets{w},'\Face_Wavelet_',Wavelets{w},'_',TecRed{Tec},'.pessoa',int2str(p),'.mat')
                    load(arq);
                    BaseDados.X=Dados((p-1)*qtdFace+1:p*qtdFace,:);
                    save(arq,'BaseDados');
                else
                    arq=strcat('C:\Users\Daniel\Documents\Documentos\Mestrado - Backup\SDUMLA\Bases Construidas\',...
                        Caracteristicas{car},'\Wavelet\RedDim\',TecRed{Tec},'\',...
                    Wavelets{w},'\Iris_Wavelet_',Wavelets{w},'_',TecRed{Tec},'.pessoa',int2str(p),'.mat');
                    load(arq);
                    BaseDados.X=Dados((p-1)*qtdIris+1:p*qtdIris,:);
                    save(arq,'BaseDados');
                end
            end
        end
    end
end