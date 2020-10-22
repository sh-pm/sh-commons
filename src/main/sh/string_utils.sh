#!/bin/bash

source ../../../bootstrap.sh

include_lib sh-logger

string_start_with(){
	STRING=$1
	SUBSTRING=$2
	if [[ $STRING == "$SUBSTRING"* ]]; then
		return 0;
	else
		return 1;
	fi
}

string_end_with(){
	STRING=$1
	SUBSTRING=$2
	if [[ $STRING == *"$SUBSTRING" ]]; then
		return 0;
	else
		return 1;
	fi
}

string_contains(){
	STRING=$1
	SUBSTRING=$2
	if [[ $STRING == *"$SUBSTRING"* ]]; then
		return 0;
	else
		return 1;
	fi
}