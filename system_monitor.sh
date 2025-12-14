#!/bin/bash

# Configuration
LOG_FILE="/var/log/system_monitor.log"
INTERVAL=${1:-300}  # Intervalle par défaut: 5 minutes

# Vérification des privilèges
if [ $(id -u) -ne 0 ]; then
    echo "Ce script nécessite des privilèges root"
    exit 1
fi

# Vérification du fichier de log
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
    chmod 644 "$LOG_FILE"
fi

# Boucle de surveillance
echo "Démarrage de la surveillance système (CTRL+C pour arrêter)"
while true; do
    # Collecte des métriques
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
    mem_usage=$(free -m | awk 'NR==2{printf "%.2f", $3*100/$2}')
    disk_usage=$(df / | awk 'NR==2{print $5}' | sed 's/%//')
    
    # Enregistrement dans le log
    echo "$timestamp | CPU: $cpu_usage% | Mémoire: $mem_usage% | Disque: $disk_usage%" >> "$LOG_FILE"
    
    # Attente jusqu'à la prochaine mesure
    sleep "$INTERVAL"
done
