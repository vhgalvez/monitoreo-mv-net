#!/bin/bash

# Listado de direcciones IP de las VMs
IPs=("10.17.4.21" "10.17.4.22" "10.17.4.23" "10.17.4.24" "10.17.4.25" "10.17.4.26" "10.17.4.27")

# Función para verificar una IP
verificar_ip() {
  local ip="$1"
  local ping_status="❌"
  local ssh_status="❌"
  local api_status="❌"

  # Verificar ping
  if ping -c 1 -W 1 "$ip" &> /dev/null; then
    ping_status="✅"
  fi

  # Escanear puertos SSH y Kubernetes API con nmap
  local nmap_output=$(nmap -p 22,6443 --open "$ip")

  # Procesar salida de nmap
  if echo "$nmap_output" | grep -q "22/tcp"; then
    ssh_status="✅"
  fi
  if echo "$nmap_output" | grep -q "6443/tcp"; then
    api_status="✅"
  fi

  echo "$ip - Ping: $ping_status | SSH: $ssh_status | API: $api_status"
}

# Loop infinito para monitorear
while true; do
  clear
  echo "⏱️ Monitoreando las VMs - $(date)"

  # Ejecutar verificaciones en paralelo con xargs, definiendo la función dentro de bash -c
  printf "%s\n" "${IPs[@]}" | xargs -I {} -P $(nproc) bash -c 'verificar_ip() { local ip="$1"; local ping_status="❌"; local ssh_status="❌"; local api_status="❌"; if ping -c 1 -W 1 "$ip" &> /dev/null; then ping_status="✅"; fi; local nmap_output=$(nmap -p 22,6443 --open "$ip"); if echo "$nmap_output" | grep -q "22/tcp"; then ssh_status="✅"; fi; if echo "$nmap_output" | grep -q "6443/tcp"; then api_status="✅"; fi; echo "$ip - Ping: $ping_status | SSH: $ssh_status | API: $api_status"; }; verificar_ip {}'

  sleep 5
done