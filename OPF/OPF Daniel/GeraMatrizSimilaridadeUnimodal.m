qtdClasses=106;
qtdFace=84;
qtdIris=10;
% Face_Wavelet_DB2.pessoa81
% Face_Contourlet_DB2_PKVA.pessoa104
% Face_Curvelet.pessoa1
% Iris_Wavelet_DB2.pessoa1
% Iris_Curvelet.pessoa1
% Iris_Contourlet_DB2_PKVA.pessoa1
CurveletCar=[1024,7168,29696];

Transformadas={'Wavelet','Contourlet','Curvelet'};
Caracteristicas={'Iris','Face'};
Wavelet={'DB2','DB4','SYM3','SYM4','SYM5'};
for T=2:2
    if T==1 || T==2
        for w=1:length(Wavelet)
            for C=1:length(Caracteristicas)
                for C1=1:qtdClasses
%                     Carrego a matriz de dados por classe
                    if T==1
                        ArqC1=strcat(Caracteristicas{C},'_Wavelet_',Wavelet{w},'.pessoa',int2str(C1),'.mat');
                    elseif T==2
                        ArqC1=strcat(Caracteristicas{C},'_Contourlet_',Wavelet{w},'_PKVA.pessoa',int2str(C1),'.mat');
                    end
                    load(ArqC1);
                    Dados{C1}.X=BaseDados.X;
                    clear BaseDados
                end
                for C1=1:qtdClasses
%                     Seleciono os dados de C1
                    X=Dados{C1}.X;
                    for C2=C1:qtdClasses
%                         Seleciono os dados de C2
                        Y=Dados{C2}.X;
%                         Cálculo da Matriz de Distâncias entre C1 e C2
                        D=dist(X,Y');
%                           Seleciono o dado menos semelhante com cada dado
                        Max=max(D');
%                       Gero uma matriz para fazer a normalização
                        if(C==1)
                            I=Max'*ones(1,qtdIris);
                        else
                            I=Max'*ones(1,qtdFace);
                        end
%                         Normalizo a semelhança dividindo os dados pela
%                         maior distância em relação à cada dado
                        D=D./I;
%                         Calculo a semelhança
                        D=1-D;
%                         Armazeno a matriz de semelhança de C1 e C2
                        Dist{C1}{C2}=D;
                    end
                    C1
                end
                ArqSaida=strcat('C:\users\daniel\dropbox\BaseDados\Matriz_Semelhancas\Semelhanca_',...
                    Caracteristicas{C},'_',Transformadas{T},'_',Wavelet{w},'.mat');
                save(ArqSaida,'Dist');
                clear Dist
            end
        end
    else
        for w=3:length(CurveletCar)
            for C=2:length(Caracteristicas)
                for C1=1:qtdClasses
                    ArqC1=strcat(Caracteristicas{C},'_Curvelet.pessoa',int2str(C1),'.mat');
                    load(ArqC1);
                    X=BaseDados.X(:,1:CurveletCar(w));
                    clear BaseDados
                    for C2=C1:qtdClasses
                        ArqC2=strcat(Caracteristicas{C},'_Curvelet.pessoa',int2str(C2),'.mat');
                        load(ArqC2);
                        Y=BaseDados.X(:,1:CurveletCar(w));
                        D=dist(X,Y');
                        Max=max(D');
                        if(C==1)
                            I=Max'*ones(1,qtdIris);
                        else
                            I=Max'*ones(1,qtdFace);
                        end
                        D=D./I;
                        D=1-D;
                        Dist{C1}{C2}=D;
                        C2
                    end                    
                end
                ArqSaida=strcat('C:\users\daniel\dropbox\Daniel\Face\Bases\ShumlaDatabase\Matriz_Semelhancas\Semelhanca_',...
                    Caracteristicas{C},'_',Transformadas{T},'_Nivel_',int2str(w),'.mat');
                save(ArqSaida,'Dist');
                clear Dist
            end
        end
    end
end