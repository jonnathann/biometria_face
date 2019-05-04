clear all
qtdclasses=106;
qtdDC=84;
qtdTotal=qtdDC*qtdclasses;
Distancias=zeros(qtdTotal);
Transformada='Curvelet';
Abordagem='Soma';
TDistancias={'Euclidiana','Manhattan','SquareChi-Squared'};
Nivel=1;
Caracteristicas=1024;
% Laço de controle do tipo de distância
for TDist=1:1
    ArqDist=strcat('Teste_FaceIris_',Abordagem,'_Curvelet_Nivel',int2str(4-Nivel),'_',TDistancias{TDist},'.dat');
    fid=fopen(ArqDist,'wb')
    maxDist=0;
    %     Laço da classe C1
    for C1=1:qtdclasses
        % Laço de classe C2
        ArqC1=strcat('SDUMLA_Iris+Face_',Abordagem,'.',Transformada,'.pessoa',int2str(C1),'.mat');
        load(ArqC1);
        DadosC1=num2str(BaseDados.X(:,1:Caracteristicas),'%.6f');
        for p=1:qtdDC
            for c=1:Caracteristicas
                if C1==10 && c~=1
                    T(p,c)=str2double(DadosC1(p,(c-1)*10:c*10-1));
                else
                    T(p,c)=str2double(DadosC1(p,(c-1)*9+1:c*9));
                end
            end
        end
        clear DadosC1;
        DadosC1=T;
        clear BaseDados T
        for C2=C1:qtdclasses
            sprintf('%i %i',C1,C2)
            ArqC2=strcat('SDUMLA_Iris+Face_',Abordagem,'.',Transformada,'.pessoa',int2str(C2),'.mat');
            load(ArqC2);
            DadosC2=num2str(BaseDados.X(:,1:Caracteristicas),'%.6f');
            for p=1:qtdDC
                for c=1:Caracteristicas
                    if C2==10 && c~=1
                        T(p,c)=str2double(DadosC2(p,(c-1)*10:c*10-1));
                    else
                        T(p,c)=str2double(DadosC2(p,(c-1)*9+1:c*9));
                    end
                end
            end
            clear DadosC2;
            DadosC2=T;
            clear BaseDados T
            %                 QtdDados Classe C1
            for I1=1:qtdDC
                if TDist==1
                    AtC1=repmat(DadosC1(I1,:),qtdDC,1);
                    DAtual=AtC1-DadosC2;
                    DAtual=DAtual.^2;
                    DAtual=sum(DAtual,2);
                    Distancias((C1-1)*qtdDC+I1,(C2-1)*qtdDC+1:C2*qtdDC) = DAtual;
                    Distancias((C2-1)*qtdDC+1:C2*qtdDC,(C1-1)*qtdDC+I1) = DAtual;
                    if(max(DAtual)>maxDist)
                        maxDist=max(DAtual);
                    end
                elseif TDist==2
                    AtC1=repmat(DadosC1(I1,:),qtdDC,1);
                    DAtual=abs(AtC1-DadosC2);
                    DAtual=sum(DAtual,2);
                    Distancias((C1-1)*qtdDC+I1,(C2-1)*qtdDC+1:C2*qtdDC) = DAtual;
                    Distancias((C2-1)*qtdDC+1:C2*qtdDC,(C1-1)*qtdDC+I1) = DAtual;
                    if(max(DAtual)>maxDist)
                        maxDist=max(DAtual);
                    end
                else
                    aux=repmat(DadosC1(I1,:),qtdDC,1);
                    auxDiv=abs(aux+DadosC2);
                    DAtual=(aux-DadosC2).^2;
                    DAtual=DAtual./auxDiv;
                    DAtual=sum(DAtual,2);
                    Distancias((C1-1)*qtdDC+I1,(C2-1)*qtdDC+1:C2*qtdDC) = DAtual;
                    Distancias((C2-1)*qtdDC+1:C2*qtdDC,(C1-1)*qtdDC+I1) = DAtual;
                    if(max(DAtual)>maxDist)
                        maxDist=max(DAtual);
                    end
                end
            end
        end
        C1
    end
    Distancias=Distancias/maxDist;
    fwrite(fid,qtdTotal,'int');
    for i=1:qtdTotal
        for j=1:qtdTotal
            fwrite(fid,Distancias(i,j),'float')
        end
        i
    end
    fclose(fid)
end