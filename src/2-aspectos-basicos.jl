#=
Title: Introducción a la Programación en Julia, Script 2
Author: Mauricio M. Tejada
Institution: Departamento de Economía, Universidad Alberto Hurtado
Date: Julio 2021
Language Version: 1.6.1 
=#

# Directorio de trabajo
pwd()

# Manejo de paquetes
using Pkg
Pkg.status()

# Tipos de variables
x = 2.5
typeof(x) # función que muestra el tipo de la variable

y = 4
typeof(y)

variable_imaginaria = 2.0 + 5.0im
typeof(variable_imaginaria)

α = 0.4
typeof(α)

Y_1 = "Texto"
typeof(Y_1)

var_texto = "Pueden incluirse Espacios"

var_texto_muy_largo = """
Esto es un texto muy largo incluido en una
variable. El texto tiene varias lineas.
"""

var_bool = true
typeof(var_bool)

var_car = 'a'
typeof(var_car)

# Mostrar variables en memoria
varinfo()

# Aritmética básica +,-,*,/,%,^
x = 2.4
y = 5
z_sum = x + y

typeof(z_sum)

z_pro = x*y

z_pot = x^y

x = 5
y = 2
z_mod = y % x

# Concatenar texto
a = "hola amigo "
b = "Jon Snow"
z = a * b

# Tuples (inmutables)
xtup = (1, 2, 3, "texto")

xtup[4]

# xtup[2] = 8

# Diccionarios
notas = Dict("Javier" => 6.5, "Camila" => 6.8, "Ernesto" => "No Rindio el Examen")

notas["Camila"]

notas["Ernesto"] = 7.0

notas

notas["Paola"] = 6.5

notas

pop!(notas, "Javier")

notas

# Arreglos

lista_nombres = ["Javier", "Camila", "Ernesto", "Paola"]

secuencia_numeros = [3.8, 4.0, 2.5, 6.8, 9.0]

arreglo_mexclado = [3.8, 4.0, 2.5, 6.8, "texto"]

secuencia_numeros[4]

secuencia_numeros[4] = 4.0

secuencia_numeros

fibonacci = [1, 1, 2, 3, 5, 8, 13]

push!(fibonacci, 21)

pop!(fibonacci)

fibonacci

arreglos_compuestos = [[3, 4, 1], [2, 1], 3, [6, 7, 8, 9, 11]]

arreglo_vacio = []

# Manejo de memoria y objetos enmascarados
x = [3, 4, 5]

y = x

y[3] = 100

x

z = copy(x)

z[3] = 1000

x

# imprimir resultados en pantalla
NombreLargo = 4.5
println(NombreLargo)
println(Y_1);
println("*** Otra forma ***") # Note que esta es una variable de texto definida directamente para 
println("---------")                              

x = 2
y = "$x es par"

prof_name = "Mauricio Tejada"
prof_of = 211
prof_email = "matejada@uahurtado.cl"

println("Mi nombre es $prof_name") 
println("Mi oficina es la $prof_of y mi email es $prof_email")

# Graficos
using Plots

x = collect(0:pi/100:2*pi)
y = sin.(x)

plt_sin = plot(x,y, xlabel="x", ylabel="f(x)", title = "Función Seno", 
               color="blue", legend=false, linewidth = 2, grid = true)
display(plt_sin)

x = range(-2*pi, stop = 2*pi, length = 50)
y1 = sin.(x)
y2 = cos.(x)

plt_sincos = plot(x,[y1 y2], xlabel="x", ylabel="f(x)", title = "Función Seno y Coseno", 
                  color=["blue" "red"], label=["sin(x)" "cos(x)"], legend = true, 
                  linewidth = 2, grid = true)
display(plt_sincos)

x = range(-2*pi, stop = 2*pi, length = 50)
y1 = sin.(x)
y2 = cos.(x)

plt_sincos = plot(x,[y1 y2], xlabel="x", ylabel="f(x)", title = "Función Seno y Coseno", 
                  color=[:blue :red], label=["sin(x)" "cos(x)"], legend = true, 
                  linewidth = 2, shape = [:circle :diamond], line = [:dot :dash],
                  grid = true)
display(plt_sincos)

savefig(plt_sincos, "mytestplot.pdf")
