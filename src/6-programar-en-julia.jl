#=
Title: Introducción a la Programación en Julia, Script 6
Author: Mauricio M. Tejada
Institution: Departamento de Economía, Universidad Alberto Hurtado
Date: Julio 2021
Language Version: 1.6.1 
=#

# Funciones 
"""
**fx** Evalúa un polinomio de segundo grado. Función aplica sólo a escalares.

##### Uso:

```julia
val = fx(x)
```
"""
function fx(x)    
    return 2*x^2 + 3*x - 5
end

f2 = fx(4)

# Aplicar una función elemento por elemento .()
x = rand(4,1)
y = fx.(x)

# Función para calcular lal media y la varianza de un vector
"""
**stat** Calcula la media y la desviación estándar de un vector x.

##### Uso:

```julia
mean, stdev = stat(x) 
```
"""
function stat(x)

    n     = length(x)
    mean  = sum(x)/n
    stdev = sqrt(sum(x.^2)/n - mean^2)   # Nota: elevamos al cuadrado cada elemento del vector (.^)
    
    return mean, stdev

end

xvec = 50*ones(100,1)+4*randn(100,1)

media, desv = stat(xvec)

# Declarar funciones simples
fx2(x) = 2*x^2 + 3*x - 5
fx2(5)

# Funciones anónimas
fx3 = x -> 2*x^2 + 3*x - 5
fx3(5)

"""
**fx* Evalúa un polinomio de segundo grado.

Uso:     
```julia
val = fxalt(x,params)
```

params: vector 3 x 1 de parámetros.
"""
function fxalt(x,param)

    a = param[1]
    b = param[2]
    c = param[3]

    return a*x^2 + b*x + c

end

pa = 3.0
pb = 3.0
pc = -5.0

p = [pa, pb, pc]
x = 4.0

val = fxalt(x,p)
println(val)

pa = 2.0
pb = 3.0
pc = -5.0

p = [pa, pb, pc]

fx4 = x -> fxalt(x,p)  # fijamos p = [2, 3, -5]

fx4(4.0)

# Loop (bucles) for
n = 8
x = rand(n)
sumx = zeros(n)

sumx[1]= x[1] 

for i = 2:n
    sumx[i] = sumx[i-1]+x[i]
end

println(sumx)

# Loops e iterables
iterable = 2:n

typeof(iterable)

clase = ["Macro", "Micro", "Econometría"]
for i in clase
    println("La Materia es: $i")
end

# Loops en forma compácta
x = [3.0, 6.0, 9.0, 8.0, 3.0]
sqrx = [i^2 for i in x]

# La función map
funsqr(x) = x^2
sqrx2 = map(funsqr,x)

sqrx2 = map(y -> y^2,x)

# Loop while
delta = 1
println(delta)
while delta > 0.05
    global delta
    delta = delta/2
    println(delta)
end

# Loops anidados
m = 3
n = 2
H = zeros(m,n)

for i = 1:m
    for j = 1:n 
        H[i, j] = 1/(i+j-1)
    end
end

H

# Alternativa
H2 = zeros(m,n)

for i in 1:m, j in 1:n 
    H2[i, j] = 1/(i+j-1)
end

H2

mult = [1/(i+j-1) for i in 1:m, j in 1:n]

iter = 1

while iter < 5 
    global iter
    println(iter)
    iter += 1   # esto es equivalente a iter = iter + 1
end

# Condicionales
A = randn()
println(A)
if A>0
    println("A es positivo")
elseif A==0
    println("A es cero")
else
    println("A es negativo")
end

n = 0

if -5 > 0 
    n = 1
elseif -1 > 0 
    n = 2
elseif 3 > 0
    n = 3 
else
    n = 4
end

println(n)

# Elementos de una matriz usando condicionales
 A = [1, 4, 7, 2, 8, 5, 2, 7, 9]
 B = [2, 5, 1, 4, 8, 0, 3, 4, 3]
 
 dummy = A.>B

F = [A B]

subF1 = F[A.>B,:] # Alternativa 1

subF2 = F[F[:,1].>F[:,2],:] # Alternativa 2
