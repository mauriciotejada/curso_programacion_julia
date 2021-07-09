#=
Title: Introducción a la Programación en Julia, Script 7
Author: Mauricio M. Tejada
Institution: Departamento de Economía, Universidad Alberto Hurtado
Date: Julio 2021
Language Version: 1.6.1 
=#

# Derivadas numéricas
function primera_derivada(fun,x)
    
    h = (eps()^(1/3))*max(abs(x), 1.0)
    
    return (fun(x+h)-fun(x-h))/(2*h)
end

f(x) = x^2
primera_derivada(f,2)

derf(x) = 2*x
derf(2)

function gradiente(fun,x)
    
    nv = length(x)
    h = (eps()^(1/3))*max.(abs.(x), 1.0)

    xh1 = x+h
    xh0 = x-h
    hh  = xh1 - xh0  # 2h
    
    fderiv = zeros(nv)

    if nv == 1
        f1 = fun(xh1)
        f0 = fun(xh0)
        fderiv = (f1-f0)/hh
    else
        for j=1:nv
            xx = copy(x)
            xx[j] = xh1[j]
            f1 = fun(xx)
            xx[j] = xh0[j]
            f0 = fun(xx)
            fderiv[j] = (f1-f0)/hh[j]
        end
    end
    
    return fderiv
end

# Definimos la funcion
fx(x) = 2*x^2 + x - 1

# Aplicamos la función gradiente (nota que pasamos una función como argumento)
derv = gradiente(fx,2.0)

fxy(x) = 2*x[1]^2+2*x[2]^2+x[1]*x[2]-1

x = [3.0; 2.0]
dervxy = gradiente(fxy,x)

# Definimos la funcion
fxyz(x) = x[1]*x[2]*x[3] + 2*x[1]*x[2] + 2*x[2]*x[3] + x[1] + x[2] + x[3] 

# Aplicamos la función fgrad
x0 = [1.0; 1.0; 1.0]
derivxyz = gradiente(fxyz,x0)

# El paquete Calculus
using Calculus

dx = derivative(fx, 2.0)

d2x = second_derivative(fx, 2.0)

dx = derivative(fx)

dx(2.0)

dfxy = Calculus.gradient(fxy,[3.0, 2.0])

d2fxy = Calculus.hessian(fxy,[3.0, 2.0])

dfxyz = Calculus.gradient(fxyz,[1.0, 1.0, 1.0])

d2fxyz = Calculus.hessian(fxyz,[1.0, 1.0, 1.0])

# El paquete ForwardDiff
using ForwardDiff

fxy(x) = 2*x[1]^2+2*x[2]^2+x[1]*x[2]-1

ForwardDiff.gradient(fxy,[3.0; 2.0])

ForwardDiff.hessian(fxy,[3.0; 2.0])

function sistema(var)

    f = similar(var)

    x = var[1]
    y = var[2]

    f[1] = x^2 + y^2 - 2
    f[2] = x*y

    return f    
end

ForwardDiff.jacobian(sistema,[2.0,2.0])

# Integración numérica
function integral_trapezoide(fun,x,n)
   
    a = x[1]
    b = x[2]
    
    h = (b-a)/n
    i = collect(range(0,stop=n,length=n+1))
    x = a*ones(n+1) + i*h
    
    y = map(fun, x)
    
    return 0.5 * h * (2 * sum(y[2:length(y)-1])+y[1]+y[length(y)])
end

f(x)=2*x
int_res = integral_trapezoide(f,[0,1],10)

using LinearAlgebra

function integral_simpson(fun,x,n)
   
    a = x[1]
    b = x[2]
    
    h = (b-a)/n
    i = collect(range(0,stop=n,length=n+1))
    x = a*ones(n+1) + i*h
    
    y = map(fun, x)
    
    return h/3 * (2.0 * dot((ones(length(y)-2)+rem.(1:length(y)-2,2)),(y[2:(length(y)-1)])) +y[1]+y[length(y)])
end

f(x)=2*x
int_res = integral_simpson(f,[0,1],10)

# El paquete QuadGK
using QuadGK

f(x) = 2*x
int_res, err_res = quadgk(f, 0.0, 1.0)

ff(x) = x*exp(-x^2)
int_res, err_res = quadgk(ff, -Inf, Inf)

# El paquete Cubature
using Cubature

f(x) = 2*x
int, err = hquadrature(f, 0.0, 1.0)

funxy(x) =  x[1]^3*x[2]

intm, errm = hcubature(funxy, [0,0],[1,1])
