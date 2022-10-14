#!/usr/bin/env bash

virtualenv_path="$(which virtualenv)"
virtualenvwrapper_path='/usr/local/bin/virtualenvwrapper.sh'

if [ -x $virtualenv_path ]; then
  VIRTUALENVWRAPPER_PYTHON=$virtualenv_path
  export VIRTUALENVWRAPPER_PYTHON

  VIRTUALENVWRAPPER_VIRTUALENV=$virtualenv_path
  export VIRTUALENVWRAPPER_VIRTUALENV

  export WORKON_HOME=${WORK_ZONE_PATH}/.virtualenvs
  export PROJECT_HOME="${WORK_ZONE_APPS}"

  if [ -f $virtualenvwrapper_path ]; then
    source $virtualenvwrapper_path
  fi
fi