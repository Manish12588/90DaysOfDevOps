#!/bin/bash

read -p "Pass a number to check local variable usage: " first_number
echo -e "\nPrinting outside the function: " $first_number


function_for_local_variable() {

        local localVar=$1
        echo -e "\nlocal variable output from function: " $(($localVar + 10))

}

function_for_local_variable $first_number
echo -e "\nAfter calling the function now again printing the value of number: " $first_number
echo -e "\nLocalVar outside the function: "$localVar " Default: LocalVar can't access outside\n"



