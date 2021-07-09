#=
Title: Introducción a la Programación en Julia, Script 3
Author: Mauricio M. Tejada
Institution: Departamento de Economía, Universidad Alberto Hurtado
Date: Julio 2021
Language Version: 1.6.1 
=#

# Cargamos el paquete de herramientas de álgebra lineal de Julia (viene en la instalación base)
using LinearAlgebra

# Matrices
A = [1.0 2.0 3.0; 4.0 5.0 6.0; 7.0 8.0 9.0]

B = [1.0 2.0 3.0; 4.0 5.0 6.0]

C = [1.0; 2.0; 3.0]  # Note que este es un arreglo en una dimensión 

C = [1.0 2.0 3.0]' # Vector columna 3 x 1

D = [1.0 4.0 3.0] # Vector fila 1 x 3

filas, cols = size(A)

# Secuencias
H0 = 1:10

H0 = collect(1:10)

H1 = collect(1:0.6:3)

o = collect(10:-2:2)

H2 = range(1,stop=4,step = 0.1)

H2 = collect(range(1,stop=8,length = 10))

H3 = collect(exp10.(range(1,stop=3,length=3)))

# Matrices especiales
ME1 = zeros(3,2)

ME2 = ones(4,1)

ME3 = Matrix{Float64}(I, 2, 2)

# Números aleatorios
ME4 = rand(2,2)

ME5 = randn(3,1)

xn = 2.0*ones(3,3) + 0.5*randn(3,3)

xu = 2.0*ones(2,2) + (4-2)*rand(2,2)

# Operaciones con matrices
A = [1 2 3; 4 5 6; 7 8 9];
B = [1 1 1; 2 2 2; 3 3 3];   

S = A + B

R = A - B

MM = A*B

P = A^2 # Idem P = A*A

C = rand(3,3)

Ctrans = transpose(C)

IV = inv(C)

DI = C \ A    # Idem DI = inv(C)*A`

DI = inv(C)*A

# Operaciones elemento por elemento
A = [1 2 3; 4 5 6; 7 8 9];
B = [1 1 1; 2 2 2; 3 3 3];  

Me = A.*B

Me = A./B

Pe = A.^2

# Indexación y elementos de una matriz
a22 = A[2,2]

a31 = A[3,1]

subA1 = A[1:2,1:2]

subA2 = A[2:3,1:3]

subA3 = A[2,:]

subA4 = A[:,2:3]

subA5 = A[2:end,3]

B=rand(4,6);
Ind = 1:4;

subB1 = B[Ind,5]

subB2 = B[1:4,5]

Indc = [1, 3, 4]

Indf = [2, 4]

subB3 = B[Indf,Indc]

A = rand(3,2);
B = rand(2,2);

C = [A ; B]

D = [A' B]

# Arreglos de mayor dimensión
A = rand(2,2,2)

A[2,2,1]
