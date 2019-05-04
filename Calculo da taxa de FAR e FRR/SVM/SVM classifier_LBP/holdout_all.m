function holdout_all()

fwavelets = {'db2', 'db4', 'sym3', 'sym4', 'sym5'};
datasets = {'YALE'};

for dataset = 1:size(datasets, 2),
    for fwavelet = 1:size(fwavelets, 2),
        
        name_dataset = strcat(datasets{dataset}, '/image_feature_', num2str(fwavelet));
        label_dataset = strcat(datasets{dataset}, '/labels_multiclass');
        
        input = load(name_dataset);
        output = load(label_dataset);
        
        input = normalize(input.image_feature);
        output = output.saida.features_saida;
        
        gamma = [2e-3, 2e-6, 2e-9, 2e-12, 2e-14];
       
        for gamm = 1:size(gamma, 2),
            
            accuracies = [];
            
            for execution = 1:1,
               rng(0);%Plantando a semente
               permut = randperm(size(input, 1));
               input = input(permut, :);
               output = output(permut, :);
               
               t_70 = round(size(input, 1) * 0.7);
               
               %Training 70%
               Xtr = input(1:t_70, :);
               Ytr = output(1:t_70, :);
               
               %Test 30%
               Xte = input(t_70 + 1:end, :);
               Yte = output(t_70 + 1:end, :);
               
               disp(strcat('Fwavelet_name: ', fwavelets{fwavelet}));
               fprintf('\nFwavelet=%i Training=%i Gamma=%i\n\n', fwavelet, execution, gamma(gamm));
               kernel = strcat('-s 0 -t 2 -c 1000', {' '},'-g', {' '}, num2str(gamma(gamm)));
               kernel = char(kernel);
               accuracy = svm_multiclass(Ytr, Xtr, Yte, Xte, kernel);
               accuracies(execution) = accuracy;
            end
            structureSVM = struct('Dataset', datasets{dataset}, 'Fwavelet', fwavelets{fwavelet}, 'Gamma', num2str(gamma(gamm)),'mean_accuracy', mean(accuracies), 'std', std(accuracies), 'samples', accuracies);
            result = strcat('Result-SVM-Fwavelet-', fwavelets{fwavelet},'-gamma-', num2str(gamma(gamm)), datasets{dataset}); 
            save(strcat(result,'.mat'), 'structureSVM'); 
            plot(mean(accuracies));
            pause();
        end        
    end
end    
end


