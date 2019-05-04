function [eer, accept, accuracy, erro, reje ] = far_ffr_mod(pred)
%l = load('example.mat');
%[eer, accept] = ts_z_eer_aux(l.label, l.dist, l.yy);
[eer, accept, accuracy, erro, reje ] = ts_z_eer_aux(pred(:, 3), pred(:, 1), pred(:, 2), pred);
end

function [eer, accept, accuracy, erro, reje] = ts_z_eer_aux(label, dist, yy, pred)
%dist = 1 - dist / max(dist);



interval = unique(sort([0 ; dist]));
interval = (interval(2:end) + interval(1:end-1)) / 2;
interval = [-0.1 ; interval ; 1.1]';
freq = size(interval, 2);

% False Acceptance Rate and False Recognition Rate
far = label ~= yy;
frr = label == yy;
distfar = dist(far);
distfrr = dist(frr);
distfar = repmat(distfar, 1, freq);
distfrr = repmat(distfrr, 1, freq);

if sum(far) <= 1
    threshold = -1;
    accept = dist > threshold;
    eer = sum(dist(frr) > threshold) / size(dist, 1) * 100;
    return;
end

perfar = mean(distfar < interval);
perfrr = mean(distfrr < interval);
perfar = 1 - perfar;
pos = find(perfrr > perfar, 1, 'first');

assert1 = sum([distfar ; distfrr] < interval);
assert(assert1(1) == 0 && assert1(end) == size(dist, 1));

interval(1) = 0;
interval(end) = 1;

x = [interval(pos-1) interval(pos) interval(pos-1) interval(pos)]';
y = [perfar(pos-1) perfar(pos) perfrr(pos-1) perfrr(pos)]';
denominator = (x(1)-x(2))*(y(3)-y(4))-(y(1)-y(2))*(x(3)-x(4));
point = [((x(1)*y(2)-y(1)*x(2))*(x(3)-x(4))-(x(1)-x(2))*(x(3)*y(4)-y(3)*x(4)))/denominator ...
    ,((x(1)*y(2)-y(1)*x(2))*(y(3)-y(4))-(y(1)-y(2))*(x(3)*y(4)-y(3)*x(4)))/denominator];

threshold = point(1);
accept = dist > threshold;
eer = sum(dist(frr) > threshold) / size(dist, 1) * 100;


plot(interval, perfar, '-r');hold on;
plot([threshold threshold], [0 1], '--k');
plot(interval, perfrr, '-b');hold off;
disp(threshold);
[accuracy, erro, reje] = accuracy_threshold(pred, threshold);
end

function [accuracy, erro, reje] = accuracy_threshold(predicts_all, threshold)

accept = 0;
err = 0;
rejected = 0;
for i = 1:size(predicts_all)
    if predicts_all(i, 1) > threshold && predicts_all(i, 2) == predicts_all(i, 3)
        
        accept = accept + 1;
        
    end
    
    if predicts_all(i, 1) > threshold && predicts_all(i, 2) ~= predicts_all(i, 3)
        
        err = err + 1;
        
    end
    
    if predicts_all(i, 1) < threshold
        
        rejected = rejected + 1;
        
    end
    
    accuracy = (accept*100)/size(predicts_all, 1);
    erro = (err * 100)/size(predicts_all, 1);
    reje = (rejected * 100)/size(predicts_all, 1);
end
end