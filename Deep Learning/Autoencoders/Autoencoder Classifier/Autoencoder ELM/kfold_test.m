
function kfold_test(datasets, parameters)

    for dts = 1:size(datasets, 2)
        
       dataset_name = datasets{dts}{1};
       parameter_name = datasets{dts}{2};
       
       for prmt = 1:size(parameters, 2)
           
           parameters_all = parameters{prmt};
           
           parameters_all
       end
    end
end