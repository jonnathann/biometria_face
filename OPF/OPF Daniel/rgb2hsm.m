% conversor HSM
function [T,Ilu] = rgb2hsm(I)
Input=double(I);
R=Input(:,:,1)/255;
G=Input(:,:,2)/255;
B=Input(:,:,3)/255;
M=zeros(size(R,1),size(R,2));
H=zeros(size(R,1),size(R,2));
S=zeros(size(R,1),size(R,2));
Ilu=zeros(size(R,1),size(R,2));
for l=1:size(R,1)
    for c=1:size(R,2)
%         Equação 1
        M(l,c)=4*R(l,c)+2*G(l,c)+B(l,c);
        M(l,c)=M(l,c)/7;
    end
end
for l=1:size(R,1)
    for c=1:size(R,2)
%         Equacao 2(1)
        Aux1=3*(R(l,c)-M(l,c));
        Aux1=Aux1-(4*(G(l,c)-M(l,c)));
        Aux1=Aux1-(4*(B(l,c)-M(l,c)));
        Aux1=Aux1/sqrt(41);
%         Equacao 2(2)
        Aux2=(R(l,c)-M(l,c))^2;
        Aux2=Aux2+((G(l,c)-M(l,c))^2);
        Aux2=Aux2+((B(l,c)-M(l,c))^2);
        Aux2=sqrt(Aux2);
%         Equacao 2= Cos-1((1/2))
        Teta=cos(Aux1/Aux2)^-1;
%         Equacao 3
        if(B(l,c)>G(l,c))
            Omega=(2*pi)-Teta;
        else
            Omega=Teta;
        end
%         Equacao 4
        H(l,c)=Omega/(2*pi);
    end
end
for l=1:size(R,1)
    for c=1:size(R,2)
%         Equacao 5(1)
        if(M(l,c)>=0 && M(l,c)<=1/7)
            Aux1=(R(l,c)-M(l,c))^2+(G(l,c)-M(l,c))^2+(B(l,c)-M(l,c))^2;
            Aux1=sqrt(Aux1);
            Aux2=(0-M(l,c))^2;
            Aux2=Aux2+((0-M(l,c))^2);
            Aux2=Aux2+((7-M(l,c))^2);
            Aux2=sqrt(Aux2);
            S(l,c)=Aux1/Aux2;            
            %         Equacao 5(2)
        elseif(M(l,c)>1/7 && M(l,c)<=3/7)
            Aux1=(R(l,c)-M(l,c))^2+(G(l,c)-M(l,c))^2+(B(l,c)-M(l,c))^2;
            Aux1=sqrt(Aux1);
            Aux2=(0-M(l,c))^2;
            Aux2=Aux2+((((7*M(l,c)-1)/2)-M(l,c))^2);
            Aux2=Aux2+((1-M(l,c))^2);
            Aux2=sqrt(Aux2);
            S(l,c)=Aux1/Aux2;     
            %         Equacao 5(3)
        elseif(M(l,c)>3/7 && M(l,c)<=1/2)
            Aux1=(R(l,c)-M(l,c))^2+(G(l,c)-M(l,c))^2+(B(l,c)-M(l,c))^2;
            Aux1=sqrt(Aux1);
            Aux2=(((7*M(l,c)-3)/2)-M(l,c))^2;
            Aux2=Aux2+((1-M(l,c))^2);
            Aux2=Aux2+((1-M(l,c))^2);
            Aux2=sqrt(Aux2);
            S(l,c)=Aux1/Aux2;     
            %         Equacao 5(4)
        elseif(M(l,c)>1/2 && M(l,c)<=4/7)
            Aux1=(R(l,c)-M(l,c))^2+(G(l,c)-M(l,c))^2+(B(l,c)-M(l,c))^2;
            Aux1=sqrt(Aux1);
            Aux2=(((7*M(l,c))/4)-M(l,c))^2;
            Aux2=Aux2+((0-M(l,c))^2);
            Aux2=Aux2+((0-M(l,c))^2);
            Aux2=sqrt(Aux2);
            S(l,c)=Aux1/Aux2;     
            %         Equacao 5(5)
        elseif(M(l,c)>4/7 && M(l,c)<=6/7)
            Aux1=(R(l,c)-M(l,c))^2+(G(l,c)-M(l,c))^2+(B(l,c)-M(l,c))^2;
            Aux1=sqrt(Aux1);
            Aux2=(1-M(l,c))^2;
            Aux2=Aux2+(((((7*M(l,c))-4)/2)-M(l,c))^2);
            Aux2=Aux2+((0-M(l,c))^2);
            Aux2=sqrt(Aux2);
            S(l,c)=Aux1/Aux2;            
            %         Equacao 5(6)
        elseif(M(l,c)>6/7 && M(l,c)<=1)
            Aux1=(R(l,c)-M(l,c))^2+(G(l,c)-M(l,c))^2+(B(l,c)-M(l,c))^2;
            Aux1=sqrt(Aux1);
            Aux2=((1-M(l,c))^2);
            Aux2=Aux2+((1-M(l,c))^2);
            Aux2=Aux2+(((7*M(l,c)-6)-M(l,c))^2);
            Aux2=sqrt(Aux2);
            S(l,c)=Aux1/Aux2;            
        end
    end
end
for l=1:size(R,1)
    for c=1:size(R,2)
        Aux1=R(l,c)+G(l,c)+B(l,c);
        Aux1=Aux1/3;
        Ilu(l,c)=M(l,c)-Aux1;
        if(Ilu(l,c)>=0.0185 && Ilu(l,c)<=0.05)
            Ilu(l,c)=0;
        else
            Ilu(l,c)=1;
        end
    end
end
T(:,:,1)=H;
T(:,:,2)=S;
T(:,:,3)=M;