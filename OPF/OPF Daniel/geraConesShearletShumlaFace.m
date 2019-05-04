qtdclasses=106;
poses=12;
fotos=7;

for pessoa=1:qtdclasses
    for pose=1:poses
        for foto=1:fotos
            imagem=strcat('Z:\BaseDados\SDUMLA\Faces Caracteristicas\Shearlet\p',...
                int2str(pessoa),'.',int2str(pose),'.',int2str(foto),'.FaceShearletCoeficientes.mat');
            load(imagem);
            return
            Coef.A=coef.A;
            Coef.CH=coef.CH;
            Coef.CV=coef.CV;
            Coef.CD=coef.CD;
            save(imagem,'Coef');
        end
    end
end