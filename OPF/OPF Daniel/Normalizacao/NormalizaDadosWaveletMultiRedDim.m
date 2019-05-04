% clear all
% clc
pessoas=106;
Wavelets={'DB2','DB4','SYM3','SYM4','SYM5'};
Combinacoes={'Concatenacao','Edge','Soma','SomaPonderada'};
TecRed={'2DPCA','BDPCA','2DLDA'};
qtdFace=84;
for Tec=1:length(TecRed)
    for car=1:1
        for w=1:length(Wavelets)
            Dados=[];
            for p=1:pessoas
                load(strcat('D:\Bases De Dados\Shumla\Bases Construidas\FaceIris\',Combinacoes{car},'\Wavelet\RedDim\',TecRed{Tec},'\',Wavelets{w},...
                    '\SDUMLA_Iris+Face_',Combinacoes{car},'.',Wavelets{w},'.pessoa',int2str(p),'_',TecRed{Tec},'.mat'));
                Dados=[Dados;BaseDados.X];
            end
            XM=mean(Dados);
            Dados=Dados-repmat(XM,size(Dados,1),1);
            Xstd=std(Dados);
            Dados=Dados./repmat(Xstd,size(Dados,1),1);
            for p=1:pessoas
                arq=strcat('D:\Bases De Dados\Shumla\Bases Construidas\FaceIris\',Combinacoes{car},'\Wavelet\RedDim\',TecRed{Tec},'\',Wavelets{w},...
                    '\SDUMLA_Iris+Face_',Combinacoes{car},'.',Wavelets{w},'.pessoa',int2str(p),'_',TecRed{Tec},'.mat')
                load(arq);
                BaseDados.X=Dados((p-1)*qtdFace+1:p*qtdFace,:);
                save(arq,'BaseDados');
            end
        end
    end
end