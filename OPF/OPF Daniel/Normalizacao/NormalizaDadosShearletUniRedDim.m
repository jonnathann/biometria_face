% Ja foi
clear all
clc
pessoas=106;
Niveis=1:3;
Caracteristicas={'Face','Iris'};
TecRed={'2DLDA','BDPCA','2DPCA'};
qtdFace=84;
qtdIris=10;
QtdParte=5000;
for Tec=1:length(TecRed)
    for car=1:length(Caracteristicas)
        arq=strcat('C:\Users\Daniel\Documents\Documentos\Mestrado - Backup\SDUMLA\Bases Construidas\',Caracteristicas{car},'\Shearlet\RedDim\',TecRed{Tec},...
            '\',Caracteristicas{car},'_Shearlet_',TecRed{Tec},'.pessoa1.mat')
        load(arq);
        QtdCar=size(BaseDados.X,2);
        Partes=ceil(QtdCar/QtdParte);
        clear BaseDados
        for parte=1:Partes
            Dados=[];
            for p=1:pessoas
                load(strcat('C:\Users\Daniel\Documents\Documentos\Mestrado - Backup\SDUMLA\Bases Construidas\',Caracteristicas{car},'\Shearlet\RedDim\',TecRed{Tec},...
            '\',Caracteristicas{car},'_Shearlet_',TecRed{Tec},'.pessoa',int2str(p),'.mat'));
                if parte<Partes
                    Dados=[Dados;real(BaseDados.X(:,(parte-1)*QtdParte+1:parte*QtdParte))];
                else
                    Dados=[Dados;real(BaseDados.X(:,(parte-1)*QtdParte+1:end))];
                end
                clear BaseDados
            end
            XM=mean(Dados);
            Dados=Dados-repmat(XM,size(Dados,1),1);
            Xstd=std(Dados);
            Dados=Dados./repmat(Xstd,size(Dados,1),1);
            for p=1:pessoas
                if car==1
                    arq=strcat('C:\Users\Daniel\Documents\Documentos\Mestrado - Backup\SDUMLA\Bases Construidas\',Caracteristicas{car},'\Shearlet\RedDim\',TecRed{Tec},...
            '\',Caracteristicas{car},'_Shearlet_',TecRed{Tec},'.pessoa',int2str(p),'.mat')
                    load(arq);
                    if parte~=Partes
                        BaseDados.X(:,(parte-1)*QtdParte+1:parte*QtdParte)=real(Dados((p-1)*qtdFace+1:p*qtdFace,:));
                    else
                        BaseDados.X(:,(parte-1)*QtdParte+1:end)=real(Dados((p-1)*qtdFace+1:p*qtdFace,:));
                    end
                    save(arq,'BaseDados');
                else
                    arq=strcat('C:\Users\Daniel\Documents\Documentos\Mestrado - Backup\SDUMLA\Bases Construidas\',Caracteristicas{car},'\Shearlet\RedDim\',TecRed{Tec},...
            '\',Caracteristicas{car},'_Shearlet_',TecRed{Tec},'.pessoa',int2str(p),'.mat')
                    load(arq);
                    if parte~=Partes
                        BaseDados.X(:,(parte-1)*QtdParte+1:parte*QtdParte)=real(Dados((p-1)*qtdIris+1:p*qtdIris,:));
                    else
                        BaseDados.X(:,(parte-1)*QtdParte+1:end)=real(Dados((p-1)*qtdIris+1:p*qtdIris,:));
                    end
                    save(arq,'BaseDados');
                end
            end
        end
    end
end
