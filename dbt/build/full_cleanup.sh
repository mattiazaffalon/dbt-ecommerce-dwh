#!/bin/bash

# Elenco di tutti i container Docker
CONTAINERS=$(sudo docker container ls -aq)

# Controllo se ci sono container disponibili
if [ -z "$CONTAINERS" ]; then
    echo "Non ci sono container Docker disponibili."
else
    # Loop su tutti i container e rimozione
    for CONTAINER in $CONTAINERS
    do
        echo "Rimozione del container Docker: $CONTAINER"
        sudo docker container rm -f $CONTAINER
    done
    echo "Tutti i container Docker sono stati rimossi."
fi

# Elenco di tutte le immagini Docker
IMAGES=$(sudo docker image ls -q)

# Controllo se ci sono immagini disponibili
if [ -z "$IMAGES" ]; then
    echo "Non ci sono immagini Docker disponibili."
    exit 0
fi

# Loop su tutte le immagini e rimozione
for IMAGE in $IMAGES
do
    echo "Rimozione dell'immagine Docker: $IMAGE"
    sudo docker image rm $IMAGE
done

echo "Tutte le immagini Docker sono state rimosse."
