#!/bin/bash

set -euo pipefail

undefined_variable() {

	echo -e "set -u: undefined_variable()\n"

	firstName="Manish"
	fullName="$firstname, Kumar"
	echo "$fullName"

	echo "At the end of undefined_variable function."
}


fail_command() {

	echo -e "set -e: fail_command()\n" 
	echo "Command:  df -h | awk'NR==1'"

	df -h | awk'NR==1'

	echo "At the end of fail_command function."
}

pipeline_fail() {

	echo -e "set -o pipeline: pipeline_fail()"
	echo "Command:  df -h | awk'{print$1} | sort'"
	
	df -h | awk'{print$1}' | sort
	
	echo "at the end of pipeline_fail function."
}

main() {

	read -p "Please choose one function (undefined_variable, fail_command, pipeline_fail) for which you wanted to see output: " functionName
	case $functionName
	in
		undefined_variable) undefined_variable ;;
		fail_command) fail_command ;;
		pipeline_fail) pipeline_fail ;;
		*) echo "Please pass correct function name."
			exit;;
	esac


}
main
