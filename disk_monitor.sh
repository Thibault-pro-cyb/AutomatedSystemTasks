#!/bin/bash

# Configuration
THRESHOLD=${1:-90}  # Seuil par défaut: 90%
LOG_FILE="/var/log/disk_monitor.log"

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

# Analyse de l'espace disque
while read -r line; do
    usage=$(echo "$line" | awk '{print $5}' | sed 's/%//')
    partition=$(echo "$line" | awk '{print $6}')
    
    if [ "$usage" -ge "$THRESHOLD" ]; then
        message="[$(date '+%Y-%m-%d %H:%M:%S')] ALERTE: Partition $partition à $usage% de capacité"
        echo "$message" >> "$LOG_FILE"
        echo "$message"
    fi
done < <(df -h | tail -n +2)

echo "Surveillance terminée. Consultez $LOG_FILE pour les détails."
