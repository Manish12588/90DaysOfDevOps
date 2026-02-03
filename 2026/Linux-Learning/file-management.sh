#!/bin/bash

# This script demonstrates various Linux commands with explanatory text

# Color codes for better readability
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print section headers
print_header() {
    echo -e "\n${BLUE}========================================${NC}"
    echo -e "${YELLOW}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

# Function to print command being executed
print_command() {
    echo -e "${GREEN}Command:${NC} $1"
    echo -e "${GREEN}Purpose:${NC} $2"
    echo "---"
}

# ============================================
# FILE MANAGEMENT
# ============================================

print_header "1. PRESENT WORKING DIRECTORY"
print_command "pwd" "Shows the present working directory."
pwd

print_header "2. LISTING FILES AND DIRECTORIES"
print_command "ls -la" "List all files including hidden ones with detailed information"
ls -la

print_header "3. CREATING DIRECTORIES"
print_command "mkdir -p test_dir/sub_dir" "Create nested directories (parent and child)"
mkdir -p test_dir/sub_dir
echo "Created: test_dir/sub_dir"
print_command "tree test_dir" "Validate the created directories."
tree test_dir

print_header "4. CREATING FILES"
print_command "touch test_dir/sub_dir/sample.txt" "Created text file inside sub_dir directory"
touch test_dir/sub_dir/sample.txt
echo "Created: sample.txt file"
print_command "tree test_dir" "Validate the directory after creating file."
tree test_dir

print_header "5. COPY FILE"
print_command "cp -rv test_dir/sub_dir/sample.txt -t test_dir/" "Copy file into directory."
cp -rv test_dir/sub_dir/sample.txt -t test_dir/
echo "Copy file into directory."
print_command "tree test_dir" "Validate the directory after copying file."
tree test_dir

print_header "6. MOVE/RENAME FILE"
print_command "mv -v test_dir/sub_dir/sample.txt -t test_dir/" "Move/Rename file into directory."
mv -v test_dir/sub_dir/sample.txt -t test_dir/
echo "Move/Rename file into directory."
print_command "tree test_dir" "Validate the directory after moving/copying file."
tree test_dir

print_header "7. EDIT FILE AND ADD TEXT"
print_command "echo 'this text added via terminal' > test_dir/sub_dir/sample.txt" "Adding text into file using echo command."
echo "this text added via terminal" > test_dir/sub_dir/sample.txt
echo "Text added into file via terminal"
print_command "cat test_dir/sub_dir/sample.txt" "Printing text from file."
cat test_dir/sub_dir/sample.txt

print_header "8. ADD MORE TEXT INTO FILE"
print_command "echo -e 'second line\nthird line\nfourth line\nfifth line' >> test_dir/sub_dir/sample.txt" "Updating the text in file."
echo -e 'second line\nthird line\nfourth line\nfifth line' >> test_dir/sub_dir/sample.txt
echo "Text Updated in file."
print_command "cat test_dir/sub_dir/sample.txt" "Printing updated text from file."
cat test_dir/sub_dir/sample.txt

print_header "9. FETCH TEXT FROM TOP OF FILE"
print_command "head test_dir/sub_dir/sample.txt -n 3" "Fetching the first 3 lines of file."
head test_dir/sub_dir/sample.txt -n 3
echo "Successfully fetch the record from file."


print_header "10. FETCH TEXT FROM BOTTOM OF FILE"
print_command "tail test_dir/sub_dir/sample.txt -n 3" "Fetching the last 3 lines of file."
tail test_dir/sub_dir/sample.txt -n 3
echo "Successfully fetch the record from file."


print_header "11. SEARCH FOR FILE IN DIRECTORY"
print_command "file -n test_dir/sub_dir/sample.txt" "Search for fine in directory hierarchy"
file -n test_dir/sub_dir/sample.txt
echo "Successfully serached."


print_header "12. SEARCH FOR TEXT PATTERN"
print_command "grep 'line' test_dir/sub_dir/sample.txt" "Search text 'line' in sample.txt file"
grep 'line' test_dir/sub_dir/sample.txt
echo "Successfully fecth the given pattern."

print_header "13. SEARCH FOR TEXT PATTERN RECURSEVELY"
print_command "grep -r 'line' test_dir/sub_dir/sample.txt" "Search text 'line' in sample.txt file"
grep -r 'line' test_dir/sub_dir/sample.txt
echo "Successfully fecth the given pattern."

print_header "14. SEARCH FOR TEXT PATTERN"
print_command "grep -v 'line' test_dir/sub_dir/sample.txt" "Fecth the text which does not have specified pattern."
grep -v 'line' test_dir/sub_dir/sample.txt
echo "Successfully fecth the text than given pattern."

print_header "15. FETCH THE FILE NAME WHICH CONTAINS SPECIFIED PATTERN"
print_command "grep -l 'line' *.txt" "Fecth the file name which contains the specified pattern"
grep -l 'line' *.txt
echo "Successfully fecth the text than given pattern."

print_header "16. REMOVE FILE"
print_command "tree test_dir" "Validating before remove file."
tree test_dir
print_command "rm test_dir/sub_dir/sample.txt" "Remove the file"
rm test_dir/sub_dir/sample.txt
echo "Successfully removed the file."
print_command "tree test_dir" "Validating after remove file."
tree test_dir


print_header "17. REMOVE DIRECTORY"
print_command "tree test_dir" "Validating before remove directory."
tree test_dir
print_command "rm -r test_dir/sub_dir" "Remove the directory"
rm -r test_dir/sub_dir
echo "Successfully removed the directory."
print_command "tree test_dir" "Validating after remove directory."
tree test_dir