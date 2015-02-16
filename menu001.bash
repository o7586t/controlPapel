#!/bin/bash

#
# ==================== FAMILIA|CONTACTO|OBSERVACIONES ====================
#

FECHA=`date +%Y%m%d%H%M`
SECCION_HOME="./backup"
FILENAME="./tabla_secciones.csv"
FILENAME_BACKUP="${SECCION_HOME}/tabla_secciones_${FECHA}.csv"

#
# Meter escapes en la pantalla para poner negritas y colores en la consola.
#
esc=""
negrita="${esc}[1m"
q_negrita="${esc}[22m"

menu ()
{
    echo ""
    echo ""
    echo "${negrita}SECCIONES A LAS QUE PERTENECEN LOS LISTADOS (MENU).${q_negrita}"
    echo "==================================================="
    echo ""
    echo "1) Crear sección-listado."
    echo "2) Buscar sección-listado."
    echo "3) Modificar sección-listado."
    echo "4) Borrar sección-listado."
    echo "5) Mostrar fichero sección-listado"
    echo "6) Back-Up del fichero de datos."
    echo "7) Crear listado para imprimir."
    echo "=================================="
    echo "8) Salir";echo "" 

    read -p "Meter opción elegida: " answer 
    case "$answer" in 
        1) crear;;
        2) buscar;;
        3);;
        4) borrar;;
        5) presentar;;
        6) backup;;
        7) imprimir;;
        8) exit;;
        *) echo "Eleccion incorrecta.Debe introducir 1, 2, 3, 4, 5 o 6."; sleep 1;;
    esac
}

imprimir()
{
    echo " "
}

modificar()
{
    echo " "
}

crear ()
{
    familia_temp=""
    contacto_temp=""
    observaciones_temp=""
    echo " " 
    echo "Meter la familia a la que pertenece el trabajo. : ";
    read familia_temp 
    echo "Meter el propietario del trabajo (contacto). : ";
    read contacto_temp
    echo "Meter las observaciones necesarias. : ";
    read observaciones_temp 
    contacto=`echo $contacto_temp | tr a-z A-Z `    # Poner en mayúsculas el campo, contacto. 
    echo "$familia_temp|$contacto|$observaciones_temp" >> $FILENAME 
    sort $FILENAME > tabla2ORD 
    mv tabla2ORD $FILENAME
}

buscar ()
{
    contador=1
    echo "Introduce dato a buscar (familia, contacto, observaciones, etc). "
    read dato
    # 
    # Si en la función buscar no encuentro nada debería sacar por pantalla un
    # error.
    #
    echo " "
    echo "--------------------------"
    echo "--------------------------" 
    while IFS="|" read col1 col2 col3
        do
            echo "ITEM ENCON.   -> ${contador}"     #Contador de registros encontrados.
            echo "FAMILIA       -> [${col1}]"
            echo "CONTACTO      -> [${col2}]"
            echo "OBSERVACIONES -> [${col3}]"
            echo "--------------------------"
            echo "--------------------------"
            let contador++ 
        done < <(grep -i ${dato} ${FILENAME})
}

borrar ()
{
    contador=1
    echo "Introduce registro a borrar (familia, contacto, observaciones, etc). "
    read dato

    echo " "
    echo "--------------------------"
    echo "--------------------------" 
    while IFS="|" read col1 col2 col3
        do
            echo "ITEM ENCON.   -> ${contador}"     #Contador de registros encontrados.
            echo "FAMILIA       -> [${col1}]"
            echo "CONTACTO      -> [${col2}]"
            echo "OBSERVACIONES -> [${col3}]"
            echo "--------------------------"
            echo "--------------------------"
            let contador++ 
        done < <(grep -i ${dato} ${FILENAME})

        echo "Borrar lo encontrado (Txmit), o cancelar (C)."
        read dummy

        case $dummy in
            T|t) echo "Borrando: .... " 
            sed -i "/${dato}/d" ${FILENAME};;
            C|c) echo "Cancelando.......";;
            *) echo "Tecla desconocida. Prsione (T) o (C)"
        esac
}

presentar ()
{
    while IFS="|" read col1 col2 col3
        do
            echo "FAMILIA       -> [${col1}]" 
            echo "CONTACTO      -> [${col2}]"
            echo "OBSERVACIONES -> [${col3}]"
            echo "-------------------------" 
        done < $FILENAME
}

backup ()
{
    cp $FILENAME $FILENAME_BACKUP
}

#########################################################################
#
# Un bucle infinito.
#
#########################################################################

while ((0 == 0))
    do
       menu 
    done
