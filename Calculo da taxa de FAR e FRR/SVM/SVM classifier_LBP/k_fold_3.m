function k_fold_3(dataset, parameter_type_extractor, gamma, type)

    all_parameters = allcomb(1, 1:size(parameter_type_extractor, 2), 1:size(gamma, 2));
    
    %nome do arquivor
    for all_parameter = 1:size(all_parameters, 1)        
        variables_parameters = all_parameters(all_parameter, :);
        
        name_dataset = strcat(dataset{variables_parameters(1)}, '/image_feature_', num2str(variables_parameters(2)));
        label_dataset = strcat(dataset{variables_parameters(1)}, '/labels_multiclass');
        
        input = load(name_dataset);
        output = load(label_dataset);
        
        input = normalizar(input.image_feature);
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
                        
            
            kernel = strcat('-s 0 -t 2 -c 1000', {' '},'-g', {' '}, num2str(gamma(variables_parameters(3))));
            kernel = char(kernel);
            [accuracy, predict_classe, predict_prob] = svm_multiclass(Ytr, Xtr, Yte, Xte, kernel);
            accuracies(i) = accuracy;
            
            %salvado indivíduos que foram reconhecidos ou não.
            Yp(tst, :) = predict_classe(:, 1);
            
            %cálculo da acurácia
            accuracies(i) = accuracy;
            
            %preditos
            predicts_individual{i} = [Yp, Y];
            predicts_fold{i} = [predict_prob, predict_classe, Yte];
            
            str = strcat('Fold:', num2str(i), '-', type,':', parameter_type_extractor(variables_parameters(2)), '-gamma:', num2str(gamma(variables_parameters(3))), '-Dataset:', dataset{variables_parameters(1)});
            disp(str);
            
        end
        file = strcat('RESULTS-',dataset{variables_parameters(1)});
        
        %verifica se já existe um diretório
        if ~exist(file, 'file')
            mkdir(file);
        end
        
        %salva resultados no diretório
        cd(file);
        
        structureSVM = struct('Dataset', dataset{variables_parameters(1)}, type, parameter_type_extractor{variables_parameters(2)}, 'gamma', num2str(gamma(variables_parameters(3))),'mean_accuracy', mean(accuracies), 'std', std(accuracies), 'samples', accuracies, 'predicts_fold', predicts_fold, 'predicts_indivudual', predicts_individual, 'predicts_all', [Yp, Y],'features_qtd', size(Xtr, 2));
        result = strcat('Result-SVM-', dataset{variables_parameters(1)}, '-',type, ':', parameter_type_extractor{variables_parameters(2)},'-gamma:', num2str(gamma(variables_parameters(3)))); 
        save(strcat(result,'.mat'), 'structureSVM');
        cd ..
    end
end

