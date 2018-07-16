% partition and solve the system of equations
function [d,r] = solvedr(K,f,fixed_dofs,fixed_values)

neq = size(K,1);  % number of equations/ dofs.

% list of free/unknown dofs
free_dofs = setxor(1:neq,fixed_dofs);

% partition the matrix K, vectors f and d
K_E	= K(fixed_dofs,fixed_dofs);             % Extract K_E matrix 
K_F	= K(free_dofs,free_dofs);               % Extract K_E matrix
K_EF = K(fixed_dofs,free_dofs);             % Extract K_EF matrix
f_F = f(free_dofs);                         % Extract f_F vector
f_E = f(fixed_dofs);                        % Extract f_E vector
d_E = fixed_values;                         % Extract d_E vector
 
% solve for d_F
d_F	=K_F\( f_F - K_EF'* d_E);
 
% reconstruct the global displacement d
d = zeros(neq,1);
d(fixed_dofs) = d_E;     
d(free_dofs) = d_F;
                  
 
% compute the reaction r_E=f_E
r_E = K_E*d_E+K_EF*d_F-f_E;
 

r = zeros(neq,1);
r(fixed_dofs) = r_E;
