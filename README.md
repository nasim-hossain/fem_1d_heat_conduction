# 1D Heat Conduction using Finite Element Method (FEM)

This repository contains a **Finite Element Method (FEM) solver** for a **1D heat conduction problem** with support for:

- Variable number of elements
- Linear or quadratic shape functions

The code is implemented in a general way, allowing users to modify parameters and solve different 1D heat conduction problems.

---

## **Problem Definition**

A **1D steady-state heat conduction** problem is solved with the following parameters:

- **Cross-sectional area**: \(A = 1 \text{ m}^2\)
- **Thermal conductivity**: \(\kappa = 5 \text{ W/m}\degree C\)
- **Constant heat source**: \(s = 100 \text{ W/m}\)
- **Boundary conditions**:
  - \(\bar{T} = 0\degree C\) at \(x = 0\)
  - \(\bar{q} = 0 \text{ W/m}^2\) at \(x = L\)
- **Length**: \(L = 20 \text{ m}\)

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

After comparing the FEM solution with the exact solution:

- **3 quadratic elements** yield a solution that **almost exactly matches** the exact result.
- **5 linear elements** are required to achieve a **good match** with the exact result.
- This confirms that the **FEM code works correctly** for different element types and numbers.

### **Result Plot**

![image](https://github.com/user-attachments/assets/7068af78-e229-4283-b38b-c2f5fa091e3f)

