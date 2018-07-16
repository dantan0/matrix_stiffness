% generate the element distributed force/moment vector
% equivalent to fixed end moments and forces.
function fe = beamelem_f(a,b,L)

% this implementation assumes the w(x) = a. 

% should be modified to work for w(x) = a + bx

c = a * L / 2;    % constant coefficient for each truss element

fe = c*[1; -L/6; 1; L/6];
