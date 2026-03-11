#!/bin/bash
# Strict mode: Exit on error (-e), unset variables (-u), and pipe failures (-o pipefail)
set -euo pipefail

# System Information Script

# Function to display hostname and OS information
system_info() {
    echo "=============== Hostname & OS Info ================"
    echo "HostName : $(hostname)"         # Fetches the network name of the machine
    echo "Kernel   : $(uname -r)"         # Returns the Linux kernel release version
    echo "OS       : $(lsb_release -ds)"  # Returns the distribution description (e.g., Ubuntu 22.04)
    echo
}

# Function to display system uptime
system_uptime() {
    echo "=============== System Uptime ====================="
    # Shows time since boot, number of users, and system load (1, 5, 15 min averages)
    uptime                               
    echo
}

# Function to display top 5 disk usage
disk_usage() {
    echo "=============== Top 5 Disk Usage =================="
    # df -h: Report file system disk space usage
    # sort -hr -k5: Human-numeric sort (-h) in reverse (-r) based on the 5th column (Capacity%)
    # head -n 6: Limits output to the header plus the top 5 largest items
    df -h | sort -hr -k5 | head -n 6
    echo
}

# Function to display memory usage
memory_usage() {
    echo "=============== Memory Usage ======================"
    # Extracting specific fields from the 'free' command
    # $3=Used, $4=Free, $7=Available
    free -h | awk 'NR==2 {print "Used: " $3 " | Free: " $4 " | Available: " $7}'
    echo
}

# Function to display top 5 CPU-consuming processes
top_cpu_processes() {
    echo "=============== Top 5 CPU Processes ==============="
    # ps -eo: Custom output format (Process ID, Command Name, CPU percentage)
    # --sort=-%cpu: The minus sign indicates descending order
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
    echo
}

disk_usage_for_fail() {
    echo "=============== Adding to make pipeline fail =================="
    df -h | grep "/nonexistent_mount" | head -n 6  # grep returns exit 1 if no match
    echo
}

# Main function: Orchestrates the execution flow
main() {
    system_info
    system_uptime
    disk_usage
    memory_usage
    top_cpu_processes
    disk_usage_for_fail
}

# Execute the script
main