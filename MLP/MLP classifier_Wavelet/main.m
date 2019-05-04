 function main()
    
    neurons = [10, 20, 50, 100, 150];
    fwavelet = {'db2', 'db4', 'sym3', 'sym4', 'sym5'};
    type = 'wavelet';
    
    datasets = {{{'ORL_Viola_Jones-WAVELET-TRANSFORM-LEVEL:3-COMBINATION:LL'}, fwavelet, neurons, type}, ...
                 {{'ORL_Viola_Jones-WAVELET-TRANSFORM-LEVEL:3-COMBINATION:LH'}, fwavelet, neurons, type}, ...
                 {{'ORL_Viola_Jones-WAVELET-TRANSFORM-LEVEL:3-COMBINATION:HL'}, fwavelet, neurons, type}, ...
                 {{'ORL_Viola_Jones-WAVELET-TRANSFORM-LEVEL:3-COMBINATION:LL+HL'}, fwavelet, neurons, type}, ...
                 {{'ORL_Viola_Jones-WAVELET-TRANSFORM-LEVEL:3-COMBINATION:LL+HL+LH'}, fwavelet, neurons, type}};
            
    for dts = 1:size(datasets, 2)
        
        dataset = datasets{dts}{1};
        parameters = datasets{dts}{2};
        neurons = datasets{dts}{3};
        param = datasets{dts}{4};
        
        k_fold_3(dataset, parameters, neurons, param);
        
    end
end

