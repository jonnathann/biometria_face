function main()
    
    neurons = [200, 500, 800, 1200, 1500, 1800, 2100, 2400, 2700, 3000];
    dimension = {'300', '500', '700'};
    %datasets = {{{'Autoencoder-YALE'}, dimension, neurons, 'dimension'},...
     %           {{'Autoencoder-AR'}, dimension, neurons, 'dimension'},...
      %          {{'Autoencoder-SDUMLA'}, dimension, neurons, 'dimension'}};
    
    datasets = {{{'Autoencoder-ORL'}, dimension, neurons, 'dimension'}};
    for dts = 1:size(datasets, 2)
        
        dataset = datasets{dts}{1};
        parameters = datasets{dts}{2};
        neurons = datasets{dts}{3};
        param = datasets{dts}{4};
        
        k_fold_3(dataset, parameters, neurons, param);
        
    end
end

