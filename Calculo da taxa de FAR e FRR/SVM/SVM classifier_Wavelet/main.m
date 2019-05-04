function main()
    
    gamma = [2e-3];
    fwavelet = {'sym4'};
    type = 'wavelet';
    
    datasets = {{{'ORL_sym4:LL'}, fwavelet, gamma, type}};
            
    for dts = 1:size(datasets, 2)
        
        dataset = datasets{dts}{1};
        parameters = datasets{dts}{2};
        gamma = datasets{dts}{3};
        param = datasets{dts}{4};
        
        k_fold_3(dataset, parameters, gamma, param);
        
    end
    
end

