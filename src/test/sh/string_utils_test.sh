#!/bin/bash

source ../../../bootstrap.sh

include_lib sh-logger
include_lib sh-unit

# SUT's
include_file $SRC_DIR_PATH/string_utils.sh

test_string_start_with() {
	string_start_with "Tester" "Tes"
	assert_true $?
	
	string_start_with "Tester" "tes"
	assert_false $?
}

test_string_end_with() {
	string_end_with "Tester" "ter"
    assert_true $?
    
    string_end_with "Tester" "Ter"
	assert_false $?
}

test_string_contains() {
	string_contains "Tester" "Tes"
    assert_true $?
    
    string_contains "Tester" "ter"
    assert_true $?
    
    string_contains "Tester" "T"
    assert_true $?
    
    string_contains "Tester" "Tester"
    assert_true $?
    
    string_contains "Tester" ""
    assert_true $?
    
    string_contains "" ""
    assert_true $?
    
    string_contains "" "tes"
    assert_false $?
    
    string_contains "Tester" "Ter"
	assert_false $?
}

run_all_tests_in_this_script