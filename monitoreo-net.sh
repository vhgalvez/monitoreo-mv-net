#!/bin/bash

# Listado de direcciones IP de las VMs
IPs=("10.17.4.21" "10.17.4.22" "10.17.4.23" "10.17.4.24" "10.17.4.25" "10.17.4.26" "10.17.4.27")

# Loop infinito para monitorear
while true; do
    clear
    echo "⏱️ Monitoreando las VMs - $(date)"
    for ip in "${IPs[@]}"; do
        # Verificar si la VM está activa con ping
        ping_status=$(ping -c 1 $ip &> /dev/null && echo "✅" || echo "❌")
        
        # Escanear los puertos SSH y Kubernetes API con nmap
        ssh_status=$(nmap -p 22 --open $ip | grep "22/tcp" | awk '{print $2}' || echo "❌")
        api_status=$(nmap -p 6443 --open $ip | grep "6443/tcp" | awk '{print $2}' || echo "❌")
        
        echo "$ip - Ping: $ping_status | SSH: $ssh_status | API: $api_status"
    done
    sleep 5
done
