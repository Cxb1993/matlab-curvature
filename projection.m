% return the projection of vector p1 over p2
function proj = projection( p1x,p1y,p1z,p2x,p2y,p2z )
 len = vectorLength(p2x,p2y,p2z);
 p2xUnit = p2x/len;
 p2yUnit = p2y/len;
 p2zUnit = p2z/len;
 dot = dotProd(p1x,p1y,p1z,p2xUnit,p2yUnit,p2zUnit);

 proj=zeros(3,1);
 proj(1) = p2xUnit*dot;
 proj(2) = p2yUnit*dot;
 proj(3) = p2zUnit*dot;


