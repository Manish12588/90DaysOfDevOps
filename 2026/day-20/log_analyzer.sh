#!/bin/bash

task-2() {
    grep -c "ERROR" $log_file_path
}

task-3() {

    #s/<pattern>/<replacement>/
    grep -n "CRITICAL" $log_file_path | sed 's/^/Line /'
}

task-4() {
    grep "ERROR" sample.log | awk '{$1=$2=$3=""; print}' | sed 's/ - [0-9]*$//' | sed 's/^[[:space:]]*//' | sort | uniq -c | sort -rn | head -5

}

task-5() {

    LOG_FILE="$log_file_path"
    DATE=$(date +%Y-%m-%d)
    REPORT_FILE="log_report_${DATE}.txt"

    LOG_FILENAME=$(basename "$LOG_FILE")
    TOTAL_LINES=$(wc -l < "$LOG_FILE")
    TOTAL_ERRORS=$(grep -c "ERROR" "$LOG_FILE")

    {
        echo "=============================================="
        echo "           LOG ANALYSIS REPORT"
        echo "=============================================="
        echo ""
        echo "1. DATE OF ANALYSIS    : $DATE"
        echo "2. LOG FILE NAME       : $LOG_FILENAME"
        echo "3. TOTAL LINES         : $TOTAL_LINES"
        echo "4. TOTAL ERROR COUNT   : $(task-2)"
        echo ""
        echo "=============================================="
        echo "      TOP 5 ERROR MESSAGES (by occurrence)    "
        echo "=============================================="
        echo ""
        echo "$(task-4)"
        echo ""
        echo "=============================================="
        echo "  LIST OF CRITICAL EVENETS WITH LINE NUMBER   "
        echo "=============================================="
        echo ""
        echo "$(task-3)"
        echo ""
        echo "=============================================="
        
    } > "$REPORT_FILE"
}

task-6() {

    if [ -d "archive/" ]; then
        echo "Folder exist"
    else
        mkdir -p $PWD/archive
    fi

    echo -e "\nMoving the Log Analysis Report to archive directory."
    mv $REPORT_FILE $PWD/archive
}


main (){

    if [ "$#" -ne 1 ]; then
        echo -e "\nPlease provide the log file path.\n"
        echo "Usage: $0 <log_file_path>"
        exit 1
    fi

    log_file_path="$1"

    if [ ! -e "$log_file_path" ]; then
        echo "Error: Provided log file '$log_file_path' doesn't exist."
        exit 1
    fi

    echo -e "\nTotal Number of Lines Contains 'ERROR' is :"
    task-2
    echo -e "\n--- Critical Events ---"
    task-3
    echo -e "\n--- Top 5 Error Messages ---"
    task-4
    echo -e "\n--- Creating Log Analysis Report ---"
    task-5
    echo -e "\n--- Archive the logs ---"
    task-6

}
main "$@"
