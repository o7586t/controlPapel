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
	  TIPOPAPEL[$i]=" "
  done
}

cargarArrayTipos()
{
TIPOPAPEL=( $(cat datosPapel.csv | tail -n 1) )
cambiarIFS    # Para poder leer las dos líneas y cargarlas en un Array
CANTIDADPAPEL=( $(cat datosPapel.csv | tail -n 2) )
volverIFS
}

cambiarIFS()
{
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
	    printf "\n+-------------------------------------------------+\n"

	done
}

verArrayCuarto()
{

echo " "
printf "+-----------------------------+\n"
printf "|            CUARTO           |\n"
printf "+-----------------------------+\n"

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

ringlera()
{
		  printf "+"
		  for i in $(seq 0 $1)
		  do
					 printf "-"
		  done
		  printf "+"
}

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
#verArraySotano-2

Tabla SOTANO-1 0 14 4 0 
Tabla SOTANO-2 1 0 6 7 

echo ""
ringlera 49
echo ""
colocacion 20 SOTANO-1
echo ""
ringlera 49
echo ""
ringlera 69 
echo ""
colocacion 30 SOTANO-2
echo ""
ringlera 69



echo ""
