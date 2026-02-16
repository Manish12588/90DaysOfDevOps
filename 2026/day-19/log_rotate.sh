#!/bin/bash

set -euo pipefail

display_usage () {

    echo "Usage: ./log_rotate <path of your log file>"
}

#Checking the passed argument
if [ $# -eq 0 ]; then
    display_usage
fi

#Checking if log directory exist.
LOG_DIR=$1

if [ ! -d "$LOG_DIR" ]; then
    echo -e "ERROR: Directory '$LOG_DIR' does not exist"
    exit 1
fi



