#=
Title: Introducción a la Programación en Julia, Script 8
Author: Mauricio M. Tejada
Institution: Departamento de Economía, Universidad Alberto Hurtado
Date: Julio 2021
Language Version: 1.6.1 
=#

# Solución de Ecuaciones No Lineales

# Método de Bisección
"""
**bisection** implementa el Método de Bisección

Uso: `root = bisect(f,a,b)`
"""
function bisect(f,a,b)

    if f(a)*f(b)>0 
        error("La función debe ser de signo distinto en los extremos")
    else
        tol = 1.5e-8;

        s = sign(f(a))
        x = (a+b)/2
        d = (b-a)/2

        while d>tol
            d = d/2
            if s == sign(f(x))
                x = x+d
            else
                x = x-d
            end
        end
        root = x
    end

return root
    
end

function ff(x)
    return x^3-2
end

x = bisect(ff,1,2)

# Método de Punto Fijo
using LinearAlgebra

"""
**fixpoint** implementa el Método de Iteración de la Función

Uso: `[x, gval] = fixpoint(f,x0)`
"""

function fixpoint(g,x0)
    
    tol     = 1.5e-8
    maxiter = 1000    

    x = x0
    iter = 0

    for i in 1:maxiter 
       iter = i
       gval = g(x)
       if norm(gval-x)<tol
           return x, gval
       end 
       x = gval;
    end

    if iter == maxiter
        println("No se obtuvo convergencia")
    end

end

gg(x) = x^0.5

(xstar, gx) = fixpoint(gg,4)
println(xstar)
println(gx)

# Método de Newton
"""
**newton** implementa el Método de Newton
    
Uso: `x = newton(f,x0)`
"""

function newton(f,x0; tol = 1.5e-8, maxiter = 1000)       

    x = x0
    iter = 0

    for i in 1:maxiter
        iter = i
        (fval, fjac) = f(x)
        x = x - fjac\fval
        if norm(fval) < tol
            break
        end
    end

    if iter == maxiter
        println("No se obtuvo convergencia")
    end

    return x
end

function ff2(x)

    fval = x^3-2
    fjac = 3*x^2
    
    return fval, fjac

end

x = newton(ff2,1)

# Método de la Secante
"""
**secante** implementa el Método de la Secante

Uso: `x = secante(f,x0)`
"""

function secante(f,x0; tol = 1.5e-8, maxiter = 1000)
  
    x1 = 0.5*x0
    iter = 0    

    for i in 1:maxiter
        iter = i    
        fval0 = f(x0)
        fval1 = f(x1)
        x = x1 - ((x1-x0)/(fval1-fval0))*fval1
        if abs(fval1) < tol
            break
        end
        x0 = x1
        x1 = x
    end

    if iter == maxiter
        println("No se obtuvo convergencia")
    end

    return x
end

function ff(x)
    return x^3-2
end

xsol = secante(ff,1)


# El paqeute Roots
using Roots
using Plots

f(x) = exp(x) - x^4

x = collect(1:0.1:3)
y = f.(x)
yz = zeros(length(x))
plot(x,[y, yz], ylabel = "f(x)", xlabel = "x", legend=:none)

xsol = fzero(f,1,3) # Usamos Bisección

f(xsol)

x = collect(-10:0.1:10)
y = f.(x)
yz = zeros(length(x))
plot(x,[y, yz], ylabel = "f(x)", xlabel = "x", legend=:none)

xm = fzeros(f, -10, 10)

f.(xm)

# El paquete NLsolve
using NLsolve

function sistemanl(x)

    f = zeros(length(x))

    f[1] = exp(-exp(-x[1]+x[2])) - x[2]*(1+x[1]^2)
    f[2] = x[1]*cos(x[2]) + x[2]*sin(x[1]) - 0.5
    
    return f

end

xss = nlsolve(sistemanl, [0.5, 0.5], inplace = false)

xss.zero # Vector con el resultado

function sistema2(x)

    f = zeros(length(x))

    f[1] = (x[1]+3)*(x[2]^3-7)+18
    f[2] = sin(x[2]*exp(x[1])-1)
    
    return f
end

xss = nlsolve(sistema2, [0.1, 1.2], inplace = false);

xss.zero

function jacob_sistema2(x)
    
    J = zeros(2,2)

    J[1, 1] = x[2]^3-7
    J[1, 2] = 3*x[2]^2*(x[1]+3)
    u = exp(x[1])*cos(x[2]*exp(x[1])-1)
    J[2, 1] = x[2]*u
    J[2, 2] = u
    
    return J
end

xss = nlsolve(sistema2, jacob_sistema2, [0.1, 1.2], inplace = false);

xss.zero
