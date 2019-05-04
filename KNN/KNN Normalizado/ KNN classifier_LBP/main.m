function main()
    
    k = [1, 3, 5, 8, 10];
    mask = {'38x38', '42x42', '46x46'};
    %datasets = {{{'YALE_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, k, 'mask'}, ...
     %           {{'AR_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, k, 'mask'}, ...
      %          {{'SDUMLA_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, k, 'mask'}, ...
       %         {{'JAFFE_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, k, 'mask'}};
    
    datasets = {{{'ORL_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, k, 'mask'}};
    for dts = 1:size(datasets, 2)
        
        dataset = datasets{dts}{1};
        parameters = datasets{dts}{2};
        k = datasets{dts}{3};
        param = datasets{dts}{4};
        
        k_fold_3(dataset, parameters, k, param);
        
    end
    
    %gera tabelas
    processing_table_results();
end

