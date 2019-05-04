clear all
clc
SetImag={'_accessory_eyeglass_','_accessory_hat_','_expresion_frown_','_expresion_pejam_','_expresion_smile_','_expresion_surprise_','_illumination_one_','_illumination_two_','_illumination_three_','_pose_down_','_pose_normal_','_pose_up_'};
qtdPessoas=106;
for p=1:106
    for i=1:size(SetImag,2)
        for pose=1:7
            if(p<10)
                fig=strcat('D:\Bases De Dados\Shumla\Face Database part1\00',int2str(p),'\00',int2str(p),SetImag{i},int2str(pose),'.bmp');
            elseif(p<100)
                fig=strcat('D:\Bases De Dados\Shumla\Face Database part1\0',int2str(p),'\0',int2str(p),SetImag{i},int2str(pose),'.bmp');
            else
                fig=strcat('D:\Bases De Dados\Shumla\Face Database part1\',int2str(p),'\',int2str(p),SetImag{i},int2str(pose),'.bmp');
            end
            if(exist(fig,'file')~=0)
                I=imread(fig);
                [T,Ilu]=rgb2hsm(I);
                arqsaida=strcat('D:\Bases De Dados\Shumla\FacesHSM\HSM\p',int2str(p),'.',int2str(i),'.',int2str(pose),'.HSM.jpg');
                imwrite(T,arqsaida,'JPG');
                arqsaida=strcat('D:\Bases De Dados\Shumla\FacesHSM\p',int2str(p),'.',int2str(i),'.',int2str(pose),'.Contorno.jpg');
                imwrite(Ilu,arqsaida,'JPG');
                BW1=edge(Ilu,'canny',0.5);
                BW1=(BW1-1)*-1;
                arqsaida=strcat('D:\Bases De Dados\Shumla\FacesHSM\Canny\p',int2str(p),'.',int2str(i),'.',int2str(pose),'.Canny.jpg');
                imwrite(BW1,arqsaida,'JPG');
                
            end
        end
    end
end