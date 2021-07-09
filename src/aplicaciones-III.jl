#=
Title: Introducción a la Programación en Julia, Aplicaciones III
Author: Mauricio M. Tejada
Institution: Departamento de Economía, Universidad Alberto Hurtado
Date: Julio 2021
Language Version: 1.6.1 
=#

# Aplicación: Aproximación lineal de una función no lineal
fxy(x) = x[1]*exp(-x[1]^2-x[2]^2)

using Calculus
using Plots
pyplot()

fc = fxy([1, 1])
df = Calculus.gradient(fxy,[1, 1])
dfx = df[1]
dfy = df[2]

fxyaprox(x) = fc - dfx - dfy + dfx*x[1] + dfy*x[2]

x=[1.1, 1.1]
fo = fxy(x)
fa = fxyaprox(x)
println("Función Original: $fo")
println("Función Aproximada: $fa")

x = collect(range(0.5, stop = 1.5, step = 0.1))
n = length(x)

forig = zeros(n,n)
faprox = zeros(n,n)
X = zeros(n,n)

for i in 1:n, j in 1:n
    forig[i,j] = fxy([x[i], x[j]])
    faprox[i,j] = fxyaprox([x[i], x[j]])
    X[i,j] = x[j]
end

plot(x, x, forig, st=:surface, legend=false, color=cgrad([:red,:blue]), grid = true)

plot(x, x, faprox, st=:surface, legend=false, color=cgrad([:red,:blue]), grid = true)

# Aplicación: Cálculo de la Esperanza Matemática
using QuadGK

function integrando(x,mu,sigma)

    fx = (1/(sigma*sqrt(2*π)))*exp(-(x-mu)^2/(2*sigma^2))
    return x*fx

end

Ex = quadgk(x->integrando(x,3,2),-Inf,Inf)[1]

using Distributions

function integrando2(x,mu,sigma)

    d = Normal(mu, sigma)
    return x*pdf(d,x)

end

Ex = quadgk(x->integrando2(x,3,2),-Inf,Inf)[1]

d = Normal(3, 2)
mean(d)

# Aplicación: Duopolio de Cournot
function cournot(q,c,eta)

    neq = length(q)
    fval = zeros(neq,1)

    q1 = q[1]
    q2 = q[2]

    c1 = c[1]
    c2 = c[2]

    fval[1] = (q1+q2)^(-1/eta) - (1/eta)*((q1+q2)^(-(1/eta)-1))*q1 - c1*q1
    fval[2] = (q1+q2)^(-1/eta) - (1/eta)*((q1+q2)^(-(1/eta)-1))*q2 - c2*q2
    
    return fval

end

c = [0.6, 0.6]
eta = 1.2;

using NLsolve

q0 = [0.2, 0.2]
sol_cournot = nlsolve(x -> cournot(x,c,eta), q0, inplace = false);

qstar = sol_cournot.zero

# Aplicación: Estimación por el Método de Máximo Verosimilitud
using DelimitedFiles
using Distributions
using Optim

impdata = readdlm("src/DatosMCO.txt", ',')
N, K = size(impdata)
y = impdata[:,1]
X1 = impdata[:,2]
X2 = impdata[:,3]

X = [X1 X2]

function loglike(par,y,X)

    beta0 = par[1]
    beta1 = par[2]
    beta2 = par[3]
    sig   = exp(par[4])

    N = length(y)

    L = zeros(N)
    
    d = Normal(0,sig)

    for i in 1:N
        ui = y[i] - beta0 - beta1*X[i,1] - beta2*X[i,2]
        L[i] = pdf(d,ui)
    end
    # L = [pdf(d, y[i] - beta0 - beta1*X[i,1] - beta2*X[i,2]) for i in 1:N]    # Alternativa

    return -sum(log.(L))

end

par0 = [2, 0.1, 0.1, log(2)]
res_mv = optimize(x -> loglike(x,y,X), par0, LBFGS());

params = res_mv.minimizer

sig = exp(params[4])

# Aplicación: El Problema del Consumidor
using JuMP
using Ipopt

modelo_consumidor = Model(Ipopt.Optimizer);

alpha = [0.2, 0.4, 0.1, 0.3]
p = [2, 3, 4, 5]
m = 100;

@variable(modelo_consumidor, 0 <= x[1:4])

@constraint(modelo_consumidor, sum(x.*p) <= m)

# Note que definimos la función de utilidad como negativa para maximizar.
@NLobjective(modelo_consumidor, Min, -(x[1]^alpha[1] + x[2]^alpha[2] + x[3]^alpha[3] + x[4]^alpha[4])); 

print(modelo_consumidor)

optimize!(modelo_consumidor);

xstar = [JuMP.value(x[i]) for i in 1:4]
xstar

sum(p.*xstar)
