function [X,Y,Z,IEN] = disk(a,a1,a2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% malha de tetraedros delaunay - DISCO, algoritimo MATLAB %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n_lados_primeiro_poligono=a;
ncircmax=a1;
nz=a2;

n=1;
dr=1;
r=dr;
dl=(2*pi/n_lados_primeiro_poligono)*dr;

j=1;
Xcirc(j,1)=0;
Ycirc(j,1)=0;
j=j+1;
for ncirc=1:ncircmax
    theta=0;
    dtheta=dl/ncirc*dr;
    for jj=1:(n_lados_primeiro_poligono*ncirc)
        Xcirc(j,1)=r*cos(theta);
        Ycirc(j,1)=r*sin(theta);
        theta = theta+dtheta;
        j=j+1;
        if (theta >= 2*pi)
            break;
        end;
    end;
    r=r+dr;
end;
rmax=r-dr;
j=1;
z=0;
for jz=1:nz
    if (jz<=nz/2)
        dz=0.1;
    else
        % refino em Z, 2 opcoes:
        dz=min([exp(z/nz) exp(2/3)]);
        %dz=exp(nz/11.6);
    end;
    for jcirc=1:size(Xcirc,1)
        X3d(j,1)=Xcirc(jcirc,1);
        Y3d(j,1)=Ycirc(jcirc,1);
        Z3d(j,1)=z;
        j=j+1;
    end;
    z=z+dz;
end;

X=[X3d];
Y=[Y3d];
Z=[Z3d];

IEN = delaunay3(m.X,m.Y,m.Z,{'Qt','QbB','Qc'});

nvert=size(m.X,1);
nelem=size(m.IEN,1);
nnodes=nvert+nelem;

%--------------------------------------------------
% Y=(Y)/rmax*Red;
% X=(X)/rmax*Red;
% factorz=1/(max(Z)-min(Z));
% Z=(Z)*factorz*10;
%-------------------------------------------------- 

