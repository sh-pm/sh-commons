#!/bin/bash

source ../../../bootstrap.sh

include_lib sh-logger
include_lib sh-unit

# SUT's
include_file $SRC_DIR_PATH/log_util.sh
include_file $SRC_DIR_PATH/string_util.sh

test_get_script_caller_name() {
	local RETURN=$( get_script_caller_name /tmp )
	assert_true $( string_end_with $RETURN "test_runner.sh" )  
}

run_all_tests_in_this_script