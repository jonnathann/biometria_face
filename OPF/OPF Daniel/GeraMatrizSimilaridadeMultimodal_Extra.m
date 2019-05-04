qtdClasses=106;
qtdFace=84;
qtdIris=10;
CurveletCar=[1024,7168,29696];
Transformadas={'Wavelet','Contourlet','Curvelet'};
Abordagens={'Concatenacao','Soma','Edge','MIN_MAX','MEAN_MAX','FACE_LL_IRIS','IRIS_LL_FACE'};
Wavelet={'DB2','DB4','SYM3','SYM4','SYM5'};

for T=3:3
    if T==1 || T==2
        for w=1:1
            for C=1:1
                for C1=1:qtdClasses
                    if T==1
                        ArqC1=strcat('SDUMLA_Iris+Face_',Abordagens{C},'.',Wavelet{w},'.pessoa',int2str(C1),'.mat');
                    elseif T==2
                        ArqC1=strcat('SDUMLA_Iris+Face.',Abordagens{C},'.Contourlet.',Wavelet{w},'.pessoa.',int2str(C1),'.mat');
                    end
                    load(ArqC1);
                    Dados{C1}.X=BaseDados.X;
                    clear BaseDados
                end
                for C1=1:qtdClasses
                    X=Dados{C1}.X;
                    for C2=C1:qtdClasses
                        Y=Dados{C2}.X;
                        D=dist(X,Y');
                        Max=max(D');
                        I=Max'*ones(1,qtdFace);
                        D=D./I;
                        D=1-D;
                        Dist{C1}{C2}=D;
                    end
                    C1
                end
                ArqSaida=strcat('C:\users\daniel\dropbox\BaseDados\Matriz_Semelhancas\Semelhanca_',...
                    Abordagens{C},'_',Transformadas{T},'_',Wavelet{w},'.mat');
                save(ArqSaida,'Dist');
                clear Dist
            end
        end
    else
        for w=3:3
            for A=4:4
                for C1=1:qtdClasses
                    ArqC1=strcat('SDUMLA_Iris+Face_',Abordagens{A},'.Curvelet.pessoa',int2str(C1),'.mat');
                    load(ArqC1);
                    if A==1
                        X=BaseDados.X(:,1:(CurveletCar(w)*2));
                    else
                        X=BaseDados.X(:,1:CurveletCar(w));
                    end
                    clear BaseDados
                    for C2=C1:qtdClasses
                        ArqC2=strcat('SDUMLA_Iris+Face_',Abordagens{A},'.Curvelet.pessoa',int2str(C2),'.mat');
                        load(ArqC2);
                        if A==1
                            Y=BaseDados.X(:,1:(CurveletCar(w)*2));
                        else
                            Y=BaseDados.X(:,1:CurveletCar(w));
                        end
                        if w==2
                            D=dist(X,Y');
                        else
                            D=zeros(qtdFace);
                            for I1=1:qtdFace
                                for I2=I1:qtdFace
                                    if I1==I2
                                        D(I1,I2)=dist(X(I1,:),Y(I2,:)');
                                    else
                                        D(I1,I2)=dist(X(I1,:),Y(I2,:)');
                                        D(I2,I1)=dist(X(I1,:),Y(I2,:)');
                                    end
                                end
                            end
                        end
                        Max=max(D');
                        I=Max'*ones(1,qtdFace);
                        D=D./I;
                        D=1-D;
                        Dist{C1}{C2}=D;  
                        C2
                    end                    
                end
                ArqSaida=strcat('C:\users\daniel\dropbox\BaseDados\Matriz_Semelhancas\Semelhanca_',...
                    Abordagens{A},'_',Transformadas{T},'_Nivel_',int2str(4-w),'.mat');
                save(ArqSaida,'Dist');
                clear Dist
            end
        end
    end
end