function kfold(datasets, parameters, neurons)

    for dts = 1:size(datasets, 2)
        
       dataset_name = datasets{dts}{1};
       parameter_name = datasets{dts}{2};
       
       for prmt = 1:size(parameters, 2)
           
           parameters_all = parameters{prmt};
           
           for each_prmt = 1:size(parameters_all, 2)
               each_one_prmt = num2str(parameters_all(each_prmt));
               
               %datasets
               name_dataset = strcat(dataset_name, '/image_feature_', num2str(each_prmt));
               label_dataset = strcat(dataset_name, '/labels_binary');
               
               input = load(name_dataset);
               output = load(label_dataset);
        
               input = normalize(input.image_feature);
               output = output.saida.features_saida;
               
               for nh = 1:size(neurons, 2)
                   nh_one = neurons(nh);
                   
                   %cross-validation
                   
                   nfold = 10;  
                   X = input;
                   Y = output;
                   fold = crossvalind('Kfold', convert(Y), nfold);
                   
                   accuracies = zeros(1, nfold);
                  
                   for i = 1:nfold
                       
                       rng(0);
                       trn = i ~= fold;
                       tst = ~trn;
                
                       %training
                       Xtr = X(trn, :);
                       Ytr = Y(trn, :);
               
                       %test
                       Xte = X(tst, :);
                       Yte = Y(tst, :);
                       
                       %classify
                       [accuracy, ~] = ELM(Xtr, Ytr, Xte, Yte, nh_one);
                       disp(accuracy)
                       
                       str = strcat('FOLD:', num2str(i), '-',dataset_name, '-', parameter_name, ':',each_one_prmt, '-Neurons:', num2str(nh_one));
                       disp(str);
                   end
               end
           end
       end
    end
end
