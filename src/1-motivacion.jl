#=
Title: Introducción a la Programación en Julia, Script 1
Author: Mauricio M. Tejada
Institution: Departamento de Economía, Universidad Alberto Hurtado
Date: Julio 2021
Language Version: 1.6.1 
=#

# Precio
p = 2.0^-5

# Precio dada la cantidad
p = 0.25
for i in 1:100
  global p
  deltap = (.5*p^-.2+.5*p^-.5-2)/(.1*p^-1.2 + .25*p^-1.5)
  p = p + deltap
  if abs(deltap) < 1.e-8
        break
  end
end 
println(p)

# Demanda
q = collect(0.5:0.1:2.2)
P = zeros(length(q))
for j=1:length(q)
    global p, q  
    p = 0.25
    for i=1:100
        deltap = (.5*p^-.2+.5*p^-.5-q[j])/(.1*p^-1.2 + .25*p^-1.5)
        p = p + deltap
        if abs(deltap) < 1.e-8
            break
        end
    end 
    P[j] = p
end;

M = [q P]

# Gráficamente
using Plots

plt = plot(q,P, xlabel="Cantidad", ylabel="Precio", color="red", legend=false, linewidth = 2)
display(plt)

# Usando interpolación para calcular el precio dada una cantidad que no está en la tabla de demanda
using Interpolations

Pint = LinearInterpolation(q, P);
Pint(1.55)
