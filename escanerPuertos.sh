#!/bin/bash

function ctrl_c(){
    echo -e "\n\n[!] Saliendo...\n"
    exit 1
}

# Ctrl+C
trap ctrl_c SIGINT

declare -a ports=( $(seq 1 65535) )

function checkPort() {
    #abro un descriptor de archivos con permisos de escritura y lectura
    (exec 3<> /dev/tcp/$1/$2) 2>/dev/null

    if [ $? -eq 0 ]; then
        echo -e "[+] Host $1 - port $2 (OPEN)"
    fi
    #cierro el descriptor, lo cierro de las dos formas para asegurarme de que se cierra
    exec 3<&-
    exec 3>&-
}

if [ $1 ]; then
    for port in ${ports[@]}; do
        checkPort $1 $port &
    done
else
    echo -e "\n[!] Uso: $0 <ip-address>\n" 
fi

wait