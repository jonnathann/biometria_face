function main()
    
    neurons = [3000];
    dimension = {'500'};
    
    datasets = {{{'SDUMLA_500'}, dimension, neurons, 'dimension'}};
    for dts = 1:size(datasets, 2)
        
        dataset = datasets{dts}{1};
        parameters = datasets{dts}{2};
        neurons = datasets{dts}{3};
        param = datasets{dts}{4};
        
        k_fold_3(dataset, parameters, neurons, param);
        
    end
end

