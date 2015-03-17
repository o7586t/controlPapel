#!/bin/bash

##############################################################################
##############################################################################
## VARIABLES.
##############################################################################
##############################################################################

FECHA=`date +20%y/%m/%d`
FECHAHM=`date +%Y%m%d%H%M`
SEMANA=`date '+%V'`
declare -a TIPOS=(MOD1 MOD2 MOD3 MOD4 DINA4)
declare -a TIPOPAPEL
declare -a CANTIDADPAPEL
FICHERO="./datosPapelOSTIAS.csv"
declare -a TOTAL_SOTANO_002
declare -a TOTAL_SOTANO_001
declare -a TOTAL_CUARTO
declare -a TOTAL_SOTANO		# Variable temporal para cálculos.
declare -a TOTAL_TOTAL

##############################################################################
##############################################################################
# Meter escapes en la pantalla para poner negritas y colores en la consola.
##############################################################################
##############################################################################

esc=""
negrita="${esc}[1m"
q_negrita="${esc}[22m"

##############################################################################
##############################################################################
## CABECERA DE LA APLICACIÓN.
##############################################################################
##############################################################################

cabecera()
{
echo ""
echo "================================================================================================"
echo "================================================================================================"
echo ""
echo "                ${negrita}APLICACIÓN PARA EL CONTROL DEL PAPEL EN EL ALMACÉN.${q_negrita}"
echo ""
diaHoy
echo ""
echo "================================================================================================"
echo "================================================================================================"
}

##############################################################################
##############################################################################
## CABECERA DE LA APLICACIÓN. INFORMACIÓN DEL DÍA DE HOY.
##############################################################################
##############################################################################

diaHoy()
{
echo "${FECHA}, semana nº: ${SEMANA} del año. Tenemos la siguiente cantidad de PAPEL en nuestros almacenes:"
}

##############################################################################
##############################################################################
## INICIALIZAR EL ARRAY PARA LOS DATOS. 
##############################################################################
##############################################################################

inicializarArrayTipos()
{
for i in $(seq 0 27) 
do
  TIPOPAPEL[$i]=" "
done
}

##############################################################################
##############################################################################
## CARGAR LOS ARRAYS CON LOS DATOS ALMACENADOS EN EL FICHERO EXTERNO. 
##############################################################################
##############################################################################

cargarArrayTipos()
{
TIPOPAPEL=( $(cat datosPapelOSTIAS.csv | tail -n 1) )
cambiarIFS    # Para poder leer las dos líneas y cargarlas en un Array
CANTIDADPAPEL=( $(cat datosPapelOSTIAS.csv | tail -n 2) )
volverIFS
}

##############################################################################
##############################################################################
## PARA CARGAR LA INFORMACIÓN SE NECESITA CAMBIAR LA VARIABLE 'IFS'. 
##############################################################################
##############################################################################

cambiarIFS()
{
IFS_old=$IFS
IFS=$'\n'
}

##############################################################################
##############################################################################
## DESPUES SE VUELVE A DEJAR LA VARIABLE 'IFS' COMO ESTABA ANTERIORMENTE.
##############################################################################
##############################################################################

volverIFS()
{
IFS=$IFS_old
}

##############################################################################
##############################################################################
## DESPUES DE LEER LOS DATOS ESTOS SE CARGAN EN LOS ARRAYS PARA TRABAJARLOS.
##############################################################################
##############################################################################

llenarDatosArrays()
{
inicializarArrayTipos
cargarArrayTipos

CANTIDADPAPEL0=( ${CANTIDADPAPEL[0]} )     # Separar el array en dos arrays. Uno de cantidades y el otro de tipo de papeles.

contar 0 13                                # CALCULA LOS SUB-TOTALES DEL SOTANO-2.
TOTAL_SOTANO_002=(${TOTAL_SOTANO[*]})

contar 14 18                               # CALCULA LOS SUB-TOTALES DEL SOTANO-1.
TOTAL_SOTANO_001=(${TOTAL_SOTANO[@]})

contar 19 27                               # CALCULA LOS SUB-TOTALES DEL CUARTO.
TOTAL_CUARTO=(${TOTAL_SOTANO[@]})

contarTOTAL                                # CALCULA EL TOTAL DE TODO.
}

##############################################################################
##############################################################################
## CALCULA LOS SUB-TOTALES QUE QUEDAN.
##############################################################################
##############################################################################

