#!/bin/bash

source ../../../bootstrap.sh

include_lib sh-logger
include_lib sh-unit

# SUT's
include_file $SRC_DIR_PATH/file_util.sh

test_is_existing_folder() {
	is_existing_folder /tmp
	assert_true $?
	
	is_existing_folder /tmpx
	assert_false $?
}

test_is_empty_folder() {
	
	FOLDER4TEST=/tmp/folder4test

	if $( is_existing_folder $FOLDER4TEST ); then
		rm -rf $FOLDER4TEST
	fi
	
	mkdir $FOLDER4TEST
	
	is_empty_folder $FOLDER4TEST	
	assert_true $?
	
	touch $FOLDER4TEST/lixotmp.txt
	is_empty_folder $FOLDER4TEST
	assert_false $?
}


run_all_tests_in_this_script