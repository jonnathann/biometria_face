function predicts_all = predicts_concatenate(structure)

predicts_all = [];
fold = 10;

for i = 1:fold
    
    pred = structure(i).predicts_fold;
    predicts_all = [predicts_all; pred]; 
    
end
end