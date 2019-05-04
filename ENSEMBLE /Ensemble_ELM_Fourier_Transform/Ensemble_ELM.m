function Ensemble_ELM(components)

     

      %generate_components(X, Y, components)
      selection_components(components);
     


end


function selection_components(components)
    
    for i = 1:components
       
        cmp = load(strcat('Component_', num2str(i), '.mat'));
        [predict, Yte] = ELM(cmp.Component.Xtr, cmp.Component.Ytr, cmp.Component.Xtv, cmp.Component.Ytv, cmp.Component.Neurons);
        
        Component_ELM = struct('predict', convert(predict), 'Yte', Yte, 'Neurons', cmp.Component.Neurons); %#ok<*NASGU>
        name = strcat('Component_ELM_', num2str(i));
        save(strcat(name,'.mat'), 'Component_ELM');
    end
    
    predicts = [];
    best = 0;
    for i = 1:components
    
        cmp_elm = load(strcat('Component_ELM_', num2str(i), '.mat'));
        predicts = [predicts, cmp_elm.Component_ELM.predict]; %#ok<*AGROW>
        
        votation = vote(predicts, unique(convert(cmp_elm.Component_ELM.Yte)));
        accuracy = calc_accuracy(votation, convert(cmp_elm.Component_ELM.Yte));
        accuracy
        
    end
end


function generate_components(X, Y, components)

    neurons = 200:300:300*components;
    
    tam_70 = round(0.7 * size(X, 1));
    perm = randperm(size(X, 1));
    X = X(perm, :);
    Y = Y(perm, :);
    X = normalize(X);
    Xtr = X(1:tam_70, :);
    Ytr = Y(1:tam_70, :);
    
    Xtv = X(tam_70 + 1:end, :);
    Ytv = Y(tam_70 + 1:end, :);
    
    for i = 1:components
        
        Component = struct('Xtr', Xtr, 'Ytr', Ytr, 'Xtv', Xtv, 'Ytv', Ytv, 'Neurons', neurons(i)); %#ok<*NASGU>
        name = strcat('Component_', num2str(i));
        save(strcat(name,'.mat'), 'Component');
        
    end
end

function list_values = randperm_repeat(number)
list_values = [];
for i = 1:number
    rand_values = randperm(number);
    list_values = [list_values, rand_values(1)];
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

function output_vote_ensemble = vote(predicts_ensemble, qtd_class)
output_vote_ensemble = [];
for i = 1: size(predicts_ensemble, 1)
    [~, label] = max(histc(predicts_ensemble(i, :), 1:qtd_class));
    output_vote_ensemble = [output_vote_ensemble; label];
end
end

