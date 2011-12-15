% return area of a triangle on the 3D space
function area = getArea( x1,y1,z1,x2,y2,z2,x3,y3,z3 )
 % vectors
 v1x = x2-x1;
 v1y = y2-y1;
 v1z = z2-z1;

 v2x = x3-x1;
 v2y = y3-y1;
 v2z = z3-z1;

 crossX = (v1y*v2z)-(v1z*v2y);
 crossY = -( (v1x*v2z)-(v1z*v2x) );
 crossZ = (v1x*v2y)-(v1y*v2x);

 area = 0.5*sqrt( crossX*crossX+crossY*crossY+crossZ*crossZ );

