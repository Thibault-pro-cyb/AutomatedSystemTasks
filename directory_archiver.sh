#!/bin/bash

# Vérification des arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 <dest_dir> <source_dir1> [<source_dir2> ...]"
    exit 1
fi

dest_dir="$1"
shift

# Création du répertoire de destination si inexistant
if [ ! -d "$dest_dir" ]; then
    mkdir -p "$dest_dir"
fi

# Traitement de chaque répertoire source
for source_dir in "$@"; do
    if [ ! -d "$source_dir" ]; then
        echo "Attention: $source_dir n'est pas un répertoire valide - ignoré"
        continue
    fi
    
    # Création du nom d'archive
    dir_name=$(basename "$source_dir")
    archive_name="${dir_name}_$(date +%Y%m%d_%H%M%S).tar.gz"
    archive_path="$dest_dir/$archive_name"
    
    # Création de l'archive
    tar -czf "$archive_path" -C "$(dirname "$source_dir")" "$dir_name"
    
    if [ $? -eq 0 ]; then
        echo "Archive créée: $archive_path"
    else
        echo "Erreur lors de la création de l'archive pour $source_dir"
    fi
done
