Detectados=zeros(106,10);
for i=1:106
    for p=1:10
        teste=strcat('p',int2str(i),'.',int2str(p),'Iris.mat');
        if(exist(teste)==2)
            Detectados(i,p)=p;
        end
    end
end
for i=1:106
    X=find(Detectados(i,:)==0);
    if(size(X)~=0)
        Y=find(Detectados(p,:)~=0);
        Sub=randperm(size(Y,2));
       for p=1:size(X,2)
           Detectados(i,X(p))=Y(Sub(p));
       end
    end
end
saida=strcat('D:\Bases De Dados\Shumla\IrisDetectadas.mat');
save(saida,'Detectados');