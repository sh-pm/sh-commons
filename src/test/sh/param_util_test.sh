#!/bin/bash

source ../../../bootstrap.sh

include_lib sh-logger
include_lib sh-unit

# SUT's
include_file $SRC_DIR_PATH/param_util.sh


#-- test_is_number_params_correct: start ------------------------------------
function_expecting_0_params() {
	is_number_params_correct 0 $@
	if [[ "$?" == "0" ]]; then
	   return $TRUE
	else
	   return $FALSE
	fi
}

function_expecting_1_params() {
	if is_number_params_correct 1 $@
	then 
		return $TRUE
	else
		return $FALSE
	fi
}

function_expecting_2_params() {
	if is_number_params_correct 2 $@
	then 
		return $TRUE
	else
		return $FALSE
	fi
}

test_is_number_params_correct() {
	function_expecting_0_params param1 param2
	assert_false $?
	
	function_expecting_0_params param1
	assert_false $?
	
	function_expecting_0_params
	assert_true $?
	
	function_expecting_1_params param1 param2
	assert_false $?
	
	function_expecting_1_params param1
	assert_true $?
	
	function_expecting_1_params
	assert_false $?
	
	function_expecting_2_params param1 param2 param3
	assert_false $?
	
	function_expecting_2_params param1 param2
	assert_true $?
	
	function_expecting_2_params param1
	assert_false $?
	
	function_expecting_2_params
	assert_false $?
}
#-- test_is_number_params_correct: end ------------------------------------

#-- test_check_number_of_params_required: start ------------------------------------
function2_expecting_0_params() {
	ensure_number_params_correct 0 $@
}

function2_expecting_2_params() {
	ensure_number_params_correct 2 $@
}

test_check_number_of_params_required() {
	assert_true $( function2_expecting_0_params ) 
	assert_false $( function2_expecting_0_params param )
	assert_false $( function2_expecting_0_params param param )
	assert_false  $( function2_expecting_2_params )
	assert_false $( function2_expecting_2_params param )
	assert_true $( function2_expecting_2_params param param )
}
#-- test_check_number_of_params_required: end ------------------------------------


run_all_tests_in_this_script