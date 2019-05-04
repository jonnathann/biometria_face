function main()
    
    neurons = [10, 20, 50, 100, 150];
    mask = {'38x38', '42x42', '46x46'};
    
    %datasets = {{{'YALE_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, neurons, 'mask'}, ...
     %           {{'AR_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, neurons, 'mask'}, ...
      %          {{'SDUMLA_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, neurons, 'mask'}};
            
    
    datasets = {{{'ORL_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, neurons, 'mask'}};
    for dts = 1:size(datasets, 2)
        
        dataset = datasets{dts}{1};
        parameters = datasets{dts}{2};
        neurons = datasets{dts}{3};
        param = datasets{dts}{4};
        
        k_fold_3(dataset, parameters, neurons, param);
        
    end
end

