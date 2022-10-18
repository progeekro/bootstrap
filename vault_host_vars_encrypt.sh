#!/usr/bin/env bash

for d in host_vars/*; do
    if [ -d ${d} ]; then
        echo "Folder: ${d}"
        ansible-vault encrypt --vault-password-file pass-vault.txt ${d}/vault.yaml
    fi
done