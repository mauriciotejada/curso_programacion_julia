#=
Title: Introducción a la Programación en Julia, Script 5
Author: Mauricio M. Tejada
Institution: Departamento de Economía, Universidad Alberto Hurtado
Date: Julio 2021
Language Version: 1.6.1 
=#

# Leer y escribir archivos delimitados csv
using DelimitedFiles

datos2 = readdlm("src/scripts/PIBChile.csv", ',')

datos = 10*ones(100,5) + 5*randn(100,5);
writedlm("miarchivo.txt", datos)

datos2 = readdlm("src/scripts/miarchivo.txt", '\t')

# Leer archivo excel
using ExcelReaders
using Statistics
using Plots

# Nos aseguramos de estar en el directorio de trabajo correcto.
cd("/Users/mauriciotejada/Dropbox/Teaching/MAE - Julia/2020/slides/") 

datos = readxl("src/scripts/PIBChile.xlsx", "Datos!A2:B57")

tiempo = datos[:,1]
pib    = datos[:,2];

plt_pib = plot(tiempo,pib, xlabel="Año", ylabel="Miles de Millones de Pesos Encadenados", title = "PIB Real de Chile", 
               color="blue", legend=false, linewidth = 2, grid = true)
display(plt_pib)

T = length(pib)
g = ((pib[2:T,1] - pib[1:T-1,1])./pib[1:T-1,1])*100;

plt_gpib = plot(tiempo[2:T],g, xlabel="Año", ylabel="Porcentaje", 
                title = "Crecimiento del PIB Real de Chile", color="blue", legend=false, 
                linewidth = 2, grid = true)
display(plt_gpib)

crecprom = mean(g)

# Archivos JLD (diccionario)
using JLD

t = 15
z = [1,3]
save("miarchivo.jld", "t", t, "z", z)

d = load("miarchivo.jld")

# Recuperamos el objeto original
z = d["z"]
