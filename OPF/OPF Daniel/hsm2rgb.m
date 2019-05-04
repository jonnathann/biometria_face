function T = hsm2rgb(I)
H=I(:,:,1);
S=I(:,:,2);
M=I(:,:,3);

for l=1:size(H,1)
    for c=1:size(H,2)
        R(l,c)=(3/41)*S(l,c)*cos(H(l,c));
        R(l,c)=R(l,c)+M(l,c);
        Aux=861*(S(l,c)^2)*(1-(cos(H(l,c))^2));
        Aux=sqrt(Aux);
        R(l,c)=R(l,c)-((4/861)*Aux);
        G(l,c)=sqrt(41)*S(l,c)*cos(H(l,c))+23*M(l,c)-19*(R(l,c));
        G(l,c)=G(l,c)/4;
        B(l,c)=11*R(l,c)-9*M(l,c)-sqrt(41)*S(l,c)*cos(H(l,c));
        B(l,c)=B(l,c)/2;
    end
end
T(:,:,1)=R;
T(:,:,2)=G;
T(:,:,3)=B;