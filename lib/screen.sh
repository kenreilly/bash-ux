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
	local s="$3"

	printf "\033[${y};${x}H${s}"
}

function print_debug() {

	print_pid
	print_key
	print_dimensions
}

function print_dimensions() {
	
	local str="[ $(set_color 'cyan')${_screen['cols']}$(set_color) x $(set_color 'cyan')${_screen['rows']}$(set_color) ]"
	local start=$((${_screen['cols']}-$(str_length "$str")))
	draw_chars $start 1 "$str"
}

function print_pid() {

	local pid=$$
	local str="[ PID: $(set_color 'red')${pid}$(set_color) ]"
	draw_chars 1 1 "$str"
}

function print_key() {

	local key=$( get_last_key )
	local str="[ key: $(set_color 'light_green')${key}$(set_color) ]"
	local half_width=$(( ${_screen['cols']} / 2 ))
	local half_length=$(( $(str_length "$str") / 2))
	local start=$(( $half_width - $half_length ))
	draw_chars $start 1 "$str"
}

function screen_init() {

	clear
	_screen['cols']=$COLUMNS
	_screen['rows']=$LINES
}

function on_resize() {

	[[ $COLUMNS == ${_screen['cols']} ]] && [[ $LINES == ${_screen['rows']} ]] && echo 0 || echo 1
}

function screen_run() {

	local delay=${_config['delay']}

	while [ : ]; do

		[[ $(on_resize) == 1 ]] && screen_init
		[[ $DEBUG == 1 ]] && print_debug
	
		input_process
		sleep $delay
	done
}