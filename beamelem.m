% generate the element stiffness matrix for each element
function Ke = trusselem(EI,L)


k = EI / L ^ 3;    % constant coefficient for each truss element



Ke = k*[12 , 6*L  ,  -12,   6*L;       % stiffness matrix for beam element
        6*L, 4*L^2, -6*L, 2*L^2;
        -12,  -6*L,   12,  -6*L;
        6*L, 2*L^2, -6*L, 4*L^2];
