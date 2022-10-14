#!/usr/bin/env bash

# Return the prompt symbol to use, colorized based on the return value of the
# previous command.
function set_prompt_symbol() {
  if test "$1" -eq 0; then
    PROMPT_SYMBOL="\[$GRN\]\\$\[$DEF\] "
  else
    PROMPT_SYMBOL="\[$RED\]\\$\[$DEF\] "
  fi
}

# Set the full bash prompt.
function set_bash_prompt() {
  local last_command=$? # Must come first!

  # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
  # return value of the last command.
  set_prompt_symbol $?

  PS1=""

  if [[ $last_command == 0 ]]; then
    PS1+="\[$GRN\]$CHECKMARK "
  else
    PS1+="\[$BRED\]$FANCYX "
  fi

  if [[ $EUID == 0 ]]; then
    USER_COLOR="\[$RED\]\\u@\\h\[$DEF\]"
  else
    USER_COLOR="\[$GRN\]\\u@\\h\[$DEF\]"
  fi

  PS1+="$USER_COLOR:\w$PROMPT_SYMBOL"

}