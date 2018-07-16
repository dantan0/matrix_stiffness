% Postprocessing function
%
%Inputs
% 
% d = nodal displacement vector 
% r = vecotr of nodal reactions
% x = list of coordinates of nodes
% conn = table  (matrix)  of connectivitiy of elements
% EI = list of  Element properties (E = Elastic Mod.; I= Moment of Inertia)  


function postprocessor(d,r,x,conn,EI)

ndof 	= 2;     	  % Number of degrees-of-freedom per node
nnd     = length(x);  % Number of nodes
nel     = size(conn,1);  % Number of elements
neq     = nnd*ndof;   % number of equations (dofs)

disp('Displacements and Rotations')

disp('Node:    v              theta')
for n=1:nnd
    disp([num2str(n),'       ',num2str(d(2*n-1),'%8.4e'),'       ',num2str(d(2*n),'%8.4e')]);
end
disp('Reactions')
disp('Node:    R              M')
for n=1:nnd
    disp([num2str(n),'       ',num2str(r(2*n-1),'%8.4e'),'       ',num2str(r(2*n),'%8.4e')]);
end

% plot the deformed shape of the beam
npts = 11;
vpts = zeros(1,npts);
for e=1:nel
    sctr = getsctr(e,conn); 
    de = d(sctr);
    x1 = x(conn(e,1)); % coordinates of node 1
    x2 = x(conn(e,2)); % coordinates of node 2
    L = x2-x1;
    
    % Shape functions defined in terms of a local coordinate system, z
    % z is defined locally 0<=z<=L,
    % so the global coordinates of a point z is x = x1+z;
    z = 0:L/(npts-1):L;
    xpts = x1*ones(1,npts)+z;
    vpts = zeros(1,npts);
    
    for i = 1:npts
       [Ne, dN] = ShapeFunctions(z(i),L);
       vpts(i) = Ne*de;
    end
    
    % scale displacements, specifically for ploting influence line
    vpts = 1/d(2*nnd-1)*vpts;
    
    % plot vertical displacements of the beam
    figure(1)
    plot(xpts,vpts);
    hold on;
    
    %% compute the moment at the midspan (x=L/2) of each element
     
    M = 0;
    disp(['Element ',num2str(e),' midspan bending moment ',num2str(M,'%8.4e'),'       ',num2str(d(2*n),'%8.4e')]);
    
end

plot_beam 	= 'yes';
plot_nod	= 'yes';
plotbeam(x,zeros(1,length(x)),conn,plot_beam,plot_nod);
plot_beam 	= 'no';
plot_nod	= 'yes';
plotbeam(x,d(1:2:(2*nnd-1)),conn,plot_beam,plot_nod);




    
