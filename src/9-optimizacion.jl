#=
Title: Introducción a la Programación en Julia, Script 9
Author: Mauricio M. Tejada
Institution: Departamento de Economía, Universidad Alberto Hurtado
Date: Julio 2021
Language Version: 1.6.1 
=#

# Optimización

# El paquete Optim
using Optim

funx(x) = 3*x[1]^2 + 2*x[1]*x[2] + x[2]^2 - 4*x[1] + 5*x[2]

x0 = [1.0, 1.0]
res_min = optimize(funx, x0, BFGS());

res_min.minimizer

res_min.minimum

res_min = optimize(funx, x0, BFGS(), autodiff = :forward)
res_min.minimizer

res_min = optimize(funx, x0, NelderMead(), Optim.Options(show_trace = true, iterations = 50));
res_min.minimizer

function gfunx(x)
    g = zeros(2)
    
    g[1] = 6*x[1] + 2*x[2] - 4
    g[2] = 2*x[1] + 2*x[2] + 5
    
    return g
end

function hfunx(x)
    h = zeros(2,2)
    
    h[1,1] = 6
    h[1,2] = 2
    h[2,1] = 2
    h[2,2] = 2
    
    return h
end

res_min = optimize(funx, gfunx, hfunx, x0, Newton(), inplace = false)
res_min.minimizer

FunObj(x) = 1 + x[1]/(1+x[2]) - 3*x[1]*x[2] + x[2]*(1+x[1])

lb = [0.0, 0.0]
ub = [1.0, 2.0];

x0 = [0.5, 1.0]
resultados = optimize(FunObj, lb, ub, x0, Fminbox(LBFGS()))
resultados.minimizer

# El paquete JuMP
using JuMP

# Programación Lineal
using GLPK

mod_ejemplo = Model(GLPK.Optimizer)

@variable(mod_ejemplo, x >= 0.1)
@variable(mod_ejemplo, y >= 0.1)
@constraint(mod_ejemplo, x + y <= 1)
@objective(mod_ejemplo, Min, 2*x + 3*y)

println("El problema de optimización es:")
print(mod_ejemplo)

optimize!(mod_ejemplo)

println("Función Objetivo: ", JuMP.objective_value(mod_ejemplo))
println("x = ", JuMP.value(x)) 
println("y = ", JuMP.value(y))

rentabilidad = [0.01130, 0.02565, 0.00440, 0.00972, 0.01259, 0.00652, 0.00681]
riesgo = [0.07752, 0.06172, 0.10399, 0.08940, 0.06157, 0.09916, 0.06297]
precio = [5.89, 28.03, 11.77, 6.6, 56.05, 70.11, 13.47]
rentabilidadmin = 0 # Rentabilidad mínima
preciomin = 0       # Precio mínimo
n = 7;

portafolio = Model(GLPK.Optimizer);
@variable(portafolio, 0 <= x[1:n] <= 1)
@constraint(portafolio, c1,  sum(x[1:n]) == 1)
@constraint(portafolio, c2,  sum([x[i]*(rentabilidad[i]-rentabilidadmin) for i in 1:n]) >= 0)
@constraint(portafolio, c3,  sum([x[i]*(precio[i]-preciomin) for i in 1:n]) >= 0)
@objective(portafolio, Min, sum([riesgo[i]*x[i] for i in 1:n]))
println("El problema de optimización es:")
print(portafolio)

optimize!(portafolio)

println("Función Objetivo: ", JuMP.objective_value(portafolio))
for i in 1:n
    println("x$i = ", JuMP.value(x[i])) 
end

# Programación No Lineal
using Ipopt

nl_mod_ejemplo = Model(Ipopt.Optimizer);

@variable(nl_mod_ejemplo, x[1:2])

x0 = [0.5, 0]
A = [1, 2]
b = 1
Aeq = [2, 1]
beq = 1

@constraint(nl_mod_ejemplo, ceq, sum(Aeq.*x) == beq)
@constraint(nl_mod_ejemplo, cineq, sum(A.*x) <= b)

@NLobjective(nl_mod_ejemplo, Min, 100*(x[2]-x[1]^2)^2 + (1-x[1])^2)

println("El problema de optimización es:")
print(nl_mod_ejemplo)

optimize!(nl_mod_ejemplo)

println("Función Objetivo: ", JuMP.objective_value(nl_mod_ejemplo))
println("x1 = ", JuMP.value(x[1])) 
println("x2 = ", JuMP.value(x[2])) 
