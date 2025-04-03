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

  # Verificar puertos con socat
  if socat -T 0.1 -u TCP4:"$ip":22 /dev/null &> /dev/null; then
    ssh_status="✅"
  fi
  if socat -T 0.1 -u TCP4:"$ip":6443 /dev/null &> /dev/null; then
    api_status="✅"
  fi

  echo "$ip - Ping: $ping_status | SSH: $ssh_status | API: $api_status"
}

# Función para ejecutar el monitoreo
ejecutar_monitoreo() {
  clear
  echo "⏱️ Monitoreo en Tiempo Real - $(date)"
  for ip in "${IPs[@]}"; do
    verificar_ip "$ip"
  done
}

# Monitoreo continuo con watch
watch -n 1 -t ejecutar_monitoreo