#!/usr/bin/env bash

# Copyright (C) 2021-2022 Zaharia Constantin <constantin.zaharia@progeek.ro>
# Copyright (C) 2021-2022 ProGeek <https://progeek.ro>
# SPDX-License-Identifier: GPL-3.0-or-later

for d in host_vars/*; do
    if [ -d ${d} ]; then
        echo "Folder: ${d}"
        ansible-vault encrypt --vault-password-file pass-vault.txt ${d}/vault.yaml
    fi
done