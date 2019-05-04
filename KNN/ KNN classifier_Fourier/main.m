function main()
    
    k = [1, 3, 5, 8, 10];
    margins = {'52', '54', '56'};
    %datasets = {{{'YALE_Viola_Jones-FOURIER-TRANSFORM'}, margins, k, 'margins'}, ...
     %          {{'AR_Viola_Jones-FOURIER-TRANSFORM'}, margins, k, 'margins'}, ...
      %         {{'SDUMLA_Viola_Jones-FOURIER-TRANSFORM'}, margins, k, 'margins'}};
            
    datasets = {{{'JAFFE_Viola_Jones-FOURIER-TRANSFORM'}, margins, k, 'margins'}};
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

