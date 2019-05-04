function holdout()
%nit_epocas = 2000;
conjunto = 165;
qtde_execucoes = 10;
x_70 = round(conjunto*0.7);

for fwavelet = 1:5,
    
    str_base_name = strcat('YALE/image_feature_', num2str(fwavelet), '.mat');
    
    entrada = load(str_base_name);
    saida = load('YALE/labels_binary.mat');
    saida = saida.saida.features_saida;
    entrada = normalizar(entrada.image_feature);
    
    neuronios = [200, 500, 1000, 2000, 4000]; %quantidade de neuronios
    
    for neuronio = 1: size(neuronios,2)
        
        rng(0);
        nfold = 10;
        fold = crossvalind('Kfold', convert(saida), nfold);
        
        for i = 1:nfold,
            
            %permutando várias vezes
            %rng(execucao);
            %perm = permut(conjunto);
            %entrada = entrada(perm, :);
            %saida = saida(perm, :);
            
            trn = i ~= fold;
            tst = ~trn;
               
            Xtr = entrada(trn, :);
            Ytr = saida(trn, :);
               
            Xtest = entrada(tst, :);
            Ytest = saida(tst, :);
            
            %Xtr = entrada(1:x_70, :);
            %Ytr = saida(1:x_70, :);
            
            %Xtest = entrada(x_70+1:end, :);
            %Ytest = saida(x_70+1:end, :);
            
            disp(fprintf('\nFold=%i Treinamento=%i Neuronios=%i\n', fwavelet, i, neuronios(neuronio)));
            
            %treinamento da mlp
            [W, Bi, acerto] = ELM(Xtr, Ytr, Xtest, Ytest, neuronios(neuronio));
            
            acerto
            
            %salvando pesos
            estruturaELM = struct('W', W, 'Bi', Bi, 'Xtest', Xtest, 'Ytest', Ytest);
            strPesos = strcat('pesosELM-Fold', num2str(fwavelet), '-Treinamento-', num2str(i), '-Neuronios-', num2str(neuronios(neuronio)));
            save(strPesos, 'estruturaELM');
            
            disp(fprintf('\n Fim Fold=%i Treinamento=%i Neuronios=%i\n', fwavelet, i, neuronios(neuronio)));
        end
    end
end
end