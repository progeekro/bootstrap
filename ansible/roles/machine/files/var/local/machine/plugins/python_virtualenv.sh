#!/usr/bin/env bash

# Copyright (C) 2021-2022 Zaharia Constantin <constantin.zaharia@progeek.ro>
# Copyright (C) 2021-2022 ProGeek <https://progeek.ro>
# SPDX-License-Identifier: GPL-3.0-or-later


virtualenv_path="$(command -v virtualenv)"
virtualenvwrapper_path='/usr/local/bin/virtualenvwrapper.sh'

if [ -x "$virtualenv_path" ]; then
  VIRTUALENVWRAPPER_PYTHON=$virtualenv_path
  export VIRTUALENVWRAPPER_PYTHON

  VIRTUALENVWRAPPER_VIRTUALENV=$virtualenv_path
  export VIRTUALENVWRAPPER_VIRTUALENV

  export WORKON_HOME=${WORK_ZONE_PATH}/.virtualenvs
  export PROJECT_HOME="${WORK_ZONE_APPS}"

  if [ -f $virtualenvwrapper_path ]; then
    # shellcheck source=/dev/null
    . "${virtualenvwrapper_path}"
  fi
fi