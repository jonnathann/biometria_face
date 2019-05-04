function  k_fold()

fwavelets = {'db2', 'db4', 'sym3', 'sym4', 'sym5'};
datasets = {'YALE'};

for dataset = 1:size(datasets, 2)
    
    for fwavelet = 1:size(fwavelets, 2)
        
        name_dataset = strcat(datasets{dataset}, '/image_feature_', num2str(fwavelet));
        label_dataset = strcat(datasets{dataset}, '/labels_multiclass');
        
        input = load(name_dataset);
        output = load(label_dataset);
        
        input = normalize(input.image_feature);
        output = output.saida.features_saida;
        
        %gamma = [2e-1, 2e-2, 2e-3, 2e-4, 2e-5, 2e-6, 2e-7,2e-8,2e-9,2e-10,2e-12,2e-13,2e-14,2e-15,2e-16,2e-17];
        %gamma = [2e-1/10, 2e-2/10, 2e-3/10, 2e-4/10, 2e-5/10, 2e-6/10, 2e-7/10, 2e-8/10, 2e-9/10]; 
        %gamma = [2e0, 2e-1, 2e-2, 2e-3, 2e-4, 2e-5, 2e-6, 2e-7, 2e-8, 2e-9, 2e-10, 2e-11, 2e-12, 2e-13, 2e-14, 2e-15, 2e-16, 2e-17, 2e-18, 2e-19, 2e-20];
        gamma = [2e-5, 2e-6, 2e-7, 2e-8, 2e-9, 2e-10];

        result_gamma = zeros(1, size(gamma, 2));
        for gamm = 1:size(gamma, 2)
        
            
            accuracies = [];
            errors = [];
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
               
               kernel = strcat('-s 0 -t 2 -c 1000', {' '},'-g', {' '}, num2str(gamma(gamm)));
               kernel = char(kernel);
               accuracy = svm_multiclass(Ytr, Xtr, Yte, Xte, kernel);
               accuracies(i) = accuracy;
               errors(i) = 100 - accuracy;
               
            end
            structureSVM = struct('Dataset', datasets{dataset}, 'Fwavelet', fwavelets{fwavelet}, 'Gamma', num2str(gamma(gamm)),'mean_accuracy', mean(accuracies), 'std', std(accuracies), 'Erro', mean(errors),'samples', accuracies);
            result = strcat('Result-SVM-Fwavelet-', fwavelets{fwavelet},'-gamma-', num2str(gamma(gamm)), datasets{dataset}); 
            save(strcat(result,'.mat'), 'structureSVM');
            result_gamma(gamm) = mean(errors);
        end
        subplot(4, 3, fwavelet);
        plot(result_gamma);
        title(fwavelets{fwavelet});
        fprintf('\nFinish: %i', fwavelet);
        pause(5);
    end
end    
end