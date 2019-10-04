#!/usr/bin/env bash
declare -g -x _DIR="$( cd "$(dirname "$0")" ; pwd -P )"
declare -g -x _ROOT="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"

source ${_ROOT}/base/config.sh
source ${_ROOT}/base/utility.sh
source ${_ROOT}/services/clock.sh
source ${_ROOT}/services/cursor.sh
source ${_ROOT}/services/input.sh
source ${_ROOT}/services/screen.sh
source ${_ROOT}/types/colors.sh
source ${_ROOT}/types/keys.sh

function _ux_init() { input_init && screen_init; }

function _ux_run() {

	while [ : ]; do

		[[ $(screen_resized) == 1 ]] && screen_reset
	
		process_input
		render_init
		render_cursor

		[[ $DEBUG == 1 ]] && print_debug
		clock_cycle
	done
}

function start() { _ux_init && _ux_run; }