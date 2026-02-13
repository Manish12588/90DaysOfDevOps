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

    top5bysize=$(df -h | (sed -u 1q; sort -r -k 5) | head -n 6 | column -t)
    echo -e "Disk Usage Top 5 by Size: \n"$top5bysize

}

memory_usage() {

    usedMemory=$(free -h | awk 'NR==1 || NR ==2{print $2}')
    echo -e "Memory Used: "$usedMemory

}

cpu_consuming_process() {

    cpu_process=$(ps aux --sort=-%cpu | head -n 6)
    echo -e "Top 5 CPU consuming process: \n"$cpu_process

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

