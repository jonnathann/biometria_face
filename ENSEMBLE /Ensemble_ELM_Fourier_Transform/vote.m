function output_vote_ensemble = vote(predicts_ensemble, qtd_class)
output_vote_ensemble = [];
for i = 1: size(predicts_ensemble, 1)
    [~, label] = max(histc(predicts_ensemble(i, :), 1:qtd_class));
    output_vote_ensemble = [output_vote_ensemble; label];
end
end