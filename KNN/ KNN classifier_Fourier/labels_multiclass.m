function labels_multiclass()

    labels = load('labels_m.mat');
    labels = labels.saida.features_saida;
    features_saida = [];
    for i = 1:size(labels, 1)
        
        features_saida = [features_saida; labels(i)];
        
    end
    save(strcat('labels_multiclass','.mat'), 'features_saida');
endŋŋŋŋ