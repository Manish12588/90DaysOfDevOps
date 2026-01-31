- [Day 5 - Task ]()
  - [Read and Write Text File](#read-and-write-text-file)

 Some useful shortcut for README file:<br>
 1. Alt + Shift + F → Format Document
 2. Ctrl + Shift + V → Preview Document


## Read and Write Text File ##

1. **Creating a file**
      1. Using the given command it will crete a text file.

            touch notes.txt

            ![](Images/create-file.png)

2. **Adding content to notes file**
      1. Using the given command it will add the text to file.

            echo "This line added into notes file using echo" > notes.txt

            ![](Images/add-text-to-file.png)

            <b> Note: If you will run this command again the existing text will get override.

3. **Append the text into notes file**
      1. Using the given command it will append the text into file.

            echo "This is second line of file by adding >> command" >> notes.txt

            ![](Images/append-text-into-file.png)

4. **Display the conent of file on terminal**
      1. Using the given command it will display the content of file on terminal.

            cat notes.txt

            ![](Images/display-text.png)

5. **Read the text of file from top**
      1. Using the given command it will read the text from top of file.

            head -n 4 notes.txt

            ![](Images/head-from-file.png)

6. **Read the text of file from bottom**
      1. Using the given command it will read the text from bottom of file.

            tail -n 4 notes.txt

            ![](Images/tail-from-file.png)

7. **Writing text to file using tee**
      1. Using the given command it will write the text to file and at the same time display on terminal.

            echo "Line updated using tee command." | tee -a notes.txt

            ![](Images/update-file-using-tee.png)            