#!/bin/bash

function ctrl_c() {
	echo -e "\n[!] Saliendo...\n"
	tput cnorm; exit 1
}

# Ctrl + C
trap ctrl_c INT

tput civis # Oculta el cursor
for puerto in $(seq 1 65535); do
	(echo '' > /dev/tcp/127.0.0.1/$puerto) 2>/dev/null && echo "[+] $puerto - OPEN" || echo "[+] $puerto - CLOSE" &
done; wait

tput cnorm # Recuperamos el cursor