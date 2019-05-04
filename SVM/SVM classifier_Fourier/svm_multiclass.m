function [accuracy, predict] = svm_multiclass(trainY, trainX, testY, testX, parametros)

model = ovrtrain(trainY, trainX, parametros);
[predict, ac, ~] = ovrpredict(testY, testX, model);
accuracy = ac*100;
fprintf('Accuracy = % g%%\n', accuracy);
end
