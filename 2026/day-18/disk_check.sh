#!/bin/bash

check_disk() {

	echo -e "Checking the usage of root:"
	df -h | awk 'NR==1 || NR==2{print $3," ",$5}'
	echo -e "\n"
}

check_memory() {

	echo -e "Checking free memory:"
	free -h | awk 'NR==1 || NR ==2{print $3}'
	echo -e "\n"
}

#calling the functions 
main() {

	check_disk
	check_memory
}
main

