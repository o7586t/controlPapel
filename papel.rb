#encoding: UTF-8

=begin rdoc
Programa para contar el papel.
Tengo que crear dos arrays diferentes, uno para el sotano -1 y el otro para el sotano -2.
También tendré un Hash para el total que será el que calcule con los datos ya obtenidos.

Esta es la primera clase que diseño en ruby, y gestiona la cantidad de papel que tenemos
almacenada para su uso.
=end

class Sotano
	def initialize
		@tamsot1 = 5 # Tamaños de los arrays.
		@tamsot2 = 13 # Este tamaño podrá cambiar dependiendo de la cantidad de pales que tengamos almacenados.
		@tipo = nil
		@cantidad = nil
                 # ------------------------
		@sot1 = Array.new
		@sot2 = Array.new
                 #En este array dejaremos el total final para grabarlo en un fichero. En teoría debería ser un Hash.
		@cantidadTotal = Array.new
		@tiposPapel = ['DINA4', 'MOD1', 'MOD2', 'MOD3', 'MOD4']
		@hash1 = {}
  	end

  def verArray
    #
    # Voy a hacer un bucle para sacar todos los elementos del array. En esta versión aparece ordenado
    # por la pantalla aunque realmente en el array no este ordenado de verdad.
    #
    mirar1 = @sot1.sort
    puts ""
    #
    # Y ahora voy a ponerlo para que salga por la pantalla en bonito.
    #

    puts
    printf("+------------------------------------------------------+\n")
    printf("|         |  DINA4 |  MOD1  |  MOD2  |  MOD3  |  MOD4  |\n")
    printf("+------------------------------------------------------+\n")
    printf("+------------------------------------------------------+\n")

    print("|SOTANO -1|")
    for i in mirar1
      printf("%8s", i[1]); print("|")
    end

    puts
    printf("+------------------------------------------------------+\n")

    print("|SOTANO -2|")
    for i in mirar1
      printf("%8s", i[1]); print("|")
    end

    puts
    printf("+------------------------------------------------------+\n")
  end

  def plantillaBonita #Esto es mentira, es sólo para sacar por pantalla.
    printf("+------------------------------------------------------+\n")
    printf("|         |  DINA4 |  MOD1  |  MOD2  |  MOD3  |  MOD4  |\n")
    printf("+------------------------------------------------------+\n")
    printf("+------------------------------------------------------+\n")
    printf("|SOTANO -1|      0 |      0 |      0 |      0 |      0 |\n")
    printf("+------------------------------------------------------+\n")
    printf("|SOTANO -2|      0 |      0 |      0 |      0 |      0 |\n")
    printf("+------------------------------------------------------+\n")
  end

  # En este bucle voy a ir metiendo datos a los arrays creados en 'initialize'.
  def bucle
    print "Para salir introduce 'n'. ¿Continuar s/n? Txmt. "
    puts " "
    while mod = gets.chomp != 'n' do
      ###########################
      # Esto para quitar.
      ###########################
      puts "El tamaño del array sot1 es de = #{@sot1.size} y el tamaño máximo es de: #{@tamsot1}"
      print "Introduce el modelo de papel: "
      ###########################
      STDOUT.flush
      mod = gets.chomp.upcase
      print "Introduce la cantidad de papel: "
      # CUIDADO. Si meto aquí 205wert, el programa acepta los primeros caracteres 
      # que forman una cifra, es decir, la variable 'cant' carga el valor de 205 
      # y se queda tan tranquilo..
      STDOUT.flush
      cant = gets.chomp.to_i # Lo convierto a numero.

=begin
Lanzar la cantidad a una función que devuelva true o false si está por debajo
de cero o encima de 999999. O sea cantidad negativa o superior al millón de
unidades.
if cantidad == false
  break con mensaje de error diciendolo.
=end

      if ((comprobacionPapel(mod) == true)&(comprobacionCantidad(cant) == true))
        puts "Yupiii, el dato introducido es acorde a las especificaciones."
      else
        puts "¡CUIDADO! Ha habido un error, mete otra vez el dato. Presiona Enter otra vez."
        next
      end

      #
      # Meter las variables (modelo, cantidad) al array.
      # Comprobar si el contenido de las variables es válido. Y si la
      # longitud del array es el adecuado.
      #

      #
      # Comprobar también el orden en el que está el tipo de papel y en 
      # consonancia colocarlo en el array final.
      #
      ord = orden(mod)
      puts 'El orden en el array del string introducido; modelo = ' + mod + ' es: ' + ord.to_s

      # @sot1.push([mod,cant])
      # @sot1.push([[mod],[cant]])
      # @sot1.insert(ord,[mod,cant])

      @sot1.push([mod, cant])
      mirar = @sot1.sort

      #@hash[mod] = cant

      #
      # Voy a hacer un bucle para sacar todos los elementos del array.
      #
      cont1 = 0
      mirar.each do |i|
        puts "Los elementos del array 1 son: Array[#{cont1}] <= #{i}"
        cont1 += 1
      end
      puts "Para salir introduce 'n'. ¿Continuar s/n?"
      puts " "
    end
  end

=begin
Este método servirá para ver si se han introducido bien los datos. En el caso de que no lo sea, se pedirá nuevos datos.

Meter en un array los strings 'MOD1', 'MOD2', etc y compararlos con lo que se pase.
Aquí comprobar de que los datos introducidos sean correctos.
comprobar = ["MOD1", "MOD2" , "MOD3" , "MOD4" , "DINA4"]
cantidad.to_i > 0 y < 500000, Por ejemplo.
Además de que esté bién escrito, que no se repita el nombre de los datos.

Parece ser que la mejor idea es que sean símbolos para que sean únicos.
=end

  def comprobacionPapel(tPapel)
=begin
En el comienzo tenemos las variables y las constantes.
=end
    estar=false
    # Iteracion que recorre el array.
    for tipo in @tiposPapel
      if (tPapel == tipo)
        estar=true
        #ielse
        #      estar=false
      end
    end
    return estar
  end

  def comprobacionCantidad(cantidad)
    cifra=true
    if ((cantidad < 0) or (cantidad > 999999)) then
      puts "La cifra introducida es incorrecta"
      cifra=false
    end
    return cifra
  end

  def orden(modelo) 
    puts "modelo" 
	 numero = @tiposPapel.index(modelo) 
    puts "El índice numérico del array del tipo de modelo " + modelo + " es: " + numero.to_s 
    return numero 
  end

  def grabar fichero

  end

  def fecha
    @fecha = Time.now.strftime('%Y-%m-%d')
  end

  def semana
    @semana = Time.now.strftime("%W").to_i + 1
  end
end

################################################################################
##
## Comienzo del programa
##
#################################################################################

sotanos = Sotano.new

puts ""
puts "APLICACIÓN PARA EL CONTROL DEL PAPEL EN EL ALMACEN"
puts "=================================================="
puts ""
sotanos.plantillaBonita
puts ""
sotanos.bucle # Introducir los datos por teclado.
puts ""
puts "En la semana nº: #{sotanos.semana} del año, en la fecha: #{sotanos.fecha}, tenemos la cantidad de PAPEL:"
puts sotanos.verArray
puts ""
#system('dir')
