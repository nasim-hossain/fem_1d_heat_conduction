# 1D Heat Conduction using Finite Element Method (FEM)

This repository contains a **Finite Element Method (FEM) solver** for a **1D heat conduction problem** with support for:

- Variable number of elements
- Linear or quadratic shape functions

The code is implemented in a general way, allowing users to modify parameters and solve different 1D heat conduction problems.

---

## **Problem Definition**

A **1D steady-state heat conduction** problem is solved with the following parameters:

- **Cross-sectional area**: *A* = 1 m²  
- **Thermal conductivity**: *κ* = 5 W/m°C  
- **Constant heat source**: *s* = 100 W/m  
- **Boundary conditions**:  
  - **T̅** = 0°C at *x* = 0  
  - **q̅** = 0 W/m² at *x* = L  
- **Length**: *L* = 20 m  


### **Problem Schematic**

![image](https://github.com/user-attachments/assets/a3a638db-5e72-402a-9e13-d5bfd3572c16)

---

## **Solution Approach**

The FEM solution is implemented using the following steps:

1. **Mesh Generation**: Discretizing the domain into elements.
2. **Generating Connectivity Matrix**: Bookkeeping element-node connectivity.
3. **Calculating Shape Functions**: Computing shape function \([N]\), derivative \([B]\), and Jacobian.
4. **Element Stiffness & Force Calculation**: Using **Gauss quadrature** to compute element-level matrices.
5. **Assembly of Global Matrices**: Constructing global stiffness matrix and force vector.
6. **Applying Boundary Conditions**: Implementing essential and natural boundary conditions.
7. **Solving for Nodal Temperatures**: Obtaining temperature distribution along the length.

---

## **Results**
After plotting the FEM solution against exact solution, it is observed that result of 3 quadratic elements
almost exactly matches with the exact solution. But for linear element, it takes 5 elements to get a good match
with the exact result. It is clear from the result data that our FEM code is fully cable of solving 1D linear heat
conduction for variable number of elements and linear and/or quadratic shape function.

### **Result Plot**

![image](https://github.com/user-attachments/assets/7068af78-e229-4283-b38b-c2f5fa091e3f)

