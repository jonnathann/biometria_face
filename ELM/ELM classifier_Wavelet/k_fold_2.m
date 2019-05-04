function k_fold_2()

    margins = [2525];
    datasets = {'SDUMLA-LBP-Features'};
    all_parameters = allcomb(1, 1, [1, 2, 3, 4, 5]);
    
    for all_parameter = 1:size(all_parameters, 1)        
        variables_parameters = all_parameters(all_parameter, :);
        
        name_dataset = strcat(datasets{variables_parameters(1)}, '/image_feature_', num2str(variables_parameters(2)));
        label_dataset = strcat(datasets{variables_parameters(1)}, '/labels_binary.txt');
        
        input = load(name_dataset);
        output = load(label_dataset);
        
        input = normalize(input.image_feature);
        %output = output.saida.features_saida;
        
        neurons = [200, 500, 1000, 2000, 4000];
        
        nfold = 10;  
        X = input;
        Y = output;
        fold = crossvalind('Kfold', convert(Y), nfold);
        
        accuracies = zeros(1, nfold);
        
        for i = 1:nfold
            
            rng(0);
            trn = i ~= fold;
            tst = ~trn;
               
            Xtr = X(trn, :);
            Ytr = Y(trn, :);
               
            Xte = X(tst, :);
            Yte = Y(tst, :);
                    
            [accuracy, ~] = ELM(Xtr, Ytr, Xte, Yte, neurons(variables_parameters(3)));  
            accuracies(i) = accuracy;
            
            str = strcat('Fold=', num2str(i), '-Margins=', num2str(margins(variables_parameters(2))), '-Neurons=', num2str(neurons(variables_parameters(3))), '-Dataset=', datasets{variables_parameters(1)});
            disp(str);  
        end
        structureELM = struct('Dataset', datasets{variables_parameters(1)}, 'Margins', margins(variables_parameters(2)), 'Neurons', num2str(neurons(variables_parameters(3))),'mean_accuracy', mean(accuracies), 'std', std(accuracies), 'samples', accuracies);
        result = strcat('Result-ELM-Fourier-Margins-', num2str(margins(variables_parameters(2))),'-Neurons-', num2str(neurons(variables_parameters(3))), datasets{variables_parameters(1)}); 
        save(strcat(result,'.mat'), 'structureELM');
    end
  
end