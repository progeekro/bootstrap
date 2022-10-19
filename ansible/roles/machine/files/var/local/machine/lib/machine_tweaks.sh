#!/usr/bin/env bash

# Copyright (C) 2021-2022 Zaharia Constantin <constantin.zaharia@progeek.ro>
# Copyright (C) 2021-2022 ProGeek <https://progeek.ro>
# SPDX-License-Identifier: GPL-3.0-or-later

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

DIR_COLORS_THEME='dircolors.256dark' # choices: dircolors.256dark, dircolors.ansi-dark, dircolors.ansi-light, dircolors.ansi-universal 

export TWEAKS_DIR=/var/local/machine

function machine_tweaks__import() {
  [[ -f $1 ]] && source $1 || echo ":: Machine Tweaks failed to import file $1"
}

mapfile files <<< "$(find ${TWEAKS_DIR}/plugins -name '*.sh' ! -type d)"
for file in "${files[@]}";do
  machine_tweaks__import $file
done

unset -f machine_tweaks__import

#last thing to do is to set the PS1 prompt
if [ "$(type -t set_bash_prompt)" = 'function' ]; then
    PROMPT_COMMAND=set_bash_prompt
fi
