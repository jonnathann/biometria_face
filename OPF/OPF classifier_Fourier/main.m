function main()
    
    margins = {'52', '54', '56'};
    %datasets = {{{'YALE_Viola_Jones-FOURIER-TRANSFORM'}, margins, 'margins'}, ...
     %          {{'AR_Viola_Jones-FOURIER-TRANSFORM'}, margins, 'margins'}, ...
      %         {{'SDUMLA_Viola_Jones-FOURIER-TRANSFORM'}, margins, 'margins'}};
            
    datasets = {{{'JAFFE_Viola_Jones-FOURIER-TRANSFORM'}, margins, 'margins'}};
    for dts = 1:size(datasets, 2)
        
        dataset = datasets{dts}{1};
        parameters = datasets{dts}{2};
        param = datasets{dts}{3};
        
        k_fold_3(dataset, parameters, param);
        
    end
    
end

