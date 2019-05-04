function main()

    neurons = [50];
    margins = {'52'};
      
    datasets = {{{'JAFFE_52x52'}, margins, neurons, 'margins'}};
            
    for dts = 1:size(datasets, 2)
        
        dataset = datasets{dts}{1};
        parameters = datasets{dts}{2};
        neurons = datasets{dts}{3};
        param = datasets{dts}{4};
        
        k_fold_3(dataset, parameters, neurons, param);  
         
    end
end

