% clear all
% clc
pessoas=106;
Wavelets={'DB2','DB4','SYM3','SYM4','SYM5'};
Combinacoes={'MIN_MAX','MEAN_MAX','FACE_LL_IRIS','IRIS_LL_FACE','Concatenacao','Edge','Soma','SomaPonderada'};
qtdFace=84;
for car=1:length(Combinacoes)
    for w=1:length(Wavelets)
%         if car==1 && w==1
%             w=2;
%         end
        Dados=[];
        for p=1:pessoas
            load(strcat('D:\Bases De Dados\Shumla\Bases Construidas\FaceIris\',Combinacoes{car},'\Wavelet\',Wavelets{w},...
                '\SDUMLA_Iris+Face_',Combinacoes{car},'.',Wavelets{w},'.pessoa',int2str(p),'.mat'));
            Dados=[Dados;BaseDados.X];
        end
        XM=mean(Dados);
        Dados=Dados-repmat(XM,size(Dados,1),1);
        Xstd=std(Dados);
        Dados=Dados./repmat(Xstd,size(Dados,1),1);
        for p=1:pessoas
            arq=strcat('D:\Bases De Dados\Shumla\Bases Construidas\FaceIris\',Combinacoes{car},'\Wavelet\',Wavelets{w},...
                '\SDUMLA_Iris+Face_',Combinacoes{car},'.',Wavelets{w},'.pessoa',int2str(p),'.mat');
            load(arq);
            BaseDados.X=Dados((p-1)*qtdFace+1:p*qtdFace,:);
            save(arq,'BaseDados');
        end
    end
end