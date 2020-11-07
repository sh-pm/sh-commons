#!/bin/bash

source ../../../bootstrap.sh

include_lib sh-logger

string_start_with(){
	STRING=$1
	SUBSTRING=$2
	if [[ $STRING == "$SUBSTRING"* ]]; then
		echo $TRUE
		return $TRUE;
	else
		echo $FALSE
		return $FALSE;
	fi
}

string_end_with(){
	STRING=$1
	SUBSTRING=$2
	if [[ $STRING == *"$SUBSTRING" ]]; then
		echo $TRUE
		return $TRUE;
	else
		echo $FALSE
		return $FALSE;
	fi
}

string_contains(){
	STRING=$1
	SUBSTRING=$2
	if [[ $STRING == *"$SUBSTRING"* ]]; then
		echo $TRUE
		return $TRUE;		
	else
		echo $FALSE
		return $FALSE;
	fi
}