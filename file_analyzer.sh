#!/bin/bash

# Vérification de l'argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <fichier>"
    exit 1
fi

fichier="$1"

# Validation de l'existence et de la lisibilité
if [ ! -e "$fichier" ]; then
    echo "Erreur: Le fichier '$fichier' n'existe pas"
    exit 1
fi

if [ ! -r "$fichier" ]; then
    echo "Erreur: Le fichier '$fichier' n'est pas lisible"
    exit 1
fi

# Analyse du fichier
lignes=$(wc -l < "$fichier")
mots=$(wc -w < "$fichier")
taille=$(wc -c < "$fichier")

# Affichage des résultats
echo "Analyse du fichier: $fichier"
echo "Nombre de lignes: $lignes"
echo "Nombre de mots: $mots"
echo "Taille en octets: $taille"
