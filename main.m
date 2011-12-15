%  Curvature of a single point
%            
%  by: Gustavo R. ANJOS           
%  @: gustavo.rabello@gmail.com
%            
%  date: 15.NOV.2011         


%            
%
%         * * o * *
%       ^     |     ^       r = sphere radius
%     ^    h  |       ^     r_cap = radius of spherical cap 
%     *       | r_cap *    h = height of the cap
%     o ----- o ----- o          
%             |      /      reference: wikipedia - spherical_cap
%             |     /
%        r-h  |    / r
%             |   /
%             |  /  
%             | /
%             o 
%

% number of neighbours
numNeigh = 10;

% surface radius
radius = 0.5;

% surface cap height
height = 0.134*radius;


% list of neighbours - the list is taken by pairs of vertices belonging
% to the triangle element
% Ex.: 
% numNeigh = 4               IEN = [ 1 2 3 ]
%                                  [ 1 3 4 ]
%  2           5                   [ 1 4 5 ]
%   o ------- o                    [ 1 5 2 ]
%   | \     / |
%   |  \   /  |
%   |    o    |
%	|  / 1 \  |
%   | /     \ |
%	o ------- o
%  3           4
%
% listNeigh = 2,3,4,5,2
listNeigh = [];
for i=1:numNeigh
 listNeigh(i)=i+1;
end
listNeigh(numNeigh+1)=2;

% conectivity array IEN
IEN=zeros(numNeigh,3);

for i=1:numNeigh
 IEN(i,1)=1;
 IEN(i,2)=listNeigh(i);
 IEN(i,3)=listNeigh(i+1);
end

% point's coordinate
X=zeros(numNeigh+1,1);
Y=zeros(numNeigh+1,1);
Z=zeros(numNeigh+1,1);

[X,Y,Z] = pointDistrib(radius,height,numNeigh);

vec=[];
vec = getNormalAndKappa(1,listNeigh,X,Y,Z);

pressure = vec(1);
xNormal = vec(2);
yNormal = vec(3);
zNormal = vec(4);

kappa = 2.0/radius;

fprintf('Curvature: \n');
fprintf('numerical = %d \n',pressure);
fprintf('analytical = %d \n',kappa);
fprintf('\n');

fprintf('Normal: \n');
fprintf('X = %d \n',xNormal);
fprintf('Y = %d \n',yNormal);
fprintf('Z = %d \n',zNormal);

show(X,Y,Z,IEN);

