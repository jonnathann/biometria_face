function [accuracy, predicts] = ensemble_ELM(Xtr, Ytr, Xte, Yte, components, list_neurons, n_class)

    predicts_all_ensemble = [];
    for i = 1:components
        
        list_values = randperm_repeat(size(Xtr, 1));
        Xtr = Xtr(list_values, :);
        Ytr = Ytr(list_values, :);
        
        predict = ELM(Xtr, Ytr, Xte, Yte, list_neurons(i));
        
        predicts_all_ensemble = [predicts_all_ensemble, convert(predict)];
        
        str = strcat('Ensemble ELM Component: ', num2str(i), '-Neurons: ', num2str(list_neurons(i)));
        disp(str);
    end
    predicts = vote(predicts_all_ensemble, n_class);
    accuracy = calc_accuracy(predicts, convert(Yte));
    
end

function list_values = randperm_repeat(number)
list_values = [];
for i = 1:number
    rand_values = randperm(number);
    list_values = [list_values, rand_values(1)];
end
end

function output_vote_ensemble = vote(predicts_ensemble, qtd_class)
output_vote_ensemble = [];
for i = 1: size(predicts_ensemble, 1)
    [~, label] = max(histc(predicts_ensemble(i, :), 1:qtd_class));
    output_vote_ensemble = [output_vote_ensemble; label];
end
end

function accuracy = calc_accuracy(output_ensemble, labels)

predict = [output_ensemble, labels];

count = 0;
total_instances = size(predict, 1);
for i=1:total_instances
    
    if predict(i, 1) ==  predict(i, 2)
        count = count + 1;
    end
end
accuracy = (100*count)/total_instances;
end