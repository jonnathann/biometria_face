function [pred, ac, decv] = ovrsvm(ytst, xtst, ytrn, xtrn, cmdtrn, cmdtst)

labelSet = unique(ytrn);
labelSetSize = length(labelSet);

decv = [];
for i=1:labelSetSize
    model = svmtrain(double(ytrn == labelSet(i)), xtrn, cmdtrn);
    model.Label(1)
%     [~,~,d] = svmpredict(double(ytst == labelSet(i)), xtst, model, cmdtst);
%     decv(:, i) = d * (2 * model.Label(1) - 1);
%     d * (2 * model.Label(1) - 1)
end
[~, pred] = max(decv, [], 2);
pred = labelSet(pred);
ac = sum(ytrn==pred) / size(xtrn, 1);

end