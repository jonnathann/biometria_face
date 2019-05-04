function  k_fold_allcomb()

fwavelets = {'55'};
datasets = {'AR_Viola_Jones-FOURIER-TRANSFORM'};

all_parameters = allcomb(1, [1], [1, 2, 3]);

for all_parameter = 1:size(all_parameters, 1)        
    variables_parameters = all_parameters(all_parameter, :);
    
    
    name_dataset = strcat(datasets{variables_parameters(1)}, '/image_feature_', num2str(5));
    label_dataset = strcat(datasets{variables_parameters(1)}, '/labels_multiclass');
        
    input = load(name_dataset);
    output = load(label_dataset);
        
    input = normalize(input.image_feature);
    output = output.features_saida;
    %gamma = [2e-1, 2e-2, 2e-3, 2e-4, 2e-5, 2e-6, 2e-7,2e-8,2e-9,2e-10,2e-12,2e-13,2e-14,2e-15,2e-16,2e-17];
    %gamma = [2e-1/10, 2e-2/10, 2e-3/10, 2e-4/10, 2e-5/10, 2e-6/10, 2e-7/10, 2e-8/10, 2e-9/10]; 
    gamma = [2e-6, 2e-7, 2e-8];
   
    accuracies = [];
    rng(0);
    nfold = 10;  
    X = input;
    Y = output;
    fold = crossvalind('Kfold', Y, nfold);
            
    for i = 1:nfold
        trn = i ~= fold;
        tst = ~trn;
               
        Xtr = X(trn,:);
        Ytr = Y(trn,:);
               
        Xte = X(tst,:);
        Yte = Y(tst,:);
               
        kernel = strcat('-s 0 -t 2 -c 1000', {' '},'-g', {' '}, num2str(gamma(variables_parameters(3))));
        kernel = char(kernel);
        accuracy = svm_multiclass(Ytr, Xtr, Yte, Xte, kernel);
        accuracies(i) = accuracy;
        
        str = strcat('Fold=', num2str(i), '-Waveltet=', fwavelets{variables_parameters(2)}, '-Dataset=', datasets{variables_parameters(1)});
        disp(str);
               
    end
    structureSVM = struct('Dataset', datasets{variables_parameters(1)}, 'Fwavelet', fwavelets{variables_parameters(2)}, 'Gamma', num2str(gamma(variables_parameters(3))),'mean_accuracy', mean(accuracies), 'std', std(accuracies), 'samples', accuracies);
    result = strcat('Result-SVM-Fwavelet-', fwavelets{variables_parameters(2)},'-gamma-', num2str(gamma(variables_parameters(3))), datasets{variables_parameters(1)}); 
    save(strcat(result,'.mat'), 'structureSVM');
end
end