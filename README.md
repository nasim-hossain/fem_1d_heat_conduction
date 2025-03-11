# FEM_1d_heat_conduction
A linear 1D heat conduction problem was solved using finite element method (FEM). FEM code was written in such a way that variable number of elements and linear or quadratic shape function can be used to solve the problem. A particular case given below is solved in the code, but values can be changed to solve any linear 1d heat conduction problem.

In this problem the cross-sectional area is A= 1 m2, thermal conductivity κ = 5 W/m°C, the constant heat source is s=100 W/m, 𝑇 " = 0°C and 𝑞"= 0 W/m2. Length is L=20m

![image](https://github.com/user-attachments/assets/a3a638db-5e72-402a-9e13-d5bfd3572c16)

Steps taken to solve the problem is:
      1. Generating Mesh
      2. Generating connectivity matrix for bookkeeping
      3. Calculating Shape function [N], derivative of shape function [B] and Jacobian
      4. Calculating element level stiffness matrix and force vector (using gauss quadrature)
      5. Using connectivity matrix to generate global stiffness matrix and force vector
      6. Applying boundary condition
      7. Solving for temperature over the length at each node

# Results:
After plotting the FEM solution against exact solution, it is observed that result of 3 quadratic elements
almost exactly matches with the exact solution. But for linear element, it takes 5 elements to get a good match
with the exact result. It is clear from the result data that our FEM code is fully cable of solving 1D linear heat
conduction for variable number of elements and linear and/or quadratic shape function.

![image](https://github.com/user-attachments/assets/7068af78-e229-4283-b38b-c2f5fa091e3f)
