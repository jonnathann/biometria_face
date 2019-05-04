function [accuracy, predict_classe, predict_prob] = svm_multiclass(trainY, trainX, testY, testX, parametros)
model = ovrtrain(trainY, trainX, parametros);

[predict_classe, ac, output_real] = ovrpredict(testY, testX, model);
accuracy = ac*100;

%Cálculo das probabilidades das saídas
sigmoid_norm = 1./(1 + exp(-output_real));
[~, predict_prob] = convert(sigmoid_norm);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('Accuracy = % g%%\n', accuracy);
end
