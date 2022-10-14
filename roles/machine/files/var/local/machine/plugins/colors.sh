#!/usr/bin/env bash

colors_data_dir="/var/local/machine/lib/colors"


#-------------------------------------------------------------------------+
#Color picker, usage: printf $BLD$CUR$RED$BBLU'Hello World!'$DEF          |
#-------------------------+--------------------------------+--------------+
#       Text color             |       Background color                   |
#--------------+---------------+--------------+------------------+------- |
# Base color   | Lighter shade | Base color   | Lighter shade    | Color  |
#--------------+---------------+--------------+------------------+------- |
BLK='\e[0;30m'; blk='\e[2;90m'; BBLK='\e[40m'; bblk='\e[0;100m' #| Black  |
RED='\e[0;31m'; red='\e[2;91m'; BRED='\e[41m'; bred='\e[0;101m' #| Red    |
GRN='\e[0;32m'; grn='\e[2;92m'; BGRN='\e[42m'; bgrn='\e[0;102m' #| Green  |
YLW='\e[0;33m'; ylw='\e[2;93m'; BYLW='\e[43m'; bylw='\e[0;103m' #| Yellow |
BLU='\e[0;34m'; blu='\e[2;94m'; BBLU='\e[44m'; bblu='\e[0;104m' #| Blue   |
MGN='\e[0;35m'; mgn='\e[2;95m'; BMGN='\e[45m'; bmgn='\e[0;105m' #| Magenta|
CYN='\e[0;36m'; cyn='\e[2;96m'; BCYN='\e[46m'; bcyn='\e[0;106m' #| Cyan   |
WHT='\e[0;37m'; wht='\e[2;97m'; BWHT='\e[47m'; bwht='\e[0;107m' #| White  |
GRY='\e[0;39m'; gry='\e[2;99m'; BGRY='\e[49m'; bgry='\e[0;109m' #| Grey   |
#-------------------------{ Effects }----------------------+--------------+
DEF='\e[0m'   #Default color and effects                                  |
BLD='\e[1m'   #Bold\brighter                                              |
DIM='\e[2m'   #Dim\darker                                                 |
CUR='\e[3m'   #Italic font                                                |
UND='\e[4m'   #Underline                                                  |
INV='\e[7m'   #Inverted                                                   |
COF='\e[?25l' #Cursor Off                                                 |
CON='\e[?25h' #Cursor On                                                  |
#----------------------{Symbols }-----------------------------------------|
FANCYX='\[\342\234\]\227'       # Fancy X symbol                          |
CHECKMARK='\[\342\234\]\223'    # Check mark symbol                       |
#------------------------{ Functions }------------------------------------+
# Text positioning, usage: XY 10 10 'Hello World!'                        |
XY(){ printf "\e[$2;${1}H$3"; }                                          #|
# Print line, usage: line - 10 | line -= 20 | line 'Hello World!' 20      |
line(){ printf -v _L %$2s; printf -- "${_L// /$1}"; }                    #|
# Create sequence like {0..(X-1)}, usage: que 10                          |
que(){ printf -v _N %$1s; _N=(${_N// / 1}); printf "${!_N[*]}"; }        #|
#-------------------------------------------------------------------------+

function readline_ANSI_escape() {
  if [[ $# -ge 1 ]]; then
    echo "$*"
  else
    cat  # Read string from STDIN
  fi | \
  perl -pe 's/(?:(?<!\x1)|(?<!\\\[))(\x1b\[[0-9;]*[mG])(?!\x2|\\\])/\x1\1\x2/g'
}

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1

[[ -f "${colors_data_dir}/lscolors/lscolors.sh" ]] && source "${colors_data_dir}/lscolors/lscolors.sh"

#[[ -f "${colors_data_dir}/dircolors/$DIR_COLORS_THEME" ]] && eval "$(dircolors -b ${colors_data_dir}/dircolors/$DIR_COLORS_THEME)"

export GREP_COLORS='sl=48;5;233;97:cx=40;37:mt=48;5;186;30:fn=49;38;5;197:ln=49;38;5;154:bn=49;38;5;141:se=49;38;5;81'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# for common 256 color terminals (e.g. gnome-terminal)
export TERM=xterm-256color