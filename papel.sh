#!/bin/bash

##############################################################################
##############################################################################
## VARIABLES.
##############################################################################
##############################################################################

FECHA=`date +20%y/%m/%d`
SEMANA=`date '+%V'`
declare -a TIPOS=(MOD1 MOD2 MOD3 MOD4 DINA4)
declare -a TIPOPAPEL
declare -a CANTIDADPAPEL
FICHERO="./datosPapelOSTIAS.csv"
declare -a TOTAL_SOTANO_002
declare -a TOTAL_SOTANO_001
declare -a TOTAL_CUARTO
declare -a TOTAL_TOTAL

##############################################################################
##############################################################################
## CABECERA DE LA APLICACIÓN.
##############################################################################
##############################################################################

comenzar()
{
echo ""
echo "=================================================="
echo "=================================================="
echo ""
echo "APLICACIÓN PARA EL CONTROL DEL PAPEL EN EL ALMACÉN"
echo ""
echo "=================================================="
echo "=================================================="
echo ""
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
TIPOPAPEL=( $(cat datosPapel.csv | tail -n 1) )
cambiarIFS    # Para poder leer las dos líneas y cargarlas en un Array
CANTIDADPAPEL=( $(cat datosPapel.csv | tail -n 2) )
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
## FUNCIÓN QUE DIBUJA EN LA CONSOLA LA INFORMACIÓN. 
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

#
# Calcular el resumen de Sotano -1.
#

    for i in $(seq 0 4)
    do
#      printf "%8s" ${TIPOS[i]}; printf "|"
      printf "%8s" ${CANTIDADPAPEL0[i]}; printf "|" # Esto es el papel del array no el total de papel por tipos.
    done

    printf "\n+------------------------------------------------------+\n"

    printf "|SOTANO -2|"
    for i in $(seq 0 4)
    do
      printf "%8s" ${TIPOS[i]}; printf "|"
    done

    printf "\n+------------------------------------------------------+\n"

    printf "|CUARTO   |"
    for i in $(seq 0 4)
    do
      printf "%8s" ${TIPOS[i]}; printf "|"
    done

    printf "\n+------------------------------------------------------+\n"

    printf "|TOTAL    |"
    for i in $(seq 0 4)
    do
      printf "%8s" ${TIPOS[i]}; printf "|"
    done

    printf "\n+------------------------------------------------------+\n"
}

##############################################################################
##############################################################################
## FUNCIÓN QUE DIBUJA EN LA CONSOLA EL TOTAL RESUMIDO DE LA INFORMACIÓN. 
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
## FUNCIÓN QUE GRABA DATOS DE LAS MATRICES A DISCO.
##############################################################################
##############################################################################

grabarDisco()
{
echo ${CANTIDADPAPEL[0]} >> $FICHERO
echo ""
echo ${CANTIDADPAPEL[1]} >> $FICHERO
}

##############################################################################
##############################################################################
## FUNCIÓN QUE DIBUJA UNA RAYA EN LA PANTALLA DE UNA MEDIDA DETERMINADA. 
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
## FUNCIÓN QUE DIBUJA EN LA CONSOLA EL TÍTULO DE LA TABLA. 
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
## FUNCIÓN QUE DIBUJA LA TABLA POR PANTALLA.
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
## FUNCIÓN QUE DIBUJA LA TABLA POR PANTALLA.
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
## FUNCIÓN QUE DIBUJA LA TABLA POR PANTALLA.
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
## EN ESTE PUNTO COMIENZA EL PROGRAMA. 
##############################################################################
##############################################################################

comenzar

echo "${FECHA}, semana nº: ${SEMANA} del año. Tenemos la siguiente cantidad de PAPEL en nuestros almacenes:"

inicializarArrayTipos
cargarArrayTipos

# ---------------------------

funcionSotano-2

# ---------------------------

funcionSotano-1

# ---------------------------

funcionCuarto

# ---------------------------

cargarArrayTipos
grabarDisco

#verArrayTotal
tablaResumenTotal

echo ""
ringlera 53 
echo ""
colocacion 19 "TOTAL RESUMIDO"
echo ""
ringlera 53 
tablaResumen SOTANO-2 2 19 2 3 28 


echo ""
