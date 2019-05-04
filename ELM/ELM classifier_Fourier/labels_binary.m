function labels_binary()
    
    labels = load('rotulos_yalle_binario.mat');
    
    labels = labels.saida.features_saida;
    
    features_saida = [];
    
    for i = 1:size(labels, 1)
        
        features_saida = [features_saida; labels(i, :)];
        disp(i);
        
    end
    save(strcat('labels_binary','.mat'), 'features_saida');

end