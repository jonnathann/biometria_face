function main()
    
    gamma = [2e-2, 2e-3, 2e-4, 2e-5, 2e-6, 2e-7, 2e-8, 2e-9];
    %gamma = [2e-2];
    mask = {'38x38', '42x42', '46x46'};
    %mask = {'46x46'};
    %datasets = {{{'YALE_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, gamma, 'mask'}, ...
     %           {{'AR_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, gamma, 'mask'}, ...
      %          {{'SDUMLA_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, gamma, 'mask'}};
            
    datasets = {{{'ORL_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, gamma, 'mask'}};
    for dts = 1:size(datasets, 2)
        
        dataset = datasets{dts}{1};
        parameters = datasets{dts}{2};
        gamma = datasets{dts}{3};
        param = datasets{dts}{4};
        
        k_fold_3(dataset, parameters, gamma, param);
        
    end
    
    %gera tabelas
    processing_table_results();
end
