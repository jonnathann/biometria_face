function main()

    neurons = [10, 20, 50, 100, 150];
    %neurons = [150];
    margins = {'52', '54', '56'};
    %margins = {'56'};
    
    %datasets = {{{'YALE_Viola_Jones-FOURIER-TRANSFORM'}, margins, neurons, 'margins'}, ...;
     %   {{'AR_Viola_Jones-FOURIER-TRANSFORM'}, margins, neurons, 'margins'}, ...
     %   {{'SDUMLA_Viola_Jones-FOURIER-TRANSFORM'}, margins, neurons, 'margins'}};
            
    
    datasets = {{{'ORL_Viola_Jones-FOURIER-TRANSFORM'}, margins, neurons, 'margins'}};
            
    for dts = 1:size(datasets, 2)
        
        dataset = datasets{dts}{1};
        parameters = datasets{dts}{2};
        neurons = datasets{dts}{3};
        param = datasets{dts}{4};
        
        k_fold_3(dataset, parameters, neurons, param);  
         
    end
end

