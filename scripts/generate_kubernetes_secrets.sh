#!/bin/bash

SECRET_NAME=app-secret
PATH_TO_ENV=.env

echo "[+] Generate secret '$SECRET_NAME' from '$PATH_TO_ENV' file..."

if [[ ! -f "$PATH_TO_ENV" ]]; then
    echo "[-] File '$PATH_TO_ENV' not found!"
    exit 1
fi

kubectl get secret $SECRET_NAME &> /dev/null
if [[ "$?" == 0 ]]; then
    echo "[+] Secret already exists. Deleting it..."
    kubectl delete secret $SECRET_NAME
fi

echo "[+] Creating secret..."
kubectl create secret generic $SECRET_NAME --from-env-file=$PATH_TO_ENV

echo "[+] Secret '$SECRET_NAME' created successfully from '$PATH_TO_ENV'"
