#!/bin/bash

FILENAME="./tabla2_crud_002.csv"

menu ()
{
  echo ""
    echo ""
    echo "MENU AGENDA TELEFONICA"
    echo "======================"
    echo ""
    echo "1) Crear usuario."
    echo "2) Comprobar usuario."
    echo "3) Modificar usuario."
    echo "4) Borrar usuario."
    echo "5) Mostrar fichero"
    echo "====================="
    echo "6) Salir" echo "" 
	 read answer 
case "$answer" in 
  1) crear;;
  2) buscar;;
  3);;
  4) borrar;;
  5) presentar;;
  6) exit;;
  *)echo Eleccion incorrecta.Debe introducir 1, 2, 3, 4 o 5. sleep 1;;
esac
}

crear ()
{
  usuario_temp = ""
  servicio_temp = ""
  area_temp = ""
  echo " " 
  echo "Meter el nombre y apellidos completos del usuario. : ";
  read usuario echo "Meter el telefono del usuario. : ";
  read telefono echo "Meter el correo del usuario. : ";
  read correo echo "Meter el servicio del trabajo. : ";
  read servicio echo "Meter el area de trabajo. : ";
  read area echo "Meter las observaciones. : ";
  read observaciones
#Poner en mayusculas los campos, nombre, servicio y area.
 
    usuario_temp = `echo $usuario | tr a - z A - Z `
    servicio_temp = `echo $servicio | tr a - z A - Z `
    area_temp = `echo $area | tr a - z A - Z `
    echo "$usuario_temp|$telefono|$correo|$servicio_temp|$area_temp|$observaciones" >> $FILENAME 
	 sort $FILENAME > tabla2ORD 
	 mv tabla2ORD $FILENAME sleep 2
}

buscar ()
{
  contador=1
    echo "Introduce dato a buscar (nombre, telefono, Email, etc). "
    read dato
	 # 
	 # Si en la función buscar no encuentro nada debería sacar por pantalla un
	 # error.
	 #
    echo " "
    echo "--------------------------"
    echo "--------------------------" 
	 while IFS="|" read col1 col2 col3 col4 col5 col6
    do
      echo "ITEM ENCON.   -> ${contador}"
#Contador de registros encontrados.
      echo "NOMBRE        -> [${col1}]"
      echo "TELEFONO      -> [${col2}]"
	   echo "CORREO        -> [${col3}]"
	   echo "SERVICIO      -> [${col4}]"
	   echo "AREA          -> [${col5}]"
	   echo "OBSERVACIONES -> [${col6}]"
	   echo "--------------------------"
	   echo "--------------------------"
	   let contador++ 
   done < <(grep -i ${dato} ${FILENAME})
	}

borrar ()
{
#No funciona el borrar.
#Creo que ya funciona.
echo "Introduce registro a borrar (nombre, telefono, Email, etc). "
read dato junk i
datoBorrarlo = `grep -i ${dato} ${FILENAME}`
echo "Borrar: ${datoBorrarlo} " 
sed -i "/${dato}/d" ${FILENAME}
#	'sed -e /${dato}/p' tabla2_crud_002.csv
#	echo ${dato}
#	echo ${FILENAME}
}

presentar ()
{
while IFS="|" read col1 col2 col3 col4 col5 col6
do
		  echo "NOMBRE        -> [${col1}]" 
		  echo "TELEFONO      -> [${col2}]"
		  #echo "CORREO        -> [${col3}]"
		  echo "SERVICIO      -> [${col4}]"
		  echo "AREA          -> [${col5}]"
		  #echo "OBSERVACIONES -> [${col6}]"
		  echo "-------------------------" 
done < $FILENAME
}

#########################################################################
#
#Un bucle infinito.
#
#########################################################################

	  while ((0 == 0))
		  do
	      menu 
		  done
