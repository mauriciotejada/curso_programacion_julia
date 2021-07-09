#=
Title: Introducción a la Programación en Julia, Script 4
Author: Mauricio M. Tejada
Institution: Departamento de Economía, Universidad Alberto Hurtado
Date: Julio 2021
Language Version: 1.6.1 
=#

# Funciones escalares 
a = 2
expa = exp(a)

cosa = cos(a)

loga = log(a)

b = -2.2
absa = abs(b)

B = [2, 3]
expB = exp.(B)

C = rand(2,2)
logC = log.(C)

round(1.6)

ceil(1.2)

floor(1.2)

sign(-4)

# Funciones vectoriales
v = rand(6,1) # Generamos un vector

vmax = maximum(v)

vmin = minimum(v)

length(v)

G = rand(5,3)

a = maximum(G)

a = maximum(G, dims=1) # Máximo por columnas

a = maximum(G, dims=2) # Máximo por filas

G_suma_asum = cumsum(G, dims=1) # Acumula suma por columnas

minval, posind = findmax(G)

posind[1]

posind[2]

minval, posind = findmax(G,dims=1)

posind[1]

posind[1][1] # Posición max en primera columna (fila,col). Además posición fila dentro esa columna.

using Statistics

mGc = mean(G)  # promedio de todos los elementos de la matriz.

mGf = mean(G,dims=1) # promedios por columnas

mGf = mean(G,dims=2)  # promedios por filas

mGc = std(G) # desvío estándar, todos los elementos

mGf = mean(G,dims=1) # desvío estándar por columnas

a = rand(5,1)
b = rand(5,1)
covab = cov(a,b)

# Funciones matriciales
using LinearAlgebra

G = rand(3,3)

det_matriz = det(G)

inv(G)

diag(G)

diagm(0 => collect(1:4))

vecG = G[:]

vecG = reshape(G,9,1)

eigenval, eigenvecs = eigen(G)

F = ones(4,4)

tril(F)

triu(F)

H = fill(5.0, (4,4))

v = collect(1:1:9)

R = reshape(v,3,3)
