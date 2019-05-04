function main()
    
    mask = {'38x38', '42x42', '46x46'};
    %datasets = {{{'YALE_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, 'mask'},...
     %           {{'AR_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, 'mask'}, ...
      %          {{'SDUMLA_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, 'mask'}};
            
    datasets = {{{'JAFFE_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, 'mask'}};
    for dts = 1:size(datasets, 2)
        
        dataset = datasets{dts}{1};
        parameters = datasets{dts}{2};
        param = datasets{dts}{3};
        
        k_fold_3(dataset, parameters, param);
        
    end
    
    %gerando tabelas
    processing_table_results();
end

