%%********************************************************************
% Function: preprocessor
%
% x = list of coordinates of nodes
% conn = table  (matrix)  of connectivitiy of elements
% EI = list of  Element properties (E = Elastic Mod.; I= Moment of Inertia)  
%
% External distributed load acting of element e is given by w = a+bx, where
%  a is stored at index e of array W_a, i.e. a = W_a(e)
%  b is stored at index e of array W_b, i.e. a = W_b(e)
%
% forces_nodes = vector of point forces acting at each node.
%
% fixed_dofs = list of indices of fixed degrees of freedom (displacents)
% fixed_values = list of values of prescribed displacements
%********************************************************************
function  [x,conn,EI,W_a,W_b,forces_nodes,fixed_dofs,fixed_values] ...
    = preprocessor_beam4

nsd 	= 1;	      % Number of space dimensions 
ndof 	= 2;     	  % Number of degrees-of-freedom per node
nnp 	= 5;    	  % Number of nodal points
nel 	= 4;     	  % Number of elements
nen 	= 2;     	  % Number of element nodes
 
neq 	= ndof*nnp;	  % Number of equations
 
%% mesh generation
% Node:  1 -- 2 -- 3   (origin placed at node 1) 
%--------------------
x = [0, 1.5, 3, 5, 7];     % X coordinate  

% connectivity array
% conn(e, i) returns the global node number associate with the ith node of
% element e.
conn = zeros(nel,2);
conn(1,:) =  [1 ,   2 ];    % element 1 connectivity  
conn(2,:) =  [2,    3 ];    % element 2 connectivity
conn(3,:) =  [3,    4 ];    % element 3 connectivity
conn(4,:) =  [4,    5 ];    % element 3 connectivity
    
% Element properties
EI 	= [20, 20, 20, 20]*10^6;   	% Elements EI [N-m^2]  
% Distributed Load over Each Element:
% External distributed load acting of element e is given by w = a+bx, where
%  a is stored at index e of array W_a, i.e. a = W_a(e)
%  b is stored at index e of array W_b, i.e. a = W_b(e)
W_a  	= [0, 0, 0, -1.0e3 ];   	% [N]
W_b  	= [0 , 0, -1.0e3/2, 1.0e3/2];   	% [N/m]

% Point forces
forces_nodes = [0,-10e3,0,0,0];

% prescribed displacements

% list of degrees of freedom (dofs) that are prescribed (essential bcs)
fixed_dofs  = [1  ,5  ,9 ];     
% vector of the values prescribed at each dof.
fixed_values = [0  ;0 ;0];

 
%output plots
plot_beam 	= 'no';
plot_nod	= 'yes';

% plot beam
plotbeam(x,zeros(1,length(x)),conn,plot_beam,plot_nod);

% print mesh parameters
fprintf(1,'\tBeam Model Params \n');
fprintf(1,'No. of Elements  %d \n',nel);
fprintf(1,'No. of Nodes     %d \n',nnp);
fprintf(1,'No. of Equations %d \n\n',neq);