contar()
{
TOTAL_SOTANO=( 0 0 0 0 0 )  	# Inicializar las variables del array a cero
for i in $(seq 0 4)
  do
    for j in $(seq $1 $2)
      do
        if [ ${TIPOS[i]} == ${TIPOPAPEL[j]} ]
          then 
            TOTAL_SOTANO[i]=$(( ${TOTAL_SOTANO[i]} + ${CANTIDADPAPEL0[j]} ))
        fi
      done 
  done
}

##############################################################################
##############################################################################
## CALCULA EL TOTAL DE LOS TOTALES. 
##############################################################################
##############################################################################

contarTOTAL()
{
TOTAL_TOTAL=( 0 0 0 0 0 )  	# Inicializar las variables del array a cero
for i in $(seq 0 4)
  do
    TOTAL_TOTAL[i]=$(( ${TOTAL_SOTANO_001[i]} + ${TOTAL_SOTANO_002[i]} + ${TOTAL_CUARTO[i]} ))
  done
}

##############################################################################
##############################################################################
## DIBUJA EN LA CONSOLA LA INFORMACIÓN. 
##############################################################################
##############################################################################

tabla()
{
COMIENZOFIL=0
FINFIL=$2
COMIENZOCOLTIPO=$3                       # Tipo de papel.
FINCOLTIPO=$[ $COMIENZOCOLTIPO + $4 ]    # Tipo de papel.
COMIENZOCOL=$3                           # Cantidad de papel.
FINCOL=$[ $COMIENZOCOL + $4 ]            # Cantidad de papel.
CANTIDADPAPEL0=( ${CANTIDADPAPEL[0]} )   # Separar el array en dos arrays. Uno de cantidades y el otro de tipo de papeles.
VARSEQFIL=$(seq $COMIENZOFIL $FINFIL)    # Secuencia para el bucle 'for'.
VARSEQCOL=$(seq $COMIENZOCOL $FINCOL)    # Secuencia para el otro bucle 'for'.

echo " "

for j in ${VARSEQFIL}
  do

    printf "|"
      for i in $(seq $COMIENZOCOLTIPO $FINCOLTIPO)
        do
          printf "%9s" ${TIPOPAPEL[i]};printf "|"
        done  
    COMIENZOCOLTIPO=$[ $COMIENZOCOLTIPO + $5 ]
    FINCOLTIPO=$[ $FINCOLTIPO + $5 ]

    printf "\n"
    ringlera $6
    printf "\n"

    printf "|"
      for i in $(seq $COMIENZOCOL $FINCOL)
        do
          printf "%9d" ${CANTIDADPAPEL0[i]};printf "|"
        done  
    COMIENZOCOL=$[ $COMIENZOCOL + $5 ]
    FINCOL=$[ $FINCOL + $5 ]

    printf "\n"
    ringlera $6
    printf "\n"

  done
}

##############################################################################
##############################################################################
## REPRESENTA LA TABLA RESUMEN FINAL.
##############################################################################
##############################################################################

tablaResumenTotal()
{
    echo " "
    printf "+------------------------------------------------------+\n"
    printf "|                     TOTAL RESUMIDO                   |\n"
    printf "+------------------------------------------------------+\n"
    printf "|         |   MOD1 |  MOD2  |  MOD3  |  MOD4  |  DINA4 |\n"
    printf "+------------------------------------------------------+\n"
    printf "+------------------------------------------------------+\n"

    printf "|SOTANO -1|"
    for i in $(seq 0 4)
    do
      printf "%8s" ${TOTAL_SOTANO_001[i]}; printf "|"
    done
    printf "\n+------------------------------------------------------+\n"

    printf "|SOTANO -2|"
    for i in $(seq 0 4)
    do
      printf "%8s" ${TOTAL_SOTANO_002[i]}; printf "|"
    done
    printf "\n+------------------------------------------------------+\n"

    printf "|CUARTO   |"
    for i in $(seq 0 4)
    do
      printf "%8s" ${TOTAL_CUARTO[i]}; printf "|"
    done
    printf "\n+------------------------------------------------------+\n"

    printf "|TOTAL    |"
    for i in $(seq 0 4)
    do
      printf "%8s" ${TOTAL_TOTAL[i]}; printf "|"
    done
    printf "\n+------------------------------------------------------+\n"
}

##############################################################################
##############################################################################
## DIBUJA EN LA CONSOLA EL TOTAL RESUMIDO DE LA INFORMACIÓN. 
##############################################################################
##############################################################################

