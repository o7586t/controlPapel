#!/bin/bash

FECHA=`date +20%y/%m/%d`
SEMANA=`date '+%V'`
declare -a TIPOS=(MOD1 MOD2 MOD3 MOD4 DINA4)
declare -a TIPOPAPEL
declare -a CANTIDADPAPEL

banner()
{
	banner $1
	exit 5
}

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

inicializarArrayTipos()
{
  for i in $(seq 0 27) 
  do
	  #declare -a TIPOPAPEL
	  TIPOPAPEL[$i]=" "
  done
}

cargarArrayTipos()
{
TIPOPAPEL=( $(cat datosPapel.csv | tail -n 1) )
#TIPOPAPEL=( `cat "datosPapel.csv" | tail -1` )
#CANTIDADPAPEL=( $(cat datosPapel.csv | tail -2) )
#printf "El valor que tiene la variable IFS es: %b ${IFS}"
          #IFS_old=$IFS
          #IFS=$'\n'   # Importante mete el escape \n de esta forma.
#printf "El valor que tiene la variable IFS es: %b ${IFS}"
cambiarIFS    # Para poder leer las dos líneas y cargarlas en un Array
#CANTIDADPAPEL=( `cat datosPapel.csv | tail -n 2` )
CANTIDADPAPEL=( $(cat datosPapel.csv | tail -n 2) )
          #IFS=$IFS_old
volverIFS
}

cambiarIFS()
{
  # Importante mete el escape $'\n' de esta forma.
  IFS_old=$IFS
  IFS=$'\n'
}

volverIFS()
{
  IFS=$IFS_old
}

Tabla()
{
echo " "
printf "+---------------------------------------------------------------------+\n"
printf "|                               $1                              |\n"
printf "+---------------------------------------------------------------------+\n"

COMIENZOFIL=0
FINFIL=$2

COMIENZOCOLTIPO=0                       # Tipo de papel.
FINCOLTIPO=$[ $COMIENZOCOLTIPO + $3 ]    # Tipo de papel.
COMIENZOCOL=0                           # Cantidad de papel.
FINCOL=$[ $COMIENZOCOL + $3 ]            # Cantidad de papel.

CANTIDADPAPEL0=( ${CANTIDADPAPEL[0]} )  # Separar el array en dos arrays. Uno de cantidades y el otro de tipo de papeles.

VARSEQFIL=$(seq $COMIENZOFIL $FINFIL)   # Secuencia para el bucle 'for'.
VARSEQCOL=$(seq $COMIENZOCOL $FINCOL)   # Secuencia para el otro bucle 'for'.
for j in ${VARSEQFIL}
  do

    printf "|"
      for i in $(seq $COMIENZOCOLTIPO $FINCOLTIPO)
        do
          printf "%9s" ${TIPOPAPEL[i]};printf "|"
        done  
    COMIENZOCOLTIPO=$[ $COMIENZOCOLTIPO + $4 ]
    FINCOLTIPO=$[ $FINCOLTIPO + $4 ]
    printf "\n+---------------------------------------------------------------------+\n"

    printf "|"
      for i in $(seq $COMIENZOCOL $FINCOL)
        do
          printf "%9d" ${CANTIDADPAPEL0[i]};printf "|"
        done  
    COMIENZOCOL=$[ $COMIENZOCOL + $4 ]
    FINCOL=$[ $FINCOL + $4 ]
    printf "\n+---------------------------------------------------------------------+\n"

  done
}

