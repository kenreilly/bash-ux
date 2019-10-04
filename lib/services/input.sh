#!/usr/bin/env bash

declare -g -x _key_input=''
declare -g -x __key_name=''
declare -g -x _stty_config=''
declare -g -x _esc=$( printf '\033')

function _read_key() { IFS='' read -n1 -r -t 0.01 $1 2>/dev/null; }

function get_last_key() { echo "$_key_name"; }

function process_input() {

	_read_key _key_input
	_parse_key $_key_input || return

	_key_name=$(get_key_name $_key_input)
	[[ $( is_direction $_key_name ) == 1 ]] && parse_direction $_key_name
}

function _parse_key() {

	[[ $_key_input == '' || $_key_input = $_esc ]] && return 1
	local key=$1

	[ $key == '[' ] || return 0
	_read_key _key_input
	_key_input=${key}${_key_input}
}

function input_init() {

	_stty_config=$(stty -g);
	stty raw -echo -isig -ixon -ixoff time 0 2>/dev/null
}