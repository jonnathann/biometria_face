function main()
    
    gamma = [2e-2, 2e-3, 2e-4, 2e-5, 2e-6, 2e-7, 2e-8, 2e-9];
    fwavelet = {'db2', 'db4', 'sym3', 'sym4', 'sym5'};
    type = 'wavelet';
    
    datasets = {{{'ORL_Viola_Jones-WAVELET-TRANSFORM-LEVEL:3-COMBINATION:LL'}, fwavelet, gamma, type},...
                {{'ORL_Viola_Jones-WAVELET-TRANSFORM-LEVEL:3-COMBINATION:LH'}, fwavelet, gamma, type},...
                {{'ORL_Viola_Jones-WAVELET-TRANSFORM-LEVEL:3-COMBINATION:HL'}, fwavelet, gamma, type},...
                {{'ORL_Viola_Jones-WAVELET-TRANSFORM-LEVEL:3-COMBINATION:LL+HL'}, fwavelet, gamma, type},...
                {{'ORL_Viola_Jones-WAVELET-TRANSFORM-LEVEL:3-COMBINATION:LL+HL+LH'}, fwavelet, gamma, type}};
               
    for dts = 1:size(datasets, 2)
        
        dataset = datasets{dts}{1};
        parameters = datasets{dts}{2};
        gamma = datasets{dts}{3};
        param = datasets{dts}{4};
        
        k_fold_3(dataset, parameters, gamma, param);
        
    end
    
end

