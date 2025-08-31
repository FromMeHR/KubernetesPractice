#!/bin/bash

kubectl get secret app-secrets &> /dev/null
if [[ "$?" == 0 ]]; then
    echo "Secret already exists. Deleting it..."
    kubectl delete secret app-secrets
fi

kubectl create secret generic app-secrets --from-env-file=.env