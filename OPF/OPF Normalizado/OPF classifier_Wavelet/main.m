function main()
    
    
    fwavelet = {'db2', 'db4', 'sym3', 'sym4', 'sym5'};
    type = 'wavelet';
    
    datasets = {{{'ORL_Viola_Jones-WAVELET-TRANSFORM-LEVEL_3-COMBINATION_LL'}, fwavelet, type},...
                {{'ORL_Viola_Jones-WAVELET-TRANSFORM-LEVEL_3-COMBINATION_LH'}, fwavelet, type}, ...
                {{'ORL_Viola_Jones-WAVELET-TRANSFORM-LEVEL_3-COMBINATION_HL'}, fwavelet, type}, ...
                {{'ORL_Viola_Jones-WAVELET-TRANSFORM-LEVEL_3-COMBINATION_LL+HL'}, fwavelet, type}, ...
                {{'ORL_Viola_Jones-WAVELET-TRANSFORM-LEVEL_3-COMBINATION_LL+HL+LH'}, fwavelet, type}};
              
    for dts = 1:size(datasets, 2)
        
        dataset = datasets{dts}{1};
        parameters = datasets{dts}{2};
        param = datasets{dts}{3};
        
        k_fold_3(dataset, parameters, param);
        
    end
    
    %processing_table_results();
end

