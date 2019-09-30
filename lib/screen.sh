#!/usr/bin/env bash

declare -A -x _config=(
	['delay']=0.1
)

declare -A -x _screen=(
	['rows']=$LINES
	['cols']=$COLUMNS
)

function draw_chars() {

	local x=$1
	local y=$2
	local s=$3

	printf "\033[${y};${x}H${s}"
}

function print_dimensions() {
	
	local str="[ ${_screen['cols']} x ${_screen['rows']} ]"
	local start=$((${_screen['cols']}-${#str}))

	draw_chars $start 1 "$str"
}

function screen_init() {

	clear
	_screen['cols']=$COLUMNS
	_screen['rows']=$LINES
}

function on_resize() {

	return [ $COLUMNS == ${_screen['cols']} ] && [ $ROWS == ${_screen['rows']} ] && 0 || 1
}

function screen_run() {

	local delay=${_config['delay']}

	while [ : ]; do
		[[ on_resize ]] && screen_init
		[[ $DEBUG == 1 ]] && print_dimensions
		sleep $delay
	done
}