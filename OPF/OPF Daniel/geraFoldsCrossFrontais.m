pessoas=106;
folds=10;
ImgPos=[3:7:84,4:7:84,7:7:84];
ImgPos=sort(ImgPos);
for p=1:106
    VetAle=randperm(size(ImgPos,2));
    VetAle=ImgPos(VetAle);
    DadosFold=floor(size(VetAle,2)/folds);
    FoldsMaiores=mod(size(VetAle,2),folds);
    for k=1:folds
        if k<=FoldsMaiores
            selecionados=[(k-1)*DadosFold+1:k*DadosFold,folds*DadosFold+k];
            fold(k).teste{p}=VetAle(selecionados);
            Aux=VetAle;
            Aux(selecionados)=[];
            fold(k).treino{p}=Aux;
        else
            selecionados=(k-1)*DadosFold+1:k*DadosFold;
            fold(k).teste{p}=VetAle(selecionados);
            Aux=VetAle;
            Aux(selecionados)=[];
            fold(k).treino{p}=Aux;
        end        
    end
end
return

saida='C:\Users\Daniel\Dropbox\Daniel\Face\Bases\ShumlaDatabase\Folds Cross\SDUMLA_FaceFrontal_Separado.mat';
save(saida,'fold');
