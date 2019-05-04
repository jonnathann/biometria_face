Abordagens={'MIN_MAX','MEAN_MAX','FACE_LL_IRIS','IRIS_LL_FACE','Concatenacao','EDGE','Soma','SomaPonderada'};
for a=1:length(Abordagens)
    for k=1:nfold
        DadosX=[];
        ClasseSaidaTeste=[];
        Saida=[];
        for CT=1:QtdPessoas
            %                 Elementos a serem testados
            ElementosCT=fold(k).teste{CT};
            %                 Matriz de dados da classe CT
            ArqCT=strcat('SDUMLA_Iris+Face_',Abordagens{a},'.Curvelet.pessoa',int2str(CT),'.mat');
            load(ArqCT);
            %                 Cria a estrutura data dos elementos de teste
            DadosX=[DadosX;BaseDados.X(ElementosCT,:)];
            %                     Cria a estrutura para armazenar a saida dos elementos
            %                     de teste
            ClasseSaidaVerdadeira=-ones(length(ElementosCT),QtdPessoas);
            ClasseSaidaVerdadeira(:,CT)=1;
            Saida=[Saida;ClasseSaidaVerdadeira];
        end
        DadosTeste.X=DadosX;
        DadosTeste.Y=Saida;
        saida=strcat('SDUMLA_Iris+Face_',Abordagens{a},'.Curvelet_Fold_',int2str(k),'.mat');
        save(saida,'DadosTeste');
    end
end