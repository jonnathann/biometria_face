function main()
    
    %Quantidade de neurônios por componentes.
    comp_1 = 500:100:900;
    comp_2 = 500:100:1400;
    comp_3 = 500:100:1900;
    comp_4 = 500:100:2400;
    comp_5 = 500:100:2900;
    comp_6 = 500:100:3400;

    components = {comp_1, comp_2, comp_3, comp_4, comp_5, comp_6};
    
    mask = {'38x38', '42x42', '46x46'};
    %datasets = {{{'YALE_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, 'mask'}, ...
     %           {{'AR_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, 'mask'}, ...
      %          {{'SDUMLA_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, 'mask'}};
            
    datasets = {{{'JAFFE_Viola_Jones-LOCAL-BINARY-PATTERN'}, mask, 'mask'}};
    for dts = 1:size(datasets, 2)
        
        for cmp = 1:size(components, 2)
            dataset = datasets{dts}{1};
            parameters = datasets{dts}{2};
            param = datasets{dts}{3};
            k_fold_3(dataset, parameters, size(components{cmp}, 2), components{cmp}, param);
        end
    end
end

