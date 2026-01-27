- [Day 3 - Task ]()
  - [File System](#file-system)
  - [Process Management](#process-management)
  - [Networking troubleshooting](#networking-troubleshooting)

 Some useful shortcut for README file:<br>
 1. Alt + Shift + F → Format Document
 2. Ctrl + Shift + V → Preview Document



## File System ##
| Count | Command                              | How to write                           | Description                                                                                                 |
| ----- | ------------------------------------ | -------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| 1     | Present Working Directory            | <b>pwd</b>                             | Using given command we can see the present working directory.                                               |
| 2     | Create a Folder                      | <b>mkdir testDirectory </b>            | Using mkdir we create a directory/Folder                                                                    |
| 3     | Move/Change Directory/Folder         | <b>cd testDirectory </b>               | Using this command we can switch to the specified directory/folder.                                         |
| 4     | Remove Folder/Directory              | <b>rm -r [-f] testDirectoty </b>       | Using remove command we can delete the Directory. (-r delete recursively if that directoty contains files.) |
| 5     | Move Folder                          | <b>mv folder1/ folder2/ </b>           | Using given command we can move Folder/Directory.                                                           |
| 6     | Copy Folder                          | <b>cp -r folder1/ folder2/ </b>        | Using given command we can copy the entire folder/directory including files to another directory.           |
| 7     | Rename Directory                     | <b> mv oldFolderName NewFolderName</b> | Using given command we can rename the directory.                                                            |
| 8     | List File/Folder                     | <b>ls   </b>                           | Using the ls command we can get the list of files and Folders present in current working directory.         |
| 9     | Get Details of File/Folder           | <b>ls -l    </b>                       | Using ls -l we can get the details of files and folders in current working directory.                       |
| 10    | Show hidden File/Folder              | <b>ls -a </b>                          | using ls -a command we can get the hidden file and folders of current working directory.                    |
| 11    | Show hidden File/Folder with Details | <b>ls -la   </b>                       | Using -la combination we can get the details of file and folders including hidden ones.                     |
| 12    | Sort File/Folder                     | <b>ls -t  </b>                         | Using ls -t command we can sort the file and folders, It will sort with recenet modified files.             |
| 13    | Move to one level up                 | <b>cd ..    </b>                       | Using this command we can move to one level up in folder.                                                   |
| 14    | Create File                          | <b>touch sample.txt </b>               | Using the touch command we can create a file in current working directory.                                  |
| 15    | Show File Content                    | <b>cat filename   </b>                 | Using given command we can show the file content.                                                           |
| 16    | Show File Content with Line Number   | <b>cat -b filename  </b>               | Using given command we can show the file content with line number.                                          |
| 17    | Open file in console                 | <b>open filename  </b>                 | Using open command we can open the file in console.                                                         |
| 18    | Fetch first 10 lines from file       | <b>head filename   </b>                | Using given command it will fetch the first 10 row from file.                                               |
| 19    | Fetch first 'n' lines from file      | <b>head -n 2 filename </b>             | Using given command it will fetch the first 2 lines from file.                                              |
| 20    | Fetch last 10 lines from file        | <b>tail filename       </b>            | Using given command it will fetch the last 10 row from file.                                                |
| 21    | Fetch last 'n' lines from file       | <b>tail -n 2 filename   </b>           | Using given command it will fetch the last 2 lines from file.                                               |
| 22    | Fetch Entire content                 | <b>tail -n +1 filename   </b>          | Using given command it will fetch the entire content of file.                                               |
| 23    | Remove file                          | <b>rm -f filename       </b>           | Using given command we can remove the file.                                                                 |
| 24    | Locate file or Folder                | <b>locate filename/foldername</b>      | Using given command we can locate the file or folder, It return the full path.                              |



## Process Management ##
| Count | Command                                 | How to write  | Description                                                                                                 |
| ----- | --------------------------------------- | ------------- | ----------------------------------------------------------------------------------------------------------- |
| 1     | Show Current Process                    | <b>ps</b>     | Using given command we can get the current process.                                                         |
| 2     | Show Full Details of Process            | <b>ps aux</b> | Using given command we can get the full details of current process.                                         |
| 3     | Real Time Process Monitor               | <b>top</b>    | Using given command we can monitor the real time process.                                                   |
| 4     | Real Time Process Monitor (Interactive) | <b>htop</b>   | Using given command we can get the interactive monitor sysytem.                                             |
| 5     | Advanced system & process monitor       | <b>atop</b>   | Using given command we can monitor the process in ehganced way, It give the reult since system got started. |


## Networking troubleshooting ##
| Count | Command                  | How to write                   | Description                                                            |
| ----- | ------------------------ | ------------------------------ | ---------------------------------------------------------------------- |
| 1     | Ping any webpage         | <b>ping "Name of website" </b> | Using the given command we can check the if wep page in runing or not. |
| 2     | Get ip address of host   | <b>ip addr</b>                 | Using given command we get the ip address assigned to interface        |
| 3     | Show network interfaces  | <b>ifconfig</b>                | Using given command we can show the network interfaces                 |
| 4     | show hostname of systerm | <b>hostname</b>                | Using given command we can get the host name of system.                |