function [predict_classe, predict_prob] = convert(entrada)
    
    line = size(entrada, 1);
    predict_c = [];
    predict_p = [];
    
    
    for i = 1:line
        [prob, label] =  max(entrada(i, 1:end));
        predict_c = [predict_c; label]; %#ok<*AGROW>
        predict_p = [predict_p; prob];
    end
    predict_classe = predict_c;
    predict_prob = predict_p;

end

