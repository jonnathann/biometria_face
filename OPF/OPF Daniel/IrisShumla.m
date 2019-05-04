function I = IrisShumla(i)
% dimensões da imagem polar final
radial_res = 20;
angular_res = 240;
% with these settings a 9600 bit iris template is
% created
%feature encoding parameters
nscales=1;
minWaveLength=10;
mult=1; % not applicable if using nscales = 1
sigmaOnf=0.5;
% Qtd Imagem Iris
Iris=5;
Eye={'L','R'};
p=i;
for e=1:size(Eye,2)
    for i=1:Iris
        if p<10
            Input=strcat('D:\Bases De Dados\Shumla\Iris Database\00',int2str(p),'\',Eye{e},'\00',int2str(p),'_',Eye{e},'_0',int2str(i),'.bmp');
        elseif p<100
            Input=strcat('D:\Bases De Dados\Shumla\Iris Database\0',int2str(p),'\',Eye{e},'\0',int2str(p),'_',Eye{e},'_0',int2str(i),'.bmp');
        else
            Input=strcat('D:\Bases De Dados\Shumla\Iris Database\',int2str(p),'\',Eye{e},'\',int2str(p),'_',Eye{e},'_0',int2str(i),'.bmp');
        end
        % Carrega as Imagens
        I=imread(Input);
        % Segmenta a iris
        [circleiris circlepupil imagewithnoise] = segmentiris(I);
        imagewithcircles = uint8(I);
        %get pixel coords for circle around iris
        [x,y] = circlecoords([circlepupil(2),circlepupil(1)],circleiris(3),size(I));
        ind2 = sub2ind(size(I),double(y),double(x));
        %get pixel coords for circle around pupil
        [xp,yp] = circlecoords([circlepupil(2),circlepupil(1)],circlepupil(3),size(I));        
         ind1 = sub2ind(size(I),double(yp),double(xp));
         % Limiar para exclusao de pontos
         imagewithcircles(ind2) = 255;
         imagewithcircles(ind1) = 255;
         % Salva a íris destacada
        Segmentada=strcat('D:\Bases De Dados\Shumla\Iris Segmentada\IrisDetectada\p',int2str(p),'.',int2str((e-1)*5+i),'IrisSegmentada.jpg');
        imwrite(imagewithcircles,Segmentada,'jpg');
        % Gera imagem polar
        [polar_array noise_array] = normaliseiris(imagewithnoise, circlepupil(2),...
            circlepupil(1), circleiris(3), circlepupil(2), circlepupil(1), circlepupil(3),Input, radial_res, angular_res);
        %Gera o iriscode
        [template mask] = encode(polar_array, noise_array, nscales, minWaveLength, mult, sigmaOnf);
        IrisSeg.polarA=polar_array;
        IrisSeg.noiseA=noise_array;
        IrisSeg.ImgC=imagewithcircles;
        IrisSeg.ImgN=imagewithnoise;
        IrisSeg.temp=template;
        IrisSeg.mask=mask;
        IrisSeg.Pupil=circlepupil;
        IrisSeg.Iris=circleiris;
        saida=strcat('D:\Bases De Dados\Shumla\Iris Segmentada\p',int2str(p),'.',int2str((e-1)*5+i),'Iris.mat');
        save(saida,'IrisSeg');
    end
end
