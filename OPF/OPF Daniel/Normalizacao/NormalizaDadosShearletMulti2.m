clear all
clc
pessoas=106;
Niveis=1:3;
Combinacoes={'Edge','Soma','SomaPonderada'};
qtdFace=84;
for car=1:length(Combinacoes)
    for nivel=2:length(Niveis)
        for p=1:pessoas
            arq=strcat('D:\Bases De Dados\Shumla\Bases Construidas\FaceIris\',Combinacoes{car},'\Shearlet\Nivel1',...
                '\SDUMLA_Iris+Face_',Combinacoes{car},'.Shearlet.Nível1.pessoa',int2str(p),'.mat');
            load(arq);
            BTotal=BaseDados;
            arq=strcat('D:\Bases De Dados\Shumla\Bases Construidas\FaceIris\',Combinacoes{car},'\Shearlet\Nivel',int2str(nivel),...
                '\SDUMLA_Iris+Face_',Combinacoes{car},'.Shearlet.Nível',int2str(nivel),'.pessoa',int2str(p),'.mat');
            load(arq);
            TotalCar=size(BaseDados.X,2);
            BaseDados.X=BTotal.X(:,1:TotalCar);
            BaseDados.Y=BTotal.Y;
            TotalNovo=size(BaseDados.X,2);
            save(arq,'BaseDados');
            clear BaseDados
        end        
    end
end
