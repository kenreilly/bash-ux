#!/usr/bin/env bash

# Error Handling
function on_error() { echo "error: [ ${BASH_SOURCE[1]} at line ${BASH_LINENO[0]} ]"; }
set -o errtrace
# trap on_error ERR

# Alias Expansion
shopt -s expand_aliases
alias kwargs='(( $# )) && local'

# Kill Script Function
trap exit TERM
alias exit_script='kill -s TERM $$'

# Global config data
declare -A -x _config=(
	['delay']=.01
)
