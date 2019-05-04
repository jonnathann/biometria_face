Abordagens={'Concatenacao','EDGE','Soma','SomaPonderada'};
for a=1:length(Abordagens)
    for k=1:nfold
        DadosX=[];
        ClasseSaidaTeste=[];
        Saida=[];
        for CT=1:QtdPessoas
            %                 Elementos a serem testados
            ElementosCT=fold(k).teste{CT};
            %                 Matriz de dados da classe CT
            ArqCT=strcat('SDUMLA_Iris+Face_',Abordagens{a},'.Shearlet.pessoa',int2str(CT),'.mat');
            load(ArqCT);
            %                 Cria a estrutura data dos elementos de teste
            DadosX=[DadosX;BaseDados.X(ElementosCT,:)];
            %                     Cria a estrutura para armazenar a saida dos elementos
            %                     de teste
            ClasseSaidaTeste=[ClasseSaidaTeste;zeros(length(ElementosCT),QtdPessoas)];
            ClasseSaidaVerdadeira=-ones(length(ElementosCT),QtdPessoas);
            ClasseSaidaVerdadeira(:,CT)=1;
            Saida=[Saida;ClasseSaidaVerdadeira];
        end
        DadosTeste.X=DadosX;
        DadosTeste.Y=ClasseSaidaVerdadeira;
        DadosTeste.tsY=Saida;
        saida=strcat('SDUMLA_Iris+Face_',Abordagens{a},'.Shearlet_Fold_',int2str(k),'.mat');
    end
end