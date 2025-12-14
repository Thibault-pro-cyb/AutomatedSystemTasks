#!/bin/bash

# Vérification de l'argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <fichier_log>"
    exit 1
fi

log_file="$1"

# Vérification du fichier
if [ ! -f "$log_file" ] || [ ! -r "$log_file" ]; then
    echo "Erreur: Fichier de logs inaccessible"
    exit 1
fi

# Analyse des logs
echo "=== RAPPORT D'ANALYSE DES LOGS ==="
echo "Fichier analysé: $log_file"
echo "Généré le: $(date)"
echo ""

# Nombre total de requêtes
total_requests=$(wc -l < "$log_file")
echo "1. Nombre total de requêtes: $total_requests"

# Top 10 des IPs
echo ""
echo "2. Top 10 des adresses IP:"
awk '{print $1}' "$log_file" | sort | uniq -c | sort -nr | head -10

# Codes HTTP
echo ""
echo "3. Répartition des codes HTTP:"
awk '{print $9}' "$log_file" | sort | uniq -c | sort -nr

# Chemins les plus consultés
echo ""
echo "4. Top 10 des chemins les plus consultés:"
awk '{print $7}' "$log_file" | sort | uniq -c | sort -nr | head -10

# User Agents les plus courants
echo ""
echo "5. Top 5 des User Agents:"
awk -F\" '{print $6}' "$log_file" | sort | uniq -c | sort -nr | head -5
