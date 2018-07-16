function plotbeam(x,y,conn,plot_beam,plot_nod)

nel = size(conn,1); % number of elements
nn = length(x); %number of nodes

% check if truss plot is requested
if strcmpi(plot_beam,'yes')==1
    for e = 1:nel
        XX = [x(conn(e,1)) x(conn(e,2))  ];
        YY = [y(conn(e,1)) y(conn(e,2))  ];
        line(XX,YY,'LineWidth',2);hold on;
        
    end
end

if strcmpi(plot_nod,'yes')==1
    for n = 1:nn
        % check if node numbering is requested
        text(x(n),y(n),sprintf('%0.5g',n),'Color','red','FontSize',14);
    end
end
title('Beam Plot');
end

% nicely size plot
% xmin = min(x);
% xmax = max(x);
% ymin = min(y);
% ymax = max(y);
% framex = 0.1*(xmax-xmin);
% framey = 0.1;
% bounds = [(xmin-framex) (xmax+framex) (ymin-framey)  (ymax+framey)];
% axis(bounds)