tablaResumen()
{
COMIENZOFIL=0
FINFIL=$2
COMIENZOCOLTIPO=$3                       # Tipo de papel.
FINCOLTIPO=$[ $COMIENZOCOLTIPO + $4 ]    # Tipo de papel.
COMIENZOCOL=$3                           # Cantidad de papel.
FINCOL=$[ $COMIENZOCOL + $4 ]            # Cantidad de papel.
CANTIDADPAPEL0=( ${CANTIDADPAPEL[0]} )   # Separar el array en dos arrays. Uno de cantidades y el otro de tipo de papeles.
VARSEQFIL=$(seq $COMIENZOFIL $FINFIL)    # Secuencia para el bucle 'for'.
VARSEQCOL=$(seq $COMIENZOCOL $FINCOL)    # Secuencia para el otro bucle 'for'.

echo " "

for j in ${VARSEQFIL}
  do

    printf "|"
      for i in $(seq $COMIENZOCOLTIPO $FINCOLTIPO)
        do
          printf "%9s" ${TIPOPAPEL[i]};printf "|"
        done  
    COMIENZOCOLTIPO=$[ $COMIENZOCOLTIPO + $5 ]
    FINCOLTIPO=$[ $FINCOLTIPO + $5 ]

    printf "\n"
    ringlera $6
    printf "\n"

    printf "|"
      for i in $(seq $COMIENZOCOL $FINCOL)
        do
          printf "%9d" ${CANTIDADPAPEL0[i]};printf "|"
        done  
    COMIENZOCOL=$[ $COMIENZOCOL + $5 ]
    FINCOL=$[ $FINCOL + $5 ]

    printf "\n"
    ringlera $6
    printf "\n"

  done
}

##############################################################################
##############################################################################
## GRABA LOS DATOS DE LAS MATRICES A DISCO.
##############################################################################
##############################################################################

grabarDisco()
{
echo "###############################################################################" >> $FICHERO
echo "Estamos a fecha: $FECHAHM Semana nº: $SEMANA" >> $FICHERO
echo "###############################################################################" >> $FICHERO
echo ${CANTIDADPAPEL0[@]} >> $FICHERO
echo ""
echo ${CANTIDADPAPEL[1]} >> $FICHERO
}

##############################################################################
##############################################################################
## DIBUJA UNA RAYA EN LA PANTALLA DE UNA MEDIDA DETERMINADA. 
##############################################################################
##############################################################################

ringlera()
{
printf "+"
for i in $(seq 0 $1)
do
 printf "-"
done
printf "+"
}

##############################################################################
##############################################################################
## DIBUJA EN LA CONSOLA EL TÍTULO DE LA TABLA. 
##############################################################################
##############################################################################

colocacion()
{
printf "|"
for i in $(seq 0 $1)
do
  printf " "
done
printf "$2"
for i in $(seq 0 $1)
do
  printf " "
done
printf "|"
}

##############################################################################
##############################################################################
## FUNCIÓN QUE COMPRUEBA SI EL TIPO DE PAPEL ES CORRECTO. 
##############################################################################
##############################################################################

comprobacionPapel()
{
estar=false
for tipo in ${TIPOS}
do
  if ($1 == tipo)
  	then
    estar=true
  fi
done
return estar
}

##############################################################################
##############################################################################
## FUNCIÓN QUE COMPRUEBA SI LA CANTIDAD INTRODUCIDA ES CORRECTA. 
##############################################################################
##############################################################################

comprobacionCantidad()
{
cifra=true
if (($1 < 0) || ($1 > 999999)) 
	then
   	puts "La cifra introducida es incorrecta"
   	cifra=false
fi 
return cifra
}

##############################################################################
##############################################################################
## DIBUJA LAS EXISTENCIAS DE LA TABLA SOTANO -1 POR PANTALLA.
##############################################################################
##############################################################################

funcionSotano-1()
{
echo ""
ringlera 48
echo ""
colocacion 19 "SOTANO -1"
echo ""
ringlera 48
tabla SOTANO-1 0 14 4 0 48 
}

##############################################################################
##############################################################################
## DIBUJA LAS EXISTENCIAS DE LA TABLA SOTANO -2 POR PANTALLA.
##############################################################################
##############################################################################

funcionSotano-2()
{
echo ""
ringlera 68
echo ""
colocacion 29 "SOTANO -2"
echo ""
ringlera 68
tabla SOTANO-2 1 0 6 7 68
}

