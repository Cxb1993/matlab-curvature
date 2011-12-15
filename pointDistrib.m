function [X,Y,Z] = pointDistrib(radius,height,numNeigh)

X = zeros(numNeigh,1);
Y = zeros(numNeigh,1);
Z = zeros(numNeigh,1);

r_cap = sqrt( 2*height*radius - height*height );

X(1)=0;
Y(1)=0;
Z(1)=radius;

j=2;
theta=0;
dtheta=(2*pi/numNeigh);
for jj=1:numNeigh
 X(j)=r_cap*cos(theta);
 Y(j)=r_cap*sin(theta);
 Z(j)=Z(1)-height;
 theta = theta+dtheta;
 j=j+1;
 if (theta >= 2*pi)
  break;
 end;
end;

%--------------------------------------------------
% X(1) =  0.000000; Y(1) =  0.000000; Z(1) = 2.00000;
% X(2) =  1.000000; Y(2) =  0.000000; Z(2) = 1.73205;
% X(3) =  0.707107; Y(3) =  0.707107; Z(3) = 1.73205;
% X(4) =  0.000000; Y(4) =  1.000000; Z(4) = 1.73205;
% X(5) = -0.707107; Y(5) =  0.707107; Z(5) = 1.73205;
% X(6) = -1.000000; Y(6) =  0.000000; Z(6) = 1.73205;
% X(7) = -0.707107; Y(7) = -0.707107; Z(7) = 1.73205;
% X(8) = -0.000000; Y(8) = -1.000000; Z(8) = 1.73205;
% X(9) =  0.707107; Y(9) = -0.707107; Z(9) = 1.73205;
%-------------------------------------------------- 

