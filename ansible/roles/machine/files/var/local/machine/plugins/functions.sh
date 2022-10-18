#!/usr/bin/env bash

add_auth_key () {
    ssh-copy-id "$@"
}

extract () {
    if [ -f "$1" ] ; then
        case $1 in
            *.tar.bz2)        tar xjf     "$1"        ;;
            *.tar.gz)         tar xzf     "$1"        ;;
            *.bz2)            bunzip2     "$1"        ;;
            *.rar)            unrar x     "$1"        ;;
            *.gz)             gunzip      "$1"        ;;
            *.tar)            tar xf      "$1"        ;;
            *.tbz2)           tar xjf     "$1"        ;;
            *.tgz)            tar xzf     "$1"        ;;
            *.zip)            unzip       "$1"        ;;
            *.Z)              uncompress  "$1"        ;;
            *.7z)             7zr e       "$1"        ;;
            *)                echo        "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

dls () {
 # dls will list directories instead of files in the current working directory. 
 echo `ls -l | grep "^d" | awk '{ print $9 }' | tr -d "/"`
}

dgrep() {
    # A recursive, case-insensitive grep that excludes binary files
    grep -iR "$@" * | grep -v "Binary"
}

dfgrep() {
    # A recursive, case-insensitive grep that excludes binary files
    # and returns only unique filenames
    grep -iR "$@" * | grep -v "Binary" | sed 's/:/ /g' | awk '{ print $1 }' | sort | uniq
}

psgrep() {
    # pgrep, it shows the entire line of ps rather than just the PID
    if [ ! -z "$1" ] ; then
        echo "Grepping for processes matching $1..."
        ps aux | grep "$1" | grep -v grep
    else
        echo "!! Need name to grep for"
    fi
}

killit() {
    # Kills any process that matches a regexp passed to it
    ps aux | grep -v "grep" | grep "$@" | awk '{print $2}' | xargs sudo kill
}

# make a dir and cd into it
mkcd () {  
    mkdir -p "$@" && cd "$@" || exit
}

#copy and go to dir
cpcd () {
    if [ -d "$2" ];then
        cp "$1" "$2" && cd "$2" || exit
    else
        cp "$1" "$2"
    fi
}

#move and go to dir
mvcd () {
    if [ -d "$2" ];then
        mv "$1" "$2" && cd "$2" || exit
    else
        mv "$1" "$2"
    fi
}

portslay () {
    # If you need to kill a process on a particular port, but you don't know the process, portslay handles that.
    kill -9 `lsof -i tcp:$1 | tail -1 | awk '{ print $2;}'`
}

# Network utils

shell () {
  ps | pgrep `echo $$` | awk '{ print $4 }'
}

lso () {
  # display the permision in octal format
  ls -l "$@" | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(" %0o ",k);print}';
}


####
# Docker utils functions
####

docker_rmi_tag() {
  tag=${1-none}
  docker images | grep "$tag" | awk '{print $1 ":" $2}' | xargs docker rmi -f
}

####
# Python Virtual ENV
####
# Automatically activate Git projects' virtual environments based on the
# directory name of the project. Virtual environment name can be overridden
# by placing a .venv file in the project root with a virtualenv name in it
function workon_cwd {
    # Check that this is a Git repo
    GIT_DIR=$(git rev-parse --git-dir 2> /dev/null)
    if [ $? == 0 ]; then
        # Find the repo root and check for virtualenv name override
        GIT_DIR=$(cd "$GIT_DIR"|| pwd)
        PROJECT_ROOT=$(dirname "$GIT_DIR")
        ENV_NAME=$(basename "$PROJECT_ROOT")
        if [ -f "${PROJECT_ROOT}/.venv" ]; then
            ENV_NAME=$(cat "${PROJECT_ROOT}/.venv")
        fi
        # Activate the environment only if it is not already active
        if [ "$VIRTUAL_ENV" != "${WORKON_HOME}/${ENV_NAME}" ]; then
            if [ -e "$WORKON_HOME/$ENV_NAME/bin/activate" ]; then
              echo "Activated virtualenv ${ENV_NAME}."
              workon "${ENV_NAME}" && export CD_VIRTUAL_ENV="${ENV_NAME}"
            fi
        fi
    elif [ "${CD_VIRTUAL_ENV}" ]; then
        # We've just left the repo, deactivate the environment
        # Note: this only happens if the virtualenv was activated automatically
        echo "Deactivate virtualenv ${ENV_NAME}."
        deactivate && unset CD_VIRTUAL_ENV
    fi
}

# New cd function that does the virtualenv magic
function venv_cd {
    cd "$@" && workon_cwd
}

# function will perform the calculation for you.
# Additionally, if -si is the first argument, calculations are performed in SI units
size () {
    local -a units
    local -i scale
    if [[ "$1" == "-si" ]]
    then
        scale=1024
        units=(B KiB MiB GiB TiB EiB PiB YiB ZiB)
        shift
    else
        scale=1000
        units=(B KB MB GB TB EB PB YB ZB)
    fi
    local -i unit=0
    if [ -z "${units[0]}" ]
    then
        unit=1
    fi
    local -i whole=${1:-0}
    local -i remainder=0
    while (( whole >= $scale ))
    do
        remainder=$(( whole % scale ))
        whole=$((whole / scale))
        unit=$(( $unit + 1 ))
    done
    local decimal
    if [ $remainder -gt 0 ]
    then
        local -i fraction="$(( (remainder * 10 / scale)))"
        if [ "$fraction" -gt 0 ]
        then
            decimal=".$fraction"
        fi
    fi
    echo "${whole}${decimal}${units[$unit]}"
}

# Converts 40:b0:76:a3:36:54 to 40-B0-76-A3-36-54 format
mac_to_dashes() {
    echo $1 | sed s/:/-/g | tr a-f A-F
}

# Converts 40-B0-76-A3-36-54 to 40:b0:76:a3:36:54 format
mac_to_colons() {
    echo $1 | sed s/-/:/g | tr A-F a-f
}

# Git aliases (technically, functions)
gfa() {
    git fetch --all
}

grb() {
    case $1 in
        ''|*[!0-9]*) git rebase $1 ;;
        *) git rebase -i HEAD~$1 ;;
    esac
}

grbc() {
    git rebase --continue
}

grbm() {
    local _branches=$(git branches --remote)

    if printf '%s' "$_branches" | grep -q 'upstream/main '; then
        git rebase upstream/main $*
    elif printf '%s' "$_branches" | grep -q 'upstream/master '; then
        git rebase upstream/master $*
    elif printf '%s' "$_branches" | grep -q 'origin/main '; then
        git rebase origin/main $*
    else
        git rebase origin/master $*
    fi
}

# 'git checkout master' for a particular file
gcm() {
    local _branches=$(git branches --remote)

    if printf '%s' "$_branches" | grep -q 'upstream/main '; then
        git checkout upstream/main $*
    elif printf '%s' "$_branches" | grep -q 'upstream/master '; then
        git checkout upstream/master $*
    elif printf '%s' "$_branches" | grep -q 'origin/main '; then
        git checkout origin/main $*
    else
        git checkout origin/master $*
    fi
}

grm() {
    git rm $*
}

# systemctl will gain a new log "verb" that provides the missing 
# functionality. No more wasting time retyping tedious commands
systemctl() { 
    if [[ "${1-}" == "log" ]]; then  
        /usr/bin/journalctl -u "${@:2}"; 
    else /usr/bin/systemctl "$@";
    fi 
}