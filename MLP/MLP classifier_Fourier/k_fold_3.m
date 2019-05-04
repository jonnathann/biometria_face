function k_fold_3(dataset, parameter_type_extractor, neurons, type)

    all_parameters = allcomb(1, 1:size(parameter_type_extractor, 2), 1:size(neurons, 2));
    for all_parameter = 1:size(all_parameters, 1)        
        variables_parameters = all_parameters(all_parameter, :);
        
        name_dataset = strcat(dataset{variables_parameters(1)}, '/image_feature_', num2str(variables_parameters(2)));
        label_dataset = strcat(dataset{variables_parameters(1)}, '/labels_binary');
        
        input = load(name_dataset);
        output = load(label_dataset);
        
        input = normalizar(input.image_feature);
        output = output.features_saida;
        
        nfold = 10;  
        X = input;
        Y = output;
        rng(0);
        fold = crossvalind('Kfold', convert(Y), nfold);
        
        accuracies = zeros(1, nfold);
        predicts_fold = {};
        predicts_individual = {};
        
        Yp = zeros(size(Y, 1), 1);
        
        for i = 1:nfold
            
            
            trn = i ~= fold;
            tst = ~trn;
               
            Xtr = X(trn, :);
            Ytr = Y(trn, :);
               
            Xte = X(tst, :);
            Yte = Y(tst, :);
            
            epochs = 2000;
                    
            [accuracy, predict] = MLP(Xtr, Ytr, Xte, Yte, neurons(variables_parameters(3)), epochs);  
            accuracies(i) = accuracy;
            
            %salvado indivíduos que foram reconhecidos ou não.
            convert_predict = convert(predict);
            convert_Y = convert(Y);
            convert_Yte = convert(Yte);
            
            Yp(tst, :) = convert_predict(:, 1);
            
            predicts_fold{i} = [convert_predict, convert_Yte];
            predicts_individual = [Yp, convert_Y];
            
            str = strcat('Fold:', num2str(i), '-', type,':', parameter_type_extractor(variables_parameters(2)), '-Neurons:', num2str(neurons(variables_parameters(3))), '-Dataset:', dataset{variables_parameters(1)});
            disp(str);  
        end
        file = strcat('RESULTS-',dataset{variables_parameters(1)});
        
        %verifica se já existe um diretório
        if ~exist(file, 'file')
            mkdir(file);
        end
        
        %salva resultados no diretório
        cd(file);
        structureMLP = struct('Dataset', dataset{variables_parameters(1)}, type, parameter_type_extractor{variables_parameters(2)}, 'neurons', num2str(neurons(variables_parameters(3))),'mean_accuracy', mean(accuracies), 'std', std(accuracies), 'samples', accuracies, 'predicts_fold', predicts_fold, 'predicts_individual', predicts_individual, 'predicts_all', [Yp, convert_Y], 'features_qtd', size(Xtr, 2));
        result = strcat('Result-MLP-', dataset{variables_parameters(1)}, '-',type, ':', parameter_type_extractor{variables_parameters(2)},'-Neurons:', num2str(neurons(variables_parameters(3)))); 
        save(strcat(result,'.mat'), 'structureMLP');
        cd ..
    end
end

