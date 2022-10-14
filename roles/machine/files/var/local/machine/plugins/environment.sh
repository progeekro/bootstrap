#!/usr/bin/env bash

# Enable seamless decompression of .gzip files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable direnv if it is available
[[ -x /usr/bin/direnv ]] && eval "$(direnv hook bash)"

# Avoid closing the shell by accident, if running in a local terminal
if [[ -z "$SSH_CONNECTION" ]]; then
    set -o ignoreeof
fi

######################
##  COMMAND PROMPT ###
######################
PROMPT_COMMAND='history -a'

# Various ENV variable settings
export EDITOR=nano

#################
##  LESS ENVS ###
#################
# Color for manpages in less makes manpages a little easier to read
export LESSOPEN="| /var/local/machine/lib/src-hilite-lesspipe.sh %s"
export LESS="-R"

export LESSHISTFILE=/dev/null
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;37m'

#############################
##  BASH HISTORY SETTINGS ###
#############################
export HISTTIMEFORMAT="%m-%d-%Y %H:%M:%S "
# Ignore duplicate entries in history
export HISTCONTROL=ignoreboth:erasedups
export HISTFILE=~/.histfile
# Increases size of history
export HISTSIZE=10000
export SAVEHIST=10000
export HISTIGNORE="&:ls:ll:la:l.:pwd:cd:..:...:exit:clear:clr:[bf]g:history"

################################
##  BASH COMPLETION SETTINGS ###
################################

# This line sets auto completion to ignore cases.
bind "set completion-ignore-case on"

# Turn off bell
#bind "set bell-style none"

# This line sets the completions to be listed immediately instead of 
# ringing the bell, when the completing word has more than one possible completion.
bind "set show-all-if-ambiguous On"

# This line sets the completions to be listed immediately
# instead of ringing the bell, when the completing word has 
# more than one possible completion but no partial completion can be made.
bind "set show-all-if-unmodified On"

# This lines sets completions to be appended by characters that indicate 
# their file types reported by the stat system call.
bind "set visible-stats On"

# Enable colors when completing filenames and directories.
bind "set colored-stats on"

# When a completion matches multiple items highlight the common matching prefix in color.
bind "set colored-completion-prefix on"

# Treat hypens and underscores as equivalent when completing.
bind "set completion-map-case on"

# Automatically append the / slash character to the end 
# of symlinked directories when completing.
bind "set mark-symlinked-directories on"


#auto expand ! variants upon space
bind "Space:magic-space"

SHOPT=$(which shopt)
if [ -z "${SHOPT}" ]; then
  shopt -s histappend        # Append history instead of overwriting
  
  # Correct minor spelling errors in cd command
  shopt -s cdspell
  # Automatically expand directory globs and fix directory 
  # name typos whilst completing.
  # Note, this works in conjuction with the cdspell option listed above.
  shopt -s direxpand dirspell

  # Enable the ** globstar recursive pattern in file and directory expansions.
  # For example:
  # ls **/*.txt will list all text files in the current directory hierarchy.
  shopt -s globstar

  shopt -s dotglob           # includes dotfiles in pathname expansion
  shopt -s checkwinsize      # If window size changes, redraw contents
  shopt -s cmdhist           # Multiline commands are a single command in history.
  shopt -s extglob           # Allows basic regexps in bash.
  shopt -s nocaseglob        # Case-insensitive globbing (used in pathname expansion)

  # which will perform the history expansion and give you another 
  # opportunity to modify the command before executing it.
  shopt -s histappend histverify
fi