##############################################################################
##############################################################################
## DIBUJA LAS EXISTENCIAS DE LA TABLA CUARTO POR PANTALLA.
##############################################################################
##############################################################################

funcionCuarto()
{
echo ""
ringlera 28 
echo ""
colocacion 10 "CUARTO."
echo ""
ringlera 28 
tabla SOTANO-2 2 19 2 3 28 
}

##############################################################################
##############################################################################
##  MENU PRINCIPAL.
##############################################################################
##############################################################################

Menu_mostrarDatos()
{
    echo ""
    echo "${negrita}EXISTENCIAS DE PAPEL EN LOS ALMACENES (MENU).${q_negrita}"
    echo "==================================================="
    echo ""
    echo "1) Mostrar datos SOTANO -2."
    echo "2) Mostrar datos SOTANO -1."
    echo "3) Mostrar datos CUARTO."
    echo "4) Mostrar el TOTAL."
    echo "5) Introducir DATOS."

    echo "=================================="
    echo "6) Salir";echo "" 

    read -p "METER OPCIÓN: " answer 
    case "$answer" in 
        1) funcionSotano-2;;
        2) funcionSotano-1;;
        3) funcionCuarto;;
        4) tablaResumenTotal;;
        5) Menu_meterDatos;;
        6) exit;;   # salir.
        *) echo "Eleccion incorrecta.Debe introducir 1, 2, 3, 4, 5 o 6."; sleep 1;;
    esac
}

##############################################################################
##############################################################################
## FUNCIONES MENU SECUNDARIO.
##############################################################################
##############################################################################

function meter_Todos_Datos
{
echo ""
echo "1) Meter todos los datos."
echo ""
cuarto[0]=""

for i in {0..27}
do
  echo "POSICION: $i Introduzca la cantidad de PAPEL: "
  read cantidad_temp dummy
  CANTIDADPAPEL0[$i]=${cantidad_temp}
done
grabarDisco
llenarDatosArrays
}

function meter_SOT-1_Datos
{
echo ""
echo "1) Meter los datos del papel de la Sala de Impresoras."
echo ""

for i in {14..18}
do
  #printf "[SOT-1::%2d::%5s]\n" "$i" "${CANTIDADPAPEL0[$i]}"
  printf "[SOT-1:%2d:%5s] %6d %4s\n" "$i" "${TIPOPAPEL[$i]}" "${CANTIDADPAPEL0[$i]}" " Y/n"
  echo "POSICION: $i Introduzca la cantidad de PAPEL: "
  read cantidad_temp dummy
  CANTIDADPAPEL0[$i]=${cantidad_temp}
done
grabarDisco
llenarDatosArrays
}


function meterUnSoloDato
{
echo ""
echo "2) Meter un solo dato."
echo ""
}

function comprobar 
{
echo ""
echo "3) Comprobar."
echo ""
}
 
##############################################################################
##############################################################################
## MENU SECUNDARIO.
##############################################################################
##############################################################################

Menu_meterDatos()
{
    echo ""
    echo "${negrita}INTRODUCIR DATOS (MENU).${q_negrita}"
    echo "==================================================="
    echo ""
    echo "1) Meter todos los datos."
    echo "2) Meter un sólo dato. ¿Cual?"
    echo "3) Meter los datos de SOTANO -1."
    #echo "4) Mostrar el TOTAL."
    #echo "5) Introducir DATOS."

    echo "=================================="
    echo "6) SALIR.";echo "" 

    read -p "METER OPCIÓN: " answer dummy 
    case "$answer" in 
        1) meter_Todos_Datos;;
        2) meterUnSoloDato;;
        3) meter_SOT-1_Datos;;
    #    4) tablaResumenTotal;;
    #    5) Menu_meterDatos;;
    #    6) grabarDisco;exit;;   #Grabar los datos a fichero y salir.
        *) echo "Eleccion incorrecta.Debe introducir 1, 2, 3, 4, 5 o 6."; sleep 1;;
    esac
}

##############################################################################
##############################################################################
## EN ESTE PUNTO COMIENZA EL PROGRAMA. 
##############################################################################
##############################################################################

cabecera
llenarDatosArrays

##############################################################################
##############################################################################
## EN ESTE PUNTO PONEMOS UN BUCLE INFINITO PARA NO SALIR DEL PROGRAMA.
##############################################################################
##############################################################################

while ((0 == 0))
  do
    Menu_mostrarDatos
  done
