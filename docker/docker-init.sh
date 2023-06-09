#!/bin/bash

DOCKERPATH=$(which docker)

if [ "${DOCKERPATH}" = "" ]; then
    echo "error: docker not found"
    exit 1
fi

for dfile in *.Dockerfile
do
    tag=$(echo $dfile | cut -d "." -f 1)
    sudo docker build -t ${tag} -f $dfile .
done
