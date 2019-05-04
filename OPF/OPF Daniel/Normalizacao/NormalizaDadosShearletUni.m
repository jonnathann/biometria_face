clear all
clc
pessoas=106;
Niveis=1:3;
Caracteristicas={'Face','Iris'};
qtdFace=84;
qtdIris=10;
QtdParte=8000;
for car=1:length(Caracteristicas)
    arq=strcat('D:\Bases De Dados\Shumla\Bases Construidas\',Caracteristicas{car},'\Shearlet',...
        '\',Caracteristicas{car},'_Shearlet.pessoa1.mat')
    load(arq);
    QtdCar=size(BaseDados.X,2);
    Partes=ceil(QtdCar/QtdParte);
    clear BaseDados
    for parte=1:Partes
        Dados=[];
        for p=1:pessoas
            load(strcat('D:\Bases De Dados\Shumla\Bases Construidas\',...
                Caracteristicas{car},'\Shearlet',...
                '\',Caracteristicas{car},'_Shearlet.pessoa',int2str(p),'.mat'));
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
                arq=strcat('D:\Bases De Dados\Shumla\Bases Construidas\',...
                Caracteristicas{car},'\Shearlet',...
                '\',Caracteristicas{car},'_Shearlet.pessoa',int2str(p),'.mat');
                load(arq);
                if parte~=Partes
                    BaseDados.X(:,(parte-1)*QtdParte+1:parte*QtdParte)=real(Dados((p-1)*qtdFace+1:p*qtdFace,:));
                else
                    BaseDados.X(:,(parte-1)*QtdParte+1:end)=real(Dados((p-1)*qtdFace+1:p*qtdFace,:));
                end
                save(arq,'BaseDados');
            else
                arq=strcat('D:\Bases De Dados\Shumla\Bases Construidas\',...
                Caracteristicas{car},'\Shearlet',...
                '\',Caracteristicas{car},'_Shearlet.pessoa',int2str(p),'.mat');
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
