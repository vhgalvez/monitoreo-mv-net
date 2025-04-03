# Monitoreo de VMs con Ping, SSH y Kubernetes API

Este script monitorea en tiempo real el estado de varias máquinas virtuales (VMs) mediante `ping`, el puerto SSH (22) y el puerto de la API de Kubernetes (6443). El script realiza una comprobación periódica de la conectividad y los puertos especificados.

## Descripción

El script hace un **loop infinito** para verificar continuamente el estado de las máquinas virtuales. Realiza las siguientes comprobaciones:

1. **Ping**: Verifica si la VM está activa.
2. **SSH (puerto 22)**: Verifica si el puerto SSH está abierto en la VM.
3. **API Kubernetes (puerto 6443)**: Verifica si el puerto API de Kubernetes está abierto.

## Requisitos

- `ping`: Herramienta de red para comprobar la conectividad.
- `nmap`: Herramienta de escaneo de puertos.
- Acceso a las máquinas virtuales mediante la red (asegurándose de que los puertos necesarios estén accesibles).

## Instrucciones

### 1. Configuración

Primero, edita el script y añade las direcciones IP de tus máquinas virtuales en el arreglo `IPs`:

```bash
IPs=("10.17.4.21" "10.17.4.22" "10.17.4.23" "10.17.4.24" "10.17.4.25" "10.17.4.26" "10.17.4.27")
```

### 2. Ejecución del Script

Guarda el script como `monitor.sh` en tu máquina, luego dale permisos de ejecución y ejecútalo:

```bash
chmod +x monitor.sh
./monitor.sh
```

El script comenzará a monitorear las VMs, mostrando el estado de cada una en tiempo real.

### 3. Salida Esperada

El script mostrará un resultado similar al siguiente para cada máquina virtual:

```plaintext
⏱️ Monitoreando las VMs - Thu Apr 3 17:40:10 CEST
10.17.4.21 - Ping: ✅ | SSH: ✅ | API: ❌
10.17.4.22 - Ping: ✅ | SSH: ✅ | API: ❌
10.17.4.23 - Ping: ✅ | SSH: ✅ | API: ✅
10.17.4.24 - Ping: ✅ | SSH: ✅ | API: ❌
10.17.4.25 - Ping: ✅ | SSH: ✅ | API: ❌
10.17.4.26 - Ping: ✅ | SSH: ✅ | API: ✅
10.17.4.27 - Ping: ✅ | SSH: ✅ | API: ❌
```

### 4. Detalles de Monitoreo

- **Ping**: Si el host responde al ping, se mostrará un ✅.
- **SSH (puerto 22)**: Si el puerto SSH está abierto, se mostrará un ✅.
- **API Kubernetes (puerto 6443)**: Si el puerto de la API está abierto, se mostrará un ✅.

### 5. Configuración Adicional

Puedes ajustar el tiempo entre cada verificación editando el valor de `sleep` en el script, el cual está configurado a 5 segundos por defecto:

```bash
sleep 5
```

### 6. Detener el Script

Para detener el script, presiona `Ctrl+C` en la terminal donde se está ejecutando.

## Contribuciones

Si deseas mejorar este script o agregar nuevas características, siéntete libre de abrir un pull request. Algunas ideas para mejorar:

- Agregar más puertos para monitorear.
- Enviar notificaciones cuando una máquina no responda.
- Mejorar la salida agregando colores o formatos más complejos.

## Licencia

Este script es de código abierto y se puede usar libremente bajo la licencia MIT.