#=
Title: Introducción a la Programación en Julia, Aplicaciones II
Author: Mauricio M. Tejada
Institution: Departamento de Economía, Universidad Alberto Hurtado
Date: Julio 2021
Language Version: 1.6.1 
=#

# Aplicación: Stock de Capital de Chile
using ExcelReaders
using Plots

datos = readxl("src/FBKFChile.xlsx", "Datos!A2:B57")

tiempo = datos[:,1]
inversion = datos[:,2]

plt_inv = plot(tiempo,inversion, xlabel="Año", ylabel="Miles de Millones de Pesos Encadenados", 
               title = "Chile: Formación Bruta de Capital Fijo", 
               color="red", legend=false, linewidth = 2, grid = true)
display(plt_inv)

T = length(inversion)

K = zeros(T,1)
K[1] = 30201645    # Capital Inicial
delta = 0.05

for i=2:T
    K[i] = K[i-1] - delta*K[i-1] + inversion[i-1]
end

plt_cap = plot(tiempo,K, xlabel="Año", ylabel="Miles de Millones de Pesos Encadenados", 
               title = "Chile: Stock de Capital", 
               color="blue", legend=false, linewidth = 2, grid = true)
display(plt_cap)

# Shocks y ciclos económicos
T    = 100
y    = zeros(T)
epsilon  = zeros(T)
phi  = 0.9
prob = 0.5
y[1] = 0;

for t=2:T
    if rand()<=prob 
        epsilon[t] = 1.0
    else
        epsilon[t] = -1.0
    end
    y[t] = phi*y[t-1]+epsilon[t]
end

plot(collect(1:T), y, color="blue", legend=false, linewidth = 2, grid = true)

y   = zeros(T)
epsilon = zeros(T)

for t=2:T 
    a=rand();
    if a<=0.25
        epsilon[t] = 1.0
    elseif a<=0.5 
        epsilon[t] = 0.5
    elseif a<=0.75 
        epsilon[t] = -0.5
    else
        epsilon[t] = -1.0
    end
    y[t] = phi*y[t-1]+epsilon[t]
end

plot(collect(1:T), y, color="blue", legend=false, linewidth = 2, grid = true)

y   = zeros(T)
epsilon = zeros(T)

for t=2:T 
    epsilon[t]=0+2*randn()
    y[t] = phi*y[t-1]+epsilon[t]
end

plot(collect(1:T), y, color="blue", legend=false, linewidth = 2, grid = true)

# Equilbirio de dos mercados
function equilibrio(param,t)

    # Calcula el equilibrio de mercado dados los parámetros del modelo
    a = param[1];
    b = param[2];
    c = param[3];
    d = param[4];

    # Equilibrio
    q  = (a-(c+t))/(b+d);
    pc = (a*d+b*(c+t))/(b+d);
    pv = (d*(a-t)+c*b)/(b+d);
    qstar = (a-c)/(b+d); 

    #Excedentes
    EE = t*q;
    EC = ((a-pc)*q)/2;
    EP = ((pv-c)*q)/2;
    PIE = (t*(qstar-q))/2; 
    ET = EC + EP + EE; 

    # Resultados
    return q, pc, pv, EE, EC,EP, PIE, ET 
end

a = 10.0
b = 0.1
c = 2.0
d = 0.5

p = [a, b, c, d]

res_si = equilibrio(p,0);

"La cantidad de equilibrio es $(res_si[1])" # Cantidad

"El precio de equilibrio es $(res_si[2])" # Precio

res_ci = equilibrio(p,1);

"El equilibrio con impuesto es: cantidad = $(res_ci[1]) y precio = $(res_ci[2])"

inc = 0.1

t = 0
q = 1

Imp = Float64[]  # Inicializa un objeto vacío tipo Float64
Rec = Float64[]  # Inicializa un objeto vacío tipo Float64

while q>=0
    global t, q, Rec, Imp
    res = equilibrio(p,t)
    q   = res[1]
    Rec  = push!(Rec, res[4])
    Imp  = push!(Imp, t)
    t = t+inc
end

plt_laffer = plot(Imp,Rec, xlabel="Impuesto", ylabel="Recaudación Fiscal", 
               title = "Curva de Laffer",  color="blue", legend=false, linewidth = 2, grid = true)

# Distintas elasticidades               
a = 10
b = 0.1
c = [2, -10]
d = [0.5, 1.4]

inc = 0.1

np = length(d)
T  = 200

Imp = zeros(T,np)
Rec = zeros(T,np)
    
for j = 1:np
    p = [a, b, c[j], d[j]]
    
    t = 0.0

    for i=1:T
        res = equilibrio(p,t)
        q   = res[1]
        if q>=0
            Rec[i,j] = res[4]
            Imp[i,j] = t
        else
            Rec[i,j] = 0
            Imp[i,j] = t
        end
        t = t+inc
    end
end

plot(Imp[:,1],Rec[:,1], label = "Oferta Inelástica", xlabel="Impuesto", ylabel="Recaudación Fiscal", 
               title = "Curva de Laffer",  color="blue", linewidth = 2, grid = true)
plot!(Imp[:,2],Rec[:,2], label = "Oferta Elástica", color="red", linewidth = 2)


of1(x) = c[1] + d[1]*x
of2(x) = c[2] + d[2]*x

x = collect(0:0.1:25)

po1 = of1.(x)
po2 = of2.(x);

plot(x,[po1 po2], xlabel="Cantidad", ylabel="Precio", title = "Curva de Oferta", 
                  color=[:blue :red], label=["Oferta Elástica" "Oferta Inelástica"], legend = true, 
                  linewidth = 2, grid = true)

# Aplicación: El Modelo de la telaraña
a = 10
b = 0.6
c = 2
d = 1.6

alpha = 0.08
T = 40
init = 0.5
pstar = (a*d + c*b)/(b+d)
println("Precio de Equilibrio: $pstar")
println("Ajuste: $(alpha*(d+b)/(d*b))")

p    = zeros(T);
p[1] = init*pstar;

for i = 2:T
    p[i] = p[i-1] + alpha*((d+b)/(d*b))*(pstar-p[i-1])
end

plot(collect(1:T),p, color=[:blue], legend = false, linewidth = 2, grid = true)

alpha = 0.8

println("Precio de Equilibrio: $pstar")
println("Ajuste: $(alpha*(d+b)/(d*b))")

p    = zeros(T)
p[1] = init*pstar

for i = 2:T
    p[i] = p[i-1] + alpha*((d+b)/(d*b))*(pstar-p[i-1])
end

plot(collect(1:T),p, color=[:blue], legend = false, linewidth = 2, grid = true)

alpha = 0.9

println("Precio de Equilibrio: $pstar")
println("Ajuste: $(alpha*(d+b)/(d*b))")

p    = zeros(T)
p[1] = init*pstar

for i = 2:T
    p[i] = p[i-1] + alpha*((d+b)/(d*b))*(pstar-p[i-1])
end

plot(collect(1:T),p, color=[:blue], legend = false, linewidth = 2, grid = true)
