function k_fold()

    fwavelets = {'db2', 'db4', 'sym3', 'sym4', 'sym5'};
    datasets = {'YALE_128x128'};
    all_parameters = allcomb(1, [1, 2, 3, 4, 5], [1, 2, 3, 4, 5]);
    
    for all_parameter = 1:size(all_parameters, 1)        
        variables_parameters = all_parameters(all_parameter, :);
        
        name_dataset = strcat(datasets{variables_parameters(1)}, '/image_feature_', num2str(variables_parameters(2)));
        label_dataset = strcat(datasets{variables_parameters(1)}, '/labels_multiclass');
        
        input = load(name_dataset);
        output = load(label_dataset);
        
        input = normalize(input.image_feature);
        output = output.saida.features_saida;
        
        K = [1, 3, 5, 8, 10];
        
        nfold = 10;  
        X = input;
        Y = output;
        fold = crossvalind('Kfold', Y, nfold);
        
        accuracies = zeros(1, nfold);
        
        for i = 1:nfold
            
            rng(0);
            trn = i ~= fold;
            tst = ~trn;
               
            Xtr = X(trn, :);
            Ytr = Y(trn, :);
               
            Xte = X(tst, :);
            Yte = Y(tst, :);
            qtd_class = size(unique(output), 1);
            [accuracy, ~] = KNN(Xtr, Ytr, Xte, Yte, qtd_class, K);
            accuracies(i) = accuracy;
            
            str = strcat('Fold=', num2str(i), '-Waveltet=', fwavelets{variables_parameters(2)}, '-K-Neighbors=', num2str(K(variables_parameters(3))), '-Dataset=', datasets{variables_parameters(1)});
            disp(str);
            
        end
        structureKNN = struct('Dataset', datasets{variables_parameters(1)}, 'Fwavelet', fwavelets{variables_parameters(2)}, 'K_Neighbors', num2str(K(variables_parameters(3))),'mean_accuracy', mean(accuracies), 'std', std(accuracies), 'samples', accuracies);
        result = strcat('Result-KNN-Fwavelet-', fwavelets{variables_parameters(2)},'-K-Neighbors-', num2str(K(variables_parameters(3))),'-',datasets{variables_parameters(1)}); 
        save(strcat(result,'.mat'), 'structureKNN');
    end
  
end