Tabla22()
{
echo " "
printf "+---------------------------------------------------------------------+\n"
printf "|                               $1                              |\n"
printf "+---------------------------------------------------------------------+\n"

COMIENZOFIL=0
FINFIL=$2

COMIENZOCOLTIPO=$3                       # Tipo de papel.
FINCOLTIPO=$[ $COMIENZOCOLTIPO + $4 ]    # Tipo de papel.
COMIENZOCOL=$3                           # Cantidad de papel.
FINCOL=$[ $COMIENZOCOL + $4 ]            # Cantidad de papel.

CANTIDADPAPEL0=( ${CANTIDADPAPEL[0]} )  # Separar el array en dos arrays. Uno de cantidades y el otro de tipo de papeles.

VARSEQFIL=$(seq $COMIENZOFIL $FINFIL)   # Secuencia para el bucle 'for'.
VARSEQCOL=$(seq $COMIENZOCOL $FINCOL)   # Secuencia para el otro bucle 'for'.
for j in ${VARSEQFIL}
  do

    printf "|"
      for i in $(seq $COMIENZOCOLTIPO $FINCOLTIPO)
        do
          printf "%9s" ${TIPOPAPEL[i]};printf "|"
        done  
    COMIENZOCOLTIPO=$[ $COMIENZOCOLTIPO + $5 ]
    FINCOLTIPO=$[ $FINCOLTIPO + $5 ]
    printf "\n+---------------------------------------------------------------------+\n"

    printf "|"
      for i in $(seq $COMIENZOCOL $FINCOL)
        do
          printf "%9d" ${CANTIDADPAPEL0[i]};printf "|"
        done  
    COMIENZOCOL=$[ $COMIENZOCOL + $5 ]
    FINCOL=$[ $FINCOL + $5 ]
    printf "\n+---------------------------------------------------------------------+\n"

  done
}

verArraySotano-2()
{

echo " "
printf "+---------------------------------------------------------------------+\n"
printf "|                               SOTANO  -2                            |\n"
printf "+---------------------------------------------------------------------+\n"

COMIENZOFIL=0
FINFIL=1

COMIENZOCOLTIPO=0                       # Tipo de papel.
FINCOLTIPO=$[ $COMIENZOCOLTIPO + 6 ]    # Tipo de papel.
COMIENZOCOL=0                           # Cantidad de papel.
FINCOL=$[ $COMIENZOCOL + 6 ]            # Cantidad de papel.

CANTIDADPAPEL0=( ${CANTIDADPAPEL[0]} )  # Separar el array en dos arrays. Uno de cantidades y el otro de tipo de papeles.

VARSEQFIL=$(seq $COMIENZOFIL $FINFIL)   # Secuencia para el bucle 'for'.
VARSEQCOL=$(seq $COMIENZOCOL $FINCOL)   # Secuencia para el otro bucle 'for'.
for j in ${VARSEQFIL}
  do

    printf "|"
      for i in $(seq $COMIENZOCOLTIPO $FINCOLTIPO)
        do
          printf "%9s" ${TIPOPAPEL[i]};printf "|"
        done  
    COMIENZOCOLTIPO=$[ $COMIENZOCOLTIPO + 7 ]
    FINCOLTIPO=$[ $FINCOLTIPO + 7 ]
    printf "\n+---------------------------------------------------------------------+\n"

    printf "|"
      for i in $(seq $COMIENZOCOL $FINCOL)
        do
          printf "%9d" ${CANTIDADPAPEL0[i]};printf "|"
        done  
    COMIENZOCOL=$[ $COMIENZOCOL + 7 ]
    FINCOL=$[ $FINCOL + 7 ]
    printf "\n+---------------------------------------------------------------------+\n"

  done
}

verArraySotano-1()
{

echo " "
printf "+-------------------------------------------------+\n"
printf "|                     SOTANO  -1                  |\n"
printf "+-------------------------------------------------+\n"

COMIENZOFIL=0
FINFIL=0
COMIENZOCOL=14
FINCOL=$[ $COMIENZOCOL + 4]

  VARSEQFIL=$(seq $COMIENZOFIL $FINFIL)
  VARSEQCOL=$(seq $COMIENZOCOL $FINCOL)
  for j in ${VARSEQFIL}
	do
	  printf "|"
	    for i in $(seq $COMIENZOCOL $FINCOL)
		    do
		      printf "%9s" ${TIPOPAPEL[i]};printf "|"
		    done	
		COMIENZOCOL=$[ $COMIENZOCOL + 3 ]
		FINCOL=$[ $FINCOL + 3 ]
	    printf "\n+-------------------------------------------------+\n"

		COMIENZOCOL=14
		FINCOL=$[ $COMIENZOCOL + 4]
	    printf "|"
	      for i in $(seq $COMIENZOCOL $FINCOL)
		do
		  printf "%9d" ${CANTIDADPAPEL0[i]};printf "|"
		done  
	    #COMIENZOCOL=$[ $COMIENZOCOL + 7 ]
	    #FINCOL=$[ $FINCOL + 7 ]
	    printf "\n+-------------------------------------------------+\n"

	done
}

