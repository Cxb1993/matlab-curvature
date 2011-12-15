function n = show(X,Y,Z,IEN)
%modelo de documentacao a partir de:
%http://www.engin.umd.umich.edu/CIS/course.des/cis400/matlab/oop.html

%SIMULATOR simulator class constructor.
%   s = Simulator(m) creates a simulator object from the mesh object 

%Name: show
%Location: <path>/@Simulator
%Purpose: show the velocity, pressure and scalar fields                         

% modificado em 28/01/2007
% revisado   em 09/04/2007

vector=[X(:) Y(:) Z(:)];

trisurf(IEN,X,Y,Z)
title('kappa')

daspect([1 1 0.5])
colormap(jet)
drawnow
