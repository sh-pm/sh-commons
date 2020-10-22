#!/bin/bash

source ../../../bootstrap.sh

include_lib sh-logger

##
 # Inside a function, check if the function received correct number of params expected.
 # Example:
 # 
 #  even_or_odd() {
 #
 #     if [[ is_number_params_correct 1 $@ ]]; then   <========EXAMPLE OF USE==========
 #      
 #       if (( $1 % 2 == 0 )); then
 #         echo "even"
 #       else
 #         echo "odd"
 #       fi
 #     else
 #       echo "Incorrect number of params!"
 #     fi
 #  }   
 #
 # @param $1: Number of expected params (NUM_PARAMS_EXPECTED)
 # @param $2: Number of params received in function. You must pass with $#
 #
 # @return $TRUE if function have correct number of params, $FALSE otherwise 
 ##
is_number_params_correct() {
	if [ $# -eq 0 ]; then
		local NUM_PARAMS_EXPECTED=0
	else 
		local NUM_PARAMS_EXPECTED=$1
	fi
	
    local FUNCTION_NAME=${FUNCNAME[1]}
    local NUM_PARAMS_RECEIVED=$(( $# - 1 )) # the first param is not a param of function under avaliation, is the number of param expected

	if [ $NUM_PARAMS_RECEIVED -ne $NUM_PARAMS_EXPECTED ]; then	    
		return $FALSE
	else
		return $TRUE
	fi
}

##
 # Used inside functions: Halt execution if function number of params is incorrect.
 #
 # @param $1: Number of expected params (NUM_PARAMS_EXPECTED)
 # @param $2: All params of function. You must pass with $#
 #
 # @return $TRUE if function have correct number of params, $FALSE otherwise 
 ##
check_number_of_params_required(){
	
	if [ $# -eq 0 ]; then
		local NUM_PARAMS_EXPECTED=0
	else 
		local NUM_PARAMS_EXPECTED=$1
	fi
	
    local FUNCTION_NAME=${FUNCNAME[1]}
    local NUM_PARAMS_RECEIVED=$(( $# - 1 )) # the first param is not a param of function under avaliation, is the number of param expected

	if [ $NUM_PARAMS_RECEIVED -ne $NUM_PARAMS_EXPECTED ]; then	    
		log_error "Illegal number of parameters. Function '$FUNCTION_NAME' expect $NUM_PARAMS_EXPECTED params but receive $NUM_PARAMS_RECEIVED"	    
		exit 1
	fi	
}

##
 # Alias to verify if path is a directory.
 #
 # @param $1: path to folder
 #
 # @return $TRUE if is folder/directory, $FALSE otherwise 
 ##
is_directory() {
  if [ -d "$1" ]; then
    # 0 = true
    return $TRUE 
  else
    # 1 = false
    return $FALSE
  fi
}



##
 # Alias to verify if file exists.
 #
 # @param $1: path to file
 #
 # @return $TRUE if exists, $FALSE otherwise 
 ##
file_exists() {
	if [ -e $1 ]; then
		return 0
	else  
    	return 1
	fi
}

##
 # Alias to verify if directory exists.
 #
 # @param $1: path to directory
 #
 # @return $TRUE if exists, $FALSE otherwise 
 ##
directory_exists() {
	if [ -d "$1" ]
	then
	    log_trace "Directory $1 exists."
    	return 0
    else
    	log_trace "Directory $1 NOT exists."  
    	return 1
	fi
}

##
 # Verify if directory is empty.
 #
 # @param $1: path to directory
 #
 # @return $TRUE if exists, $FALSE otherwise 
 ##
directory_is_empty(){
	if find "$1" -mindepth 1 -print -quit 2>/dev/null | grep -q .; then
		return $FALSE;
	else
		return $TRUE;
	fi
}

require_root_permission(){
	if [ $(id -u) != "0" ]; then
    	log_error "You must be a superuser to execute this script!"
    	exit 1
	fi
}

allow_only_one_instance_run(){	
	local SCRIPT_NAME=$(get_script_caller_name)	
	local THIS_SCRIPT_PID=$$
	
	log_debug "This script PID: $THIS_SCRIPT_PID"
		
	local NUMBER_OF_INSTANCES=`/bin/ps -fu $USER| grep "$SCRIPT_NAME" | grep -v "$THIS_SCRIPT_PID" | grep -v "grep" | awk '{print $2}'`  
	
	if [[ $NUMBER_OF_INSTANCES > 1 ]]; then
   		log_error "$SCRIPT_NAME already in execution"
   		log_error "Current instances:"
   		log_error `/bin/ps -fu $USER| grep "$SCRIPT_NAME" | grep -v "$THIS_SCRIPT_PID" | grep -v "grep"`
   		exit 1;
	fi	
}