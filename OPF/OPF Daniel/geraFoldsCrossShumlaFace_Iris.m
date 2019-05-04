load('D:\Bases De Dados\Shumla\CombinaIrisFace.mat');
pessoas=106;
folds=10;
qtdimagens=84;
for k=1:folds
    for p=1:106
        if p==1
            fold(k).teste=(find(IrisEscolhida(p,:)==k));
        else
            selecionados=find(IrisEscolhida(p,:)==k)+(p-1)*84;
            fold(k).teste=[fold(k).teste,selecionados];
        end
    end
    treino=1:pessoas*qtdimagens;
    treino(fold(k).teste)=[];
    fold(k).treino=treino;
    clear treino
    clear selecionados
end
saida='C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Folds Cross\SDUMLA_Iris+Face_IrisPorFold.mat'
save(saida,'fold');