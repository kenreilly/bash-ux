#!/usr/bin/env bash

function str_length() {

	local str=$(echo "$1" | sed -E 's/\\033\[[0-9]+;[0-9]+m//g')
	printf ${#str}
}