% return the cross product of two vectors
function cross = crossProd(x1,y1,z1,x2,y2,z2)
 cross = zeros(3,1);
 cross(1) = (y1*z2)-(z1*y2);
 cross(2) = -( (x1*z2)-(z1*x2) );
 cross(3) = (x1*y2)-(y1*x2);


