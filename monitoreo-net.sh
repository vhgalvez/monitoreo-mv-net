#!/bin/bash

# Listado de direcciones IP de las VMs
IPs=("10.17.4.21" "10.17.4.22" "10.17.4.23" "10.17.4.24" "10.17.4.25" "10.17.4.26" "10.17.4.27")

# Loop infinito para monitorear
while true; do
    clear
    echo "⏱️ Monitoreando las VMs - $(date)"
    for ip in "${IPs[@]}"; do
        # Verificar si la VM está activa con ping
        ping_status=$(ping -c 1 -W 1 $ip &> /dev/null && echo "✅" || echo "❌")

        # Escanear los puertos SSH y Kubernetes API con nmap de manera concurrente
        nmap_output=$(echo $ip | xargs -I {} -P 2 nmap -p 22,6443 --open {})

        # Procesar la salida de nmap
        ssh_status=$(echo "$nmap_output" | grep "22/tcp" | awk '{print $2}' || echo "❌")
        api_status=$(echo "$nmap_output" | grep "6443/tcp" | awk '{print $2}' || echo "❌")
        
        echo "$ip - Ping: $ping_status | SSH: $ssh_status | API: $api_status"
    done
    sleep 5
done
