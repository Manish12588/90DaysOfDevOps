#!/bin/bash
set -euo pipefail

hostname_and_os_info() {

	osInfo=$(cat /etc/os-release | awk 'NR==1' | sed 's/PRETTY_NAME="//;s/"//')
	echo -e "HOSTNAME = $HOSTNAME\nOS_INFO = $osInfo"

}

system_uptime() {

    completeInformation=$(uptime)
    echo -e "Complete Information = "$completeInformation
    uptimeInPrettyFormat=$(uptime -p)
    echo -e "\nUptime in pretty formatio = "$uptimeInPrettyFormat
    systemUpSince=$(uptime -s)
    echo -e "\nSystem up since = "$systemUpSince

}

disk_usage() {

    echo -e "Disk Usage Top 5 by Size: \n"
    df -h | (sed -u 1q; sort -r -k 5) | head -n 6 | column -t
}

memory_usage() {

    echo -e "Memory Used: \n"
    free -h | awk 'NR==1 || NR ==2{print $2}'

}


cpu_consuming_process() {

    echo -e "Top 5 CPU consuming process: \n" 
    ps -eo pid,user,comm,%cpu,%mem --sort=-%cpu | head -n 6

}

main() {

	echo -e "\n===== INFORMATION ABOUT HOSTNAME AND OS ======\n"
	hostname_and_os_info
	echo -e "\n=============================================="


	echo -e "\n===== INFORMATION ABOUT THE SYSTEM UPTIME ======\n"
        system_uptime
        echo -e "\n=============================================="

	echo -e "\n===== TOP 5 DISK USAGE BY SIZE  ==============\n"
        disk_usage
        echo -e "\n=============================================="

	echo -e "\n===== TOTAL MEMORY USED  ====================\n"
        memory_usage
        echo -e "\n=============================================="


	echo -e "\n===== TOP 5 CPU CONSUMING PROCESS ===========\n"
        cpu_consuming_process
        echo -e "\n=============================================="

	

}
main

