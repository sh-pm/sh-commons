#!/bin/bash

source ../../../bootstrap.sh

include_lib sh-logger
include_lib sh-unit

# SUT's
include_file $SRC_DIR_PATH/file_util.sh

test_is_directory() {
	is_directory /tmp
	assert_true $?
	
	is_directory /tmpx
	assert_false $?
}

test_directory_is_empty() {
	
	FOLDER4TEST=/tmp/folder4test

	if $( directory_exists $FOLDER4TEST ); then
		rm -rf $FOLDER4TEST
	fi
	
	mkdir $FOLDER4TEST
	
	directory_is_empty $FOLDER4TEST	
	assert_true $?
	
	touch $FOLDER4TEST/lixotmp.txt
	directory_is_empty $FOLDER4TEST
	assert_false $?
}


run_all_tests_in_this_script