verArrayCuarto()
{

echo " "
printf "+-----------------------------+\n"
printf "|            CUARTO           |\n"
printf "+-----------------------------+\n"

# COMIENZOFIL=0
# FINFIL=2
# COMIENZOCOL=19
# FINCOL=$[ $COMIENZOCOL + 2 ]
# 
#   VARSEQFIL=$(seq $COMIENZOFIL $FINFIL)
#   VARSEQCOL=$(seq $COMIENZOCOL $FINCOL)
#   for j in ${VARSEQFIL}
# 	do
# 	  printf "|"
# 	    for i in $(seq $COMIENZOCOL $FINCOL)
# 		   do
# 		      printf "%9s" ${TIPOPAPEL[i]};printf "|"
# 		   done	
# 		COMIENZOCOL=$[ $COMIENZOCOL + 3 ]
# 		FINCOL=$[ $FINCOL + 3 ]
# 	  printf "\n+-----------------------------+\n"
# 	done

###############################################################

COMIENZOCOLTIPO=19                        # Tipo de papel.
FINCOLTIPO=$[ $COMIENZOCOLTIPO + 2 ]      # Tipo de papel.
COMIENZOCOL=19                            # Cantidad de papel.
FINCOL=$[ $COMIENZOCOL + 2 ]              # Cantidad de papel.

CANTIDADPAPEL1=( ${CANTIDADPAPEL[0]} )    # Separar el array en dos arrays. Uno de cantidades y el otro de tipo de papeles.

VARSEQFIL=$(seq $COMIENZOCOLTIPO $FINCOLTIPO)   # Secuencia para el bucle 'for'.
VARSEQCOL=$(seq $COMIENZOCOL $FINCOL)     # Secuencia para el otro bucle 'for'.
for j in ${VARSEQFIL}
  do
    printf "|"
      for i in $(seq $COMIENZOCOLTIPO $FINCOLTIPO)
        do
          printf "%9s" ${TIPOPAPEL[i]};printf "|"
        done  
    COMIENZOCOLTIPO=$[ $COMIENZOCOLTIPO + 3 ]
    FINCOLTIPO=$[ $FINCOLTIPO + 3 ]
    printf "\n+-----------------------------+\n"
    printf "|"
      for i in $(seq $COMIENZOCOL $FINCOL)
        do
          printf "%9d" ${CANTIDADPAPEL1[i]};printf "|"
        done  
    COMIENZOCOL=$[ $COMIENZOCOL + 3 ]
    FINCOL=$[ $FINCOL + 3 ]
    printf "\n+-----------------------------+\n"
  done

###############################################################
}

verArrayTotal()
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
      printf "%8s" ${TIPOS[i]}; printf "|"
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

comprobacionPapel()
{
    estar=false
    # Iteracion que recorre el array.
    for tipo in ${TIPOS}
    do
      if ($1 == tipo)
      	then
        estar=true
      fi
    done
    return estar
}

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

################################################################################
##
## Comienzo del programa
##
#################################################################################

comenzar

echo "${FECHA}, semana nº: ${SEMANA} del año. Tenemos la siguiente cantidad de PAPEL en nuestros almacenes:"
echo ""

inicializarArrayTipos
cargarArrayTipos
verArraySotano-2
#verArraySotano-1
#verArrayCuarto

Tabla SOTANO-2 1 6 7
Tabla22 SOTANO-1 0 14 4 0 

#echo "Ver el array completo. CANTIDADPAPEL[*]"
#echo ${CANTIDADPAPEL[*]}
#echo "Ver el array 0. CANTIDADPAPEL[0]"
#echo ${CANTIDADPAPEL[0]}
#echo "Ver el array 1. CANTIDADPAPEL[1]"
#echo ${CANTIDADPAPEL[1]}

echo ""

#verArrayTotal

echo ""
