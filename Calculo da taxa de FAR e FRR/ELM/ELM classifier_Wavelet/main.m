function main()
    
    neurons = [1500];
    fwavelet = {'sym4'};
    type = 'wavelet';
    
    datasets = {{{'SDUMLA_sym4:LL+HL'}, fwavelet, neurons, type}};
    for dts = 1:size(datasets, 2)
        
        dataset = datasets{dts}{1};
        parameters = datasets{dts}{2};
        neurons = datasets{dts}{3};
        param = datasets{dts}{4};
        
        k_fold_3(dataset, parameters, neurons, param);
        
    end
end

