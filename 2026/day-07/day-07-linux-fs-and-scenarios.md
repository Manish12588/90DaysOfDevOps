- [Day 7 - Task ]()
  - [File System Hierarchy](#file-system-hierarchy)
    - [Core Directory](#core-directory)
  - [Scenario Practice 1](#scenario-practice-1)

 Some useful shortcut for README file:<br>
 1. Alt + Shift + F → Format Document
 2. Ctrl + Shift + V → Preview Document

## File System Hierarchy ##

1. ## Core Directory ##
      1. / (root)                          : The top of linux system, Every file and directory lives under root.
      2. /home (User Home Directory)       : It contains the home directory of regular users. (**Most Day-to-day user works happens here.**)
      3. /root (Root User Home Directory)  : Home Directory of root user.  
      4. /etc (Configuration File)         : Store system wide configuration file. (**Only Config file exists here, No binaries**)
      5. /var/log (Log File)               : Contains systerm and applications logs.
      6. /tmp (Temporary File)             : Temporary files.


## Scenario Practice 1 ##

A web application service called 'myapp' failed to start after a server reboot.<br>
What commands would you run to diagnose the issue?<br>
Write at least 4 commands in order.<br>

**Step 1: Check the status of service**

        systemctl status <serviceName>

Why: At first we will check the status of process whether it's running or not.       


**Step 2: Check if service is enabled with on boot**

        systemctl is-enabled <serviceName>

Why: Why because if systerm crash or reboot and for service on loaded attribute is disable. In that case we need to set this enabled.

**Step 2: Check the logs of service**

        journalctl -u <serviceName> -n 10

Why: Because with the help of logs we will get to know the reason for failing the services.