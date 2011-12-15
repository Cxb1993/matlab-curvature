function vec = getNormalAndKappa(node,listNeigh,X,Y,Z)

 P0x = X(node);
 P0y = Y(node);
 P0z = Z(node);

 fx=0;
 fy=0;
 fz=0; 
 sumArea=0;
 sumXCrossUnit=0;
 sumYCrossUnit=0;
 sumZCrossUnit=0;
 listSize=size(listNeigh,2);

 %             node
 %               o        a = distance (node,v1)
 %              / \       b = distance (node,v2)
 %           a /   \ b    c = distance (v1,v2)
 %            /     \
 %           /       \
 %          o ------- o
 %         v1    c    v2     

 % loop in all neighbour elements
 for i=1:listSize-1
  v1 = listNeigh(i);
  v2 = listNeigh(i+1);

  P1x = X(v1);
  P1y = Y(v1);
  P1z = Z(v1);

  P2x = X(v2);
  P2y = Y(v2);
  P2z = Z(v2);

  a = distance(P0x,P0y,P0z,P1x,P1y,P1z);
  b = distance(P0x,P0y,P0z,P2x,P2y,P2z);
  c = distance(P1x,P1y,P1z,P2x,P2y,P2z);
  
  % vectors
  x1 = P1x-P0x;
  y1 = P1y-P0y;
  z1 = P1z-P0z;

  x2 = P2x-P0x;
  y2 = P2y-P0y;
  z2 = P2z-P0z;

  xReta = P1x-P2x;
  yReta = P1y-P2y;
  zReta = P1z-P2z;

  x1Unit = x1/a;
  y1Unit = y1/a;
  z1Unit = z1/a;

  x2Unit = x2/b;
  y2Unit = y2/b;
  z2Unit = z2/b;

  % cross product - normal to each triangular element
  cross = crossProd(x1Unit,y1Unit,z1Unit,x2Unit,y2Unit,z2Unit);

  sumXCrossUnit = sumXCrossUnit + cross(1);
  sumYCrossUnit = sumYCrossUnit + cross(2);
  sumZCrossUnit = sumZCrossUnit + cross(3);

  xPlaneRes = x1Unit+x2Unit;
  yPlaneRes = y1Unit+y2Unit;
  zPlaneRes = z1Unit+z2Unit;

  % subtraindo vetor tangente do vetor unitario para encontrar as
  % coordenadas do vetor normal SITUADO NA SUPERFICE (face do
  % tetrahedro = triangulo)
  % 
  %                 P0
  %                  ^
  %                 / \
  %                /   \
  %               /     \
  %            P1 ------- P2
  %                  ----> PlaneTang
  %                  |\
  %                  | \  PlaneRes
  %                  |  \
  %                PlaneNormal
  %

  proj = projection(xPlaneRes,yPlaneRes,zPlaneRes,xReta,yReta,zReta);

  xPlaneTang = proj(1);
  yPlaneTang = proj(2);
  zPlaneTang = proj(3);

  xPlaneNormal = xPlaneRes - xPlaneTang;
  yPlaneNormal = yPlaneRes - yPlaneTang;
  zPlaneNormal = zPlaneRes - zPlaneTang;

  len = vectorLength(xPlaneNormal,yPlaneNormal,zPlaneNormal);

  % Unitario do vetor resultante situado no plano do triangulo
  % combinacao linear dos vetores unitarios das arestas do triangulo
  xPlaneNormalUnit = xPlaneNormal/len;
  yPlaneNormalUnit = yPlaneNormal/len;
  zPlaneNormalUnit = zPlaneNormal/len;

  % normal ao plano integrada na distancia (MOD) dos 2 vertices medianos
  % force = resultante das componentes * tamanho da aresta que sera
  % usada como referencia no calculo da area do triangulo 
  base = c/2.0;

  fx = fx+xPlaneNormalUnit*base;
  fy = fy+yPlaneNormalUnit*base;
  fz = fz+zPlaneNormalUnit*base;

  % 1/3 of area node-v1-v2
  sumArea = sumArea + (1.0/3.0)*getArea(P0x,P0y,P0z,P1x,P1y,P1z,P2x,P2y,P2z);
 end

 len = vectorLength(sumXCrossUnit,sumYCrossUnit,sumZCrossUnit);
 xNormalUnit = sumXCrossUnit/len;
 yNormalUnit = sumYCrossUnit/len;
 zNormalUnit = sumZCrossUnit/len;

 % intensidade da forca resultante
 force = -sqrt( (fx*fx)+(fy*fy)+(fz*fz) );

 % teste para saber o sentido correto de aplicacao da
 % pressao no noh.
 if( dotProd(fx,fy,fz,xNormalUnit,yNormalUnit,zNormalUnit) < 0.0 )
  force = -force;
 end

 pressure = force/sumArea;

 vec=[];
 vec(1)=pressure;
 vec(2)=xNormalUnit;
 vec(3)=yNormalUnit;
 vec(4)=zNormalUnit;

