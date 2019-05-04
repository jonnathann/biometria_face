Abordagens={'MIN_MAX','MEAN_MAX','FACE_LL_IRIS','IRIS_LL_FACE','Concatenacao','EDGE','Soma','SomaPonderada'};
Wavelets={'DB2','DB4','SYM3','SYM4','SYM5'};
for w=1:length(Wavelets)
    for a=1:length(Abordagens)
        for k=1:nfold
            DadosX=[];
            Saida=[];
            for CT=1:QtdPessoas
                %                 Elementos a serem testados
                ElementosCT=fold(k).teste{CT};
                %                 Matriz de dados da classe CT
                ArqCT=strcat('SDUMLA_Iris+Face_',Abordagens{a},'.',Wavelets{w},'.pessoa',int2str(CT),'.mat');
                load(ArqCT);
                %                 Cria a estrutura data dos elementos de teste
                DadosX=[DadosX;BaseDados.X(ElementosCT,:)];
                %                     Cria a estrutura para armazenar a saida dos elementos
                %                     de teste
                ClasseSaidaVerdadeira=-ones(length(ElementosCT),QtdPessoas);
                ClasseSaidaVerdadeira(:,CT)=1;
                Saida=[Saida;ClasseSaidaVerdadeira];
            end
            DadosTeste(k).X=DadosX;
            DadosTeste(k).Y=Saida;
        end        
        saida=strcat('SDUMLA_Iris+Face_',Abordagens{a},'.',Wavelets{w},'_FoldsTeste.mat');
        save(saida,'DadosTeste');
    end
end