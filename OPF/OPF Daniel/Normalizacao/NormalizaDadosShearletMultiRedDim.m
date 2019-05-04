clear all
clc
pessoas=106;
Niveis=1:3;
Combinacoes={'Concatenacao','Edge','Soma','SomaPonderada'};
TecRed={'2DPCA','2DLDA','BDPCA'};
qtdFace=84;
QtdParte=6000;
for Tec=1:length(TecRed)
    if Tec==1
        iniCar=3;
    else
        iniCar=1;
    end
    for car=iniCar:length(Combinacoes)
        entrada=strcat('D:\Bases De Dados\Shumla\Bases Construidas\FaceIris\',Combinacoes{car},'\Shearlet\RedDim\',TecRed{Tec},...
            '\SDUMLA_Iris+Face_',Combinacoes{car},'_Shearlet_pessoa1_',TecRed{Tec},'.mat');
        load(entrada);
        QtdCar=size(BaseDados.X,2);
        Partes=ceil(QtdCar/QtdParte);
        clear BaseDados
        for parte=1:Partes
            disp(sprintf('Parte %i de %i',parte,Partes))
            Dados=[];
            for p=1:pessoas
                load(strcat('D:\Bases De Dados\Shumla\Bases Construidas\FaceIris\',Combinacoes{car},'\Shearlet\RedDim\',TecRed{Tec},...
                    '\SDUMLA_Iris+Face_',Combinacoes{car},'_Shearlet_pessoa',int2str(p),'_',TecRed{Tec},'.mat'));
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
                arq=strcat('D:\Bases De Dados\Shumla\Bases Construidas\FaceIris\',Combinacoes{car},'\Shearlet\RedDim\',TecRed{Tec},...
                    '\SDUMLA_Iris+Face_',Combinacoes{car},'_Shearlet_pessoa',int2str(p),'_',TecRed{Tec},'.mat')
                load(arq);
                if parte<Partes
                    BaseDados.X(:,(parte-1)*QtdParte+1:parte*QtdParte)=real(Dados((p-1)*qtdFace+1:p*qtdFace,:));
                else
                    BaseDados.X(:,(parte-1)*QtdParte+1:end)=real(Dados((p-1)*qtdFace+1:p*qtdFace,:));
                end
                save(arq,'BaseDados');
            end
        end        
    end
end