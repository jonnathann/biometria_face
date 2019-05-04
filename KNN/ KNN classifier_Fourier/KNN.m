function [accuracy, predict] = KNN(Xtr, Ytr, Xte, Yte, qtd_class, k)

 labels = [];
 
 for test = 1:size(Xte, 1)
     
     distance_labels = [];
     
     for training = 1:size(Xtr, 1)
         
         label_training = Ytr(training);
         distance = euclidian_distance(Xte(test, 1:end), Xtr(training, 1:end));
         
         distance_labels = [distance_labels; distance, label_training];
         
     end
     
     ordenado = sortrows(distance_labels);
     
     indice =  majority_vote(ordenado(:, end), qtd_class, k);
     
     labels = [labels; indice];
     
 end
 [accuracy, predict] = calc_accuracy(labels, Yte);
 
end

function [accuracy, predict] = calc_accuracy(labels_model, labels_training)
count = 0;
predict = [labels_model];
for i = 1:size(labels_model, 1)
    if labels_model(i) == labels_training(i)
        count = count + 1;
    end
     
end
accuracy = (count * 100)/size(labels_model, 1);
end

function distance = euclidian_distance(A, B)
    
    distance = sqrt(sum((A - B).^2));

end

function indice =  majority_vote(vector_distance_labels, qtde_class, k_neighbors)
    
    vector_distance_labels = vector_distance_labels(1:k_neighbors, end);
    vector_incremental = zeros(1, qtde_class); 
    
    for i = 1:size(vector_distance_labels, 1)
       
        vector_incremental(vector_distance_labels(i)) = vector_incremental(vector_distance_labels(i)) + 1;
        
    end
    [~, indice] = max(vector_incremental);
    
end