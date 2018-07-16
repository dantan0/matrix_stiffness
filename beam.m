%*************************************************************************
% Beam Code - Introduction to the Finite Element Method 
% Reference Chapter 16 - Fundamentals of Structural Analysis, Leet et al.
% Reference Chapter 10 - A first course in finite elements by Fish and Belytschko)  
% Reference Chapter 4 - A first course in the finite element method by Logan)
% Dr. Robert Gracie, University of Waterloo, Waterloo, 2018
%*************************************************************************
close all; 
 

%% Preprocessor Phase 
%[x,conn,EI,W_a,W_b,forces_nodes,fixed_dofs,fixed_values] = preprocessor;
%[x,conn,EI,W_a,W_b,forces_nodes,fixed_dofs,fixed_values] = preprocessor_beam2;
[x,conn,EI,W_a,W_b,forces_nodes,fixed_dofs,fixed_values] = preprocessor_beam3;
[x,conn,EI,W_a,W_b,forces_nodes,fixed_dofs,fixed_values] = preprocessor_beam4;
%[x,conn,EI,W_a,W_b,forces_nodes,fixed_dofs,fixed_values] = preprocessor_beam5a;
%[x,conn,EI,W_a,W_b,forces_nodes,fixed_dofs,fixed_values] = preprocessor_beam5b;
%[x,conn,EI,W_a,W_b,forces_nodes,fixed_dofs,fixed_values] = preprocessor_beam5c;

%% define some constants
ndof 	= 2;     	  % Number of degrees-of-freedom per node
nnd     = length(x);  % Number of nodes
nel     = size(conn,1);  % Number of elements
neq     = nnd*ndof;   % number of equations (dofs)


 
f 	= zeros(neq,1);           % Initialize vector of external forces at nodes
d 	= zeros(neq,1);   % Initialize vectr of nodal displacements
K = zeros(neq,neq);     % Initialize stiffness matrix
% large faster computation for large systems relpalce with 
% K 	= sparse(neq,neq);     % Initialize stiffness matrix


%% Calculation and assembly of the global stiffness matrix
for e = 1:nel    
    sctr = getsctr(e,conn);    
    x1 = x(conn(e,1)); % coordinates of node 1
    x2 = x(conn(e,2)); % coordinates of node 2
    L = x2 - x1; % length of element
    
    Ke	= beamelem(EI(e),L);
    
    % assemble element contribution to the global stiffness matrix
    for ii=1:4
        i = sctr(ii); % global dof associated with local dof ii
        for jj=1:4
            j = sctr(jj); % global dof associated with local dof jj
            K(i,j) = K(i,j) + Ke(ii,jj);
        end
    end
    % fast way to do assembly
    % K(sctr,sctr) = K(sctr,sctr) + Ke;
end

%% Calculation and assembly of the global external force Vector

for e = 1:nel    
    sctr = getsctr(e,conn);    
    x1 = x(conn(e,1)); % coordinates of node 1
    x2 = x(conn(e,2)); % coordinates of node 2
    L = x2 - x1; % length of element
    a = W_a(e);
    b = W_b(e);
    f_e = beamelem_f(a,b,L);
    
    % assemble element contribution to the global force/moment vector
    for ii=1:4
        i = sctr(ii); % global dof associated with local dof ii
        f(i) = f(i) + f_e(ii);
    end
    % fast way to do assembly
    % f(sctr) = f(sctr) + f_e;

end
% Add contributions from point forces acting at nodes
for I = 1:nnd    
        f(2*I-1) = f(2*I-1) + forces_nodes(I);
end
