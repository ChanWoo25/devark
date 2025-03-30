#! /bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_PATH="${SCRIPT_DIR}/$(basename "${BASH_SOURCE[0]}")"
source $SCRIPT_DIR/bash_functions.sh

# Path to the Bash binary
PrintInfo "BASH: $BASH"

# List of shell options enabled in this shell
PrintInfo "BASHOPTS: $BASHOPTS"

# Process ID of the current Bash shell
PrintInfo "BASHPID: $BASHPID"

# Associative array of defined aliases
PrintInfo "BASH_ALIASES: $(declare -p BASH_ALIASES 2>/dev/null)"

# Number of arguments passed to each function call
PrintInfo "BASH_ARGC: ${BASH_ARGC[@]}"

# Arguments passed to functions, in reverse order
PrintInfo "BASH_ARGV: ${BASH_ARGV[@]}"

# Associative array of shell commands
PrintInfo "BASH_CMDS: $(declare -p BASH_CMDS 2>/dev/null)"

# Line numbers corresponding to function call stack
PrintInfo "BASH_LINENO: ${BASH_LINENO[@]}"

# Source file names of the call stack
PrintInfo "BASH_SOURCE: ${BASH_SOURCE[@]}"

# Bash version info as an array
PrintInfo "BASH_VERSINFO: ${BASH_VERSINFO[@]}"

# Bash version as a string
PrintInfo "BASH_VERSION: $BASH_VERSION"

# Characters that break words during completion
PrintInfo "COMP_WORDBREAKS: $COMP_WORDBREAKS"

# Stack of directory history
PrintInfo "DIRSTACK: ${DIRSTACK[@]}"

# Effective user ID
PrintInfo "EUID: $EUID"

# Names of all shell functions in the call stack
PrintInfo "FUNCNAME: ${FUNCNAME[@]}"

# Groups the user belongs to
PrintInfo "GROUPS: ${GROUPS[@]}"

# Home directory path
PrintInfo "HOME: $HOME"

# Hostname of the machine
PrintInfo "HOSTNAME: $HOSTNAME"

# Hardware type
PrintInfo "HOSTTYPE: $HOSTTYPE"

# Internal Field Separator
PrintInfo "IFS: $IFS"

# Current line number in the script
PrintInfo "LINENO: $LINENO"

# Machine type string
PrintInfo "MACHTYPE: $MACHTYPE"

# Previous working directory
PrintInfo "OLDPWD: $OLDPWD"

# Whether Bash displays error messages for bad options
PrintInfo "OPTERR: $OPTERR"

# Index of next argument to be processed by getopts
PrintInfo "OPTIND: $OPTIND"

# Operating system name
PrintInfo "OSTYPE: $OSTYPE"

# Search path for commands
PrintInfo "PATH: $PATH"

# Exit status of last executed foreground pipeline
PrintInfo "PIPESTATUS: ${PIPESTATUS[@]}"

# Process ID of the parent process
PrintInfo "PPID: $PPID"

# Present working directory
PrintInfo "PWD: $PWD"

# Returns a different random number each time
PrintInfo "RANDOM: $RANDOM"

# Default variable for read command
PrintInfo "REPLY: $REPLY"

# Number of seconds since the shell was started
PrintInfo "SECONDS: $SECONDS"

# List of enabled shell options
PrintInfo "SHELLOPTS: $SHELLOPTS"

# Shell level (nested shell depth)
PrintInfo "SHLVL: $SHLVL"

# Real user ID
PrintInfo "UID: $UID"