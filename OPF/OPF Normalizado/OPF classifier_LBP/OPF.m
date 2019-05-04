function [accuracy, predict] = OPF(X, Y, nclass, id, Xtr, Ytr, Xte, Yte, trn, tst)

basepath = '/home/clodoaldo/fnametest';
fname_all = fullfile(basepath, 'xyz.opf');
opf_bin(X, Y, id, nclass, fname_all);
[r1, ~] = system(sprintf('/usr/local/opf/bin/opf_distance %s 1 1', fname_all));
assert(r1 == 0);

fname_trn = fullfile(basepath, 'train.opf');
opf_bin(Xtr, Ytr, id(trn), nclass, fname_trn);
        
fname_tst = fullfile(basepath, 'test.opf');
opf_bin(Xte, Yte, id(tst), nclass, fname_tst);
        
[r1, ~] = system(sprintf('/usr/local/opf/bin/opf_train %s distances.dat', fname_trn));
[r2, ~] = system(sprintf('/usr/local/opf/bin/opf_classify %s distances.dat', fname_tst));
assert(r1 == 0 || r2 == 0);
        
yp = csvread([fname_tst '.out']);
error = mean(Yte ~= yp);
predict = [yp, Yte];
accuracy  = (1 - error)*100;
end

function opf_bin(x, y, id, nclass, fname)
[m, n] = size(x);
fid = fopen(fname, 'w');
fwrite(fid, [m nclass n], 'uint32');
for i = 1:m
    fwrite(fid, [id(i) y(i)], 'uint32');
    fwrite(fid, x(i, :), 'float32');
end
fclose(fid);
end