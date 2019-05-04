 function main()
    
    neurons = [100];
    fwavelet = {'db2'};
    type = 'wavelet';
    
    datasets = {{{'AR_db2:LL'}, fwavelet, neurons, type}};
            
    for dts = 1:size(datasets, 2)
        
        dataset = datasets{dts}{1};
        parameters = datasets{dts}{2};
        neurons = datasets{dts}{3};
        param = datasets{dts}{4};
        
        k_fold_3(dataset, parameters, neurons, param);
        
    end
end

