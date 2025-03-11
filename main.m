
% Mir MD Nasim Hossain

% Solution over the whole length by solving global stiffness matrix and
% force vector for 1D linear heat conduction


clear
clc
format shortG
      
Length= 20.0;    %length of the domain
Area=1;
tCond=5;         %thermal conductivity
Source= 100;     %Source
flux=0;          % flux given on the rightmost node



%number of elements

nElem=3;

%nodes per element

nNode=3;  % 2 node/ 3 node both can be used

%number of intergration point per element

nInt=2;

%total number of nodes in this mesh

totalNodes= nElem* nNode - (nElem-1);


%generate the mesh

coord=zeros(totalNodes,1);
for i=2:totalNodes
    coord(i)=coord(i-1)+Length/(totalNodes-1);
end

% connectivity matrix

connect=zeros(nElem,nNode);
for i=1:nNode
    connect(1,i)=i;
end
for i=2:nElem
    for j=1: nNode
        connect(i,j)=connect(i-1,j)+nNode-1;
    end
end

%initialization of global stiffness matrix and force vector
gk=zeros(totalNodes,totalNodes);     %global stiffness matrix
gf=zeros(totalNodes,1);              %global force vector
gt=zeros(totalNodes,1);              %global temperature at different nodes

%loop over all elements
for elem=1:nElem;

    %init the element level stiffness matrix and force vector

    Ke=zeros(nNode,nNode);
    Fe=zeros(nNode,1);

    %get the coordinates for the nodes on this element

    nodeCoords= zeros(nNode,1);
    for i=1:nNode
        nodeCoords(i,1)= coord (connect(elem,i));
    end

    %obtain the integration points and weights

    if (nInt==1)
        [xi,w]=gaussInt1Pt();
    elseif (nInt==2)
        [xi,w]=gaussInt2Pt();
    else
        error('nInt not programmed');
    end

    %loop over integration point
    for intPt=1:nInt

        %compute shape function and derivatives
        if (nNode==2)
            [N,B,Jac]=shapeLinear(nodeCoords,xi(intPt));
        elseif (nNode==3)
            [N,B,Jac]=shapeQuadratic(nodeCoords,xi(intPt));
        else
            error('nNode not programmed');
        end
        
        %what is x, based on xi at this integration point

        x=N*nodeCoords;

        % element level stiffness matrix(Gauss quadrature)

        Ke= Ke+ Jac * w(intPt)* transpose(B)*Area * tCond * B;

        %element level force vector(Gauss quadrature)
        
        Fe= Fe + Jac * w(intPt)* transpose(N)*Source;
    end
    
    %calculation of flux:BC (at last node)

      if elem(end)== nElem
            if nNode==3
                xend= nodeCoords(end);
                Lx=Length/nElem;
                Nf= (2/(Lx^2))*[0 0 ((xend-nodeCoords(1,1))*(xend-nodeCoords(2,1)))];
            elseif nNode==2
                xend= nodeCoords(end);
                Lx=Length/nElem;
                Nf= (1/Lx)*[0 (xend-nodeCoords(1))];
            end
            fluxElem= transpose(Nf)*Area*flux;
            Fe(end)= Fe(end)- fluxElem(end);
      end

%     fprintf('Stiffness matrix for element %0.0f is= \n', elem);
%     disp(Ke);
%     fprintf('Force vector for element %0.0f is = \n',elem );
%     disp(Fe);

    %store element stiffness matrix on the global stiffness matrix
    for i=1:nNode
        for j=1:nNode
            rowtemp= connect(elem,i);
            coltemp= connect(elem,j);
            gk(rowtemp,coltemp)= gk(rowtemp,coltemp)+Ke(i,j);
        end
    end

    %store element force vector on the global force vector
    for i=1:nNode
        rowtemp= connect(elem,i);
        gf(rowtemp,1)=gf(rowtemp)+Fe(i,1);
    end

end
    fprintf('Global stiffness matrix is: \n');
    disp(gk);
    fprintf('Global force vector is: \n');
    disp(gf);

%Applying prescribed boundary condition 

    gt(1)=0;

%solving the global matrices and vector

    gt(2:end,1)=gk(2:end,2:end)\gf(2:end,1);
    fprintf('Solution over the whole length is: \n')
    disp(gt)

%Calculating the exact solution
Te= @(x) -10*x.^2+400.*x;   %declaring function for exact solution
x= 1:1:Length;            
ye=Te(x);
    
%plotting FEM & exact solution for temperature at each node
% over the length
plot(coord,gt(1:end,1),'r--',x,ye,'b*','linewidth',2);
legend('FEM solution','exact','Location','northwest'); legend('boxoff');
set(gca,'Fontname','Arial','Fontsize',16,'Fontweight','bold');
xlim([0 20]); ylim([0 4500]);
xlabel('Length(m)');
ylabel('Temperature(C)');

function [N,B,Jac] = shapeLinear(nodeCoords,xi)

%shape function derivatives for 2-node 1D element

%nodal coordinates

x1= nodeCoords(1,1);
x2= nodeCoords(2,1);

%element length

Le= x2-x1;

%the shape function matrix

N= (1.0/2.0)* [1.0-xi 1.0+xi];

%derivative of shape functions

B=(1.0/Le)* [-1.0 1.0];

%the mapping jacobian

Jac= Le/2.0;

return;
end

function [N,B,Jac]= shapeQuadratic (nodeCoords,xi)
%shape functions and derivatives for a 3 node 1D element

%nodal coordinates
x1=nodeCoords(1,1);
x2=nodeCoords(2,1);
x3=nodeCoords(3,1);

% the shape function matrix
N1 = (1/2)*xi*(xi - 1);
N2 = (1 + xi)*(1 - xi);
N3 = (1/2)*xi*(xi + 1);
N = [N1 N2 N3];


% derivatives of shape functions wrt xi
%
dN1dXi = xi - 1/2;
dN2dXi = -2*xi;
dN3dXi = xi + 1/2;


% the mapping jacobian
%
Jac = dN1dXi*x1 + dN2dXi*x2 + dN3dXi*x3;

% derivatives of shape functions wrt x

B = [dN1dXi dN2dXi dN3dXi]/Jac;

return;
end

function [xi,w]= gaussInt1Pt()
%gauss integration locations and weights for 1pt Integration
xi=0.0;
w=2.0;
return;
end

function [xi,w]= gaussInt2Pt()
%gauss integration locations and weight for 2pt integration
xi(1)=-sqrt(1.0/3.0);
xi(2)=sqrt(1.0/3.0);

w(1)=1.0;
w(2)=1.0;
return
end















