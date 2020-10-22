#!/bin/bash

source ../../../bootstrap.sh

include_lib sh-logger


get_local_ip() {
	log_info "Try get Local IP ..."
	COMMON_INTERFACES=("eth0" "wlan0")
	
	local IP=''
	
	for INTERFACE in "${COMMON_INTERFACES[@]}"
	do
        log_debug "Try interface: $INTERFACE"

		log_debug "Try mode (1)"
        IP=$(/sbin/ifconfig $INTERFACE | grep 'inet addr:' | cut -d':' -f2 | awk '{print $1}')
        log_trace "IP: |$IP|"
        if [[ "$IP" != "" ]]; then
            break
        fi

		log_debug "Try mode (2)"
        IP=$(/sbin/ifconfig $INTERFACE | grep 'inet ' | awk '{print $2}')
        log_trace "IP: |$IP|"
        if [[ "$IP" != "" ]]; then
            break
        fi
	done;
	
	eval "$1=$IP"
}