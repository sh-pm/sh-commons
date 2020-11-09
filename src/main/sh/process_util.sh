ensure_only_one_instance_run(){	
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