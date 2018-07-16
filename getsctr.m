function   sctr = getsctr(e,conn)
% Returns the scatter vector (sctr) used to assemble the local stiffness matrix 
% of element e into the global stiffness matrix.
%
% inputs: 
% e = element number
% conn = connectivity matrix for whole mesh

% global ID of node 1 of element e
n1 = conn(e,1);
% global ID of node 2 of element e
n2 = conn(e,2);

% scatter matrix for regular degrees of freedom (dof)
sctr = zeros(4,1);

% global dof number of x-displacement of node 1 of element e
sctr(1)= (n1-1)*2 + 1; 
% global dof number of y-displacement of node 1 of element e
sctr(2)= (n1-1)*2 + 2;
% global dof number of x-displacement of node 2 of element e
sctr(3)= (n2-1)*2 + 1;
% global dof number of y-displacement of node 1 of element e
sctr(4)= (n2-1)*2 + 2;
