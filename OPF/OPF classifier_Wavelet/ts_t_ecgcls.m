function ts_t_ecgcls()

param = {};

i = 0;
i = i + 1; param{i, 1} = @ts_t_ecgknn; param{i, 2} = {[5 10 15]};
%i = i + 1; param{i, 1} = @ts_t_ecglda; param{i, 2} = {NaN};
i = i + 1; param{i, 1} = @ts_t_ecgopf; param{i, 2} = {1};

for i = 1:size(param, 1)
    aux = param{i, 2};
    fun = param{i, 1};
    comb = allcomb(aux{:});
    str = strrep(func2str(fun), 'ts_t_ecg', '');
    basedir = fullfile(getenvhome(), ['data_' str]);
    if ~exist(basedir, 'file'), mkdir(basedir); end
    datafile = dir(fullfile(getenvhome(), 'data_rep', '*.mat'));
    foldmat = load(fullfile(getenvhome(), 'data.mat'));
    for f = datafile'
        datamat = load(fullfile(f.folder, f.name));
        disp(f.name);
        assert(length(datamat.model.y) == length(foldmat.fold));
        for j = 1:size(comb, 1)
            file = fullfile(basedir, sprintf('%s%.8i.mat', f.name(1:end-4), j));
            if exist(file, 'file')
                continue;
            end
            yp = fun(datamat, foldmat, comb(j, :), basedir, f.name);
            model = rmfield(datamat.model, 'x');
            model.yp = yp;
            model.inclass = comb(j, :);
            save(file, 'model');
        end
    end
end

end

function [yp] = ts_t_ecgknn(datamat, foldmat, comb, ~, ~)
yp = zeros(size(datamat.model.y));
nfold = numel(accumarray(foldmat.fold, 1));
for j = 1:nfold
    test = foldmat.fold == j;
    train = ~test;
    mdl = fitcknn(datamat.model.x(train, :), datamat.model.y(train, :), 'NumNeighbors', comb);
    yp(test, :) = predict(mdl, datamat.model.x(test, :));
end
end

function [yp] = ts_t_ecglda(datamat, foldmat, ~, ~, ~)
yp = zeros(size(datamat.model.y));
nfold = numel(accumarray(foldmat.fold, 1));
for j = 1:nfold
    test = foldmat.fold == j;
    train = ~test;
    mdl = fitcdiscr(datamat.model.x(train, :), datamat.model.y(train, :), 'discrimType', 'pseudoLinear');
    yp(test, :) = predict(mdl, datamat.model.x(test, :));
end
end

function [yp] = ts_t_ecgopf(datamat, foldmat, ~, basedir, fname)
yp = zeros(size(datamat.model.y));
nfold = numel(accumarray(foldmat.fold, 1));

fname = fname(1:end-4);
id = (1:numel(datamat.model.y))-1; % quantidade de instancias
nclass = numel(accumarray(datamat.model.y, 1));%
fname_dst = fullfile(basedir, 'distances.dat');
fname_all = fullfile(basedir, sprintf('%s%.8i.opf', fname, 1));
opf_bin(datamat.model.x, datamat.model.y, id, nclass, fname_all);%

[r1, ~] = system(sprintf('/usr/local/opf/bin/opf_distance %s 1 1', fname_all));%
[r2, ~] = system(sprintf('mv distances.dat %s', basedir));
[r3, ~] = system(sprintf('rm %s', fname_all));
assert(r1 == 0 || r2 == 0 || r3 == 0);

for j = 1:nfold
    test = foldmat.fold == j;
    train = ~test;
    
    fname_trn = fullfile(basedir, sprintf('%s%.8i_%.2i_train.opf', fname, 1, j));%
    opf_bin(datamat.model.x(train, :), datamat.model.y(train, :), id(train), nclass, fname_trn);%
    
    fname_tst = fullfile(basedir, sprintf('%s%.8i_%.2i_test.opf', fname, 1, j));%
    opf_bin(datamat.model.x(test, :), datamat.model.y(test, :), id(test), nclass, fname_tst);%
    
    [r1, ~] = system(sprintf('/usr/local/opf/bin/opf_train %s %s', fname_trn, fname_dst));
    [r2, ~] = system(sprintf('/usr/local/opf/bin/opf_classify %s %s', fname_tst, fname_dst));
    [r3, ~] = system('rm classifier.opf');
    assert(r1 == 0 || r2 == 0 || r3 == 0);
    
    yp(test, :) = csvread([fname_tst '.out']);
    
    [r1, ~] = system(sprintf('rm %s', [fname_trn '*']));
    [r2, ~] = system(sprintf('rm %s', [fname_tst '*']));
    assert(r1 == 0 || r2 == 0);
end

[r1, ~] = system(sprintf('rm %s', fname_dst));
assert(r1 == 0);
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