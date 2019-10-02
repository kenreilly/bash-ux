#!/usr/bin/env bash

declare -g -x _key_input=''
declare -g -x _key_last=''
declare -g -x _stty_config=''

function _read_key() { IFS='' read -n1 -r -t 0.01 $1 2>/dev/null; }

function get_last_key() { echo "$_key_last"; }

function input_process() {

	_read_key _key_input
	[ ! -z $_key_input ] && _key_last=$_key_input

	# TODO - Process Input
}

function input_init() {

	_stty_config=$(stty -g);
	stty raw -echo -isig -ixon -ixoff time 0 2>/dev/null
}