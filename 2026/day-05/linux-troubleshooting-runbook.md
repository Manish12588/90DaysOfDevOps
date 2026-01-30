## Linux Troubleshooting Runbook

- [Day 5 - Task ]()
  - [Target Service](#target-service)
  - [Environment Basics](#environment-basics)
  - [File System Sanity](#file-system-sanity)
  - [Snapshot CPU and Memory](#snapshot-cpu-and-memory)
  - [Snapshot Disk and IO](#snapshot-disk-and-io)
  - [Snapshot Network](#snapshot-network)
  - [Logs Reviewed](#logs-reviewed)


 Some useful shortcut for README file:<br>
 1. Alt + Shift + F → Format Document
 2. Ctrl + Shift + V → Preview Document


## Target Service ##

**Service Name: hello-devops.service**<br>
**Process Name/ PID: 111019**<br>
**Expected Behaviour: This service just print the logs in every 5 second**<br>

1. **Check Service status**
      1. It shows the status of service if running or not

            systemctl status hello-devops-service

            ![](Images/Hello-devops-service.png)

2. **Get the Process**
      1. Using given command you can get the details of specific process by using process id

            ps aux | grep <proceesId> 

            ![](Images/Hello-devops-service-Process%20Id.png)


## Environment Basics ##

1. **Get username**
      1. Using given command you can get the username

            uname -a

            ![](Images/uname-a.png)

2. **Get Information of Linux distribution**
      1. It shows the information about Linux distribution (Linux Standard Base Release)

            lsb_release -a

            ![](Images/lsb_release.png)

3. **Get OS Identification data**
      1. Using the given command you can get the OS identification data

            cat /etc/os-release

            ![](Images/os-release.png)

4. **Load the data into shell and then get the OS Name and Running version**
      1. Using given command you can load the the data into shell

            . /etc/os-release

            echo "Running $NAME $VERSION_ID"

            ![](Images/variable-in-sheell.png)


## File System Sanity ##

1. **Use of this command**
      1. App failing to start, Systemd service crashing, Container not writing logs, Disk or iNode issue.

            mkdir /tmp/runbook-demo && cp /etc/hosts /tmp/runbook-demo/hosts-copy && ls -l /tmp/runbook-demo

            ![file-system-sanity](Images/file-system-sanity.png)


## Snapshot CPU and Memory ##

1. **Command = top**
      1. It shows the Real-time CPU usage, memory usage, load average

            top

            ![top](Images/top.png)

2. **Command = htop**
      1. It shows colourful readable UI, Scroll, Search, Kill Process and Pre-core CPU view

            htop

            ![htop](Images/htop.png)

3. **Command = ps with options**
      1. using the options with ps command you get the required information of running service like PIS, Memory, CPU

            ps -o pid,pcpu,pmem,comm -p 111019

            ![ps with options](Images/ps-with-options.png)


4. **Command = free -h**
      1. It shows Total Memory, Used Memory, Free Memory, Available Memory, Swap Usage

            free -h

            ![free usage](Images/free-h.png)

## Snapshot Disk and IO ##

1. **Command = df -h**
      1. It shows the disk usage per file system

            df -h

            ![df-h](Images/df-h.png)

2. **Command = du -sh /var/log**
      1. It shows the disk usage and generated logs file size in humand readble 

            du -sh /var/log

            ![du-sh](Images/du-sh.png)

3. **Command = iostat**
      1. It shows disk read/write rates

            iostat

            ![iostat](Images/iostat.png)


## Snapshot Network ##

1. **Command = ss -tulpn**
      1. It shows the TCP sockets, UDP sockets, Listening socket, process using socket, show numbers

            ss - tulpn

            ![ss-tulpn](Images/ss-tulpn.png)

2. **Command = netstat -tupln**
      1. It shows listening port, protocols, owning process

            netstat -tulpn

            ![netstat-tulpn](Images/netstat-tulpn.png)

3. **Command = curl**
      1. curl is a tool for transferring data from or to a server using URLs

            curl -I <service-endpoint>/ping

            ![iostat](Images/.png)


## Logs Reviewed ##

1. **Command = journalctl**
      1. It's a viewer of systemd logs, read logs from journald

            journalctl -u hello-devops.service -n 15

            ![journalctl](Images/journalctl.png)

2. **Command = save logs in file**
      1. Using give command we are showing the logs on terminal as well as saving in file under /tmp directory

            journalctl -u hello-devops.service -n 100 | tee /tmp/hello-devops-100.log

            ![jounralctl-savelogs](Images/journalctl-save-logs.png)
      
      2. Validate log file created or not

            cd /tmp

            ls -la

            ![](Images/log-file.png.png)

3. **Command = Fetch the logs from log file**
      1. Using given commnd you can fecth the logs from created log file

            tail -n 2 /tmp/hello-devops-100.log

            ![](Images/tail-logs.png)











