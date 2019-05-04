function k_fold_3(dataset, parameter_type_extractor, type)

    all_parameters = allcomb(1, 1:size(parameter_type_extractor, 2));
    
    %nome do arquivor
    for all_parameter = 1:size(all_parameters, 1)        
        variables_parameters = all_parameters(all_parameter, :);
        
        name_dataset = strcat(dataset{variables_parameters(1)}, '/image_feature_', num2str(variables_parameters(2)));
        label_dataset = strcat(dataset{variables_parameters(1)}, '/labels_multiclass');
        
        input = load(name_dataset);
        output = load(label_dataset);
        
        input = normalize(input.image_feature);
        output = output.features_saida;
        
        
        nfold = 10;  
        X = input;
        Y = output;
        rng(0);
        fold = crossvalind('Kfold', Y, nfold);
        
        
        accuracies = zeros(1, nfold);
        predicts_individual = [];
        predicts_fold = {};
        
        Yp = zeros(size(Y, 1), 1);
        
        for i = 1:nfold
           
            trn = i ~= fold;
            tst = ~trn;
               
            Xtr = X(trn, :);
            Ytr = Y(trn, :);
                          
            Xte = X(tst, :);
            Yte = Y(tst, :);
                        
            
            %qtd_class = size(unique(output), 1);
            %[accuracy, predict] = KNN(Xtr, Ytr, Xte, Yte, qtd_class, k);
            
            id = (1:numel(Y)) - 1;
            nclass = numel(accumarray(Y, 1));
            
            [accuracy, predict] = OPF(X, Y, nclass, id, Xtr, Ytr, Xte, Yte, trn, tst);
            
            %salvado indivíduos que foram reconhecidos ou não.
            Yp(tst, :) = predict(:, 1);
            
            %cálculo da acurácia
            accuracies(i) = accuracy;
            
            %preditos
            predicts_individual{i} = [Yp, Y];
            predicts_fold{i} = [predict, Yte];
            
            str = strcat('Fold:', num2str(i), '-', type, ':', parameter_type_extractor(variables_parameters(2)), '-Dataset:', dataset{variables_parameters(1)});
            disp(str);
            
        end
        file = strcat('RESULTS-', dataset{variables_parameters(1)});
        
        %verifica se já existe um diretório
        if ~exist(file, 'file')
            mkdir(file);
        end
        
        %salva resultados no diretório
        cd(file);
        
        structureOPF = struct('Dataset', dataset{variables_parameters(1)}, type, parameter_type_extractor{variables_parameters(2)}, 'mean_accuracy', mean(accuracies), 'std', std(accuracies), 'samples', accuracies, 'predicts_fold', predicts_fold, 'predicts_individual', predicts_individual, 'predicts_all', [Yp, Y], 'features_qtd', size(Xtr, 2));
        result = strcat('Result-OPF-', dataset{variables_parameters(1)}, '-', type, ':',parameter_type_extractor{variables_parameters(2)});        
        save(strcat(result,'.mat'), 'structureOPF');
        cd ..
    end
end

