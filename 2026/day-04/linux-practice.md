- [Day 4 - Task ]()
  - [Pre-requisite](#pre-requisite)
  - [Process Check](#process-check)
  - [Service Check](#service-check)
  - [Log Check](#log-check)

 Some useful shortcut for README file:<br>
 1. Alt + Shift + F → Format Document
 2. Ctrl + Shift + V → Preview Document


## Pre-requisite ##
### NOTE : To perform the process and service check steps we will create a dummy app which will run forever and log messages.
<details>
<summary> <b> STEPS TO CREATE HELLO-DEVOPS SERVICE <b> </summary>


1. **Step 1 - Create a folder "hello-devops-app" in opt under root directory**

    <b>Create Directory</b>:

            sudo mkdir -p /opt/hello-devops-app

2. **Step 2 - Create a file "hello-devops.sh" in "hello-devops-app"**

    <b>Create file</b>:

            sudo nano /opt/hello-devops-app/hello-devops.sh

    <b>Shell File Code</b>:

            #!/bin/bash

            while true
            do
            echo "Hello from DevOps service at $(date)"
            sleep 5
            done


3. **Step 3 - Make "hello-devops.sh" file executable**

    <b>To make file executable</b>:

            sudo chmod +x /opt/hello-devops-app/hello-devops.sh

    <b>To test the file </b>:

            opt/hello-devops-app/hello-devops.sh


4. **Step 4 - Create sysmtemd service**

    <b>Create Service</b>:

            sudo nano /etc/systemd/system/hello-devops.service

    <b>Service file code</b>:

            [Unit]
            Description=Hello World DevOps Service
            After=network.target

            [Service]
            ExecStart=/opt/hello-devops-app/hello-devops.sh
            Restart=always
            RestartSec=3

            [Install]
            WantedBy=multi-user.target         

    <b>To Validate the created service</b>:

            cd /etc/systemd/system

            ls -la    

5. **Step 5 - Load the service into systemd** 

            sudo systemctl daemon-reload


6. **Step 6 - Start and Manage the Service** 
   
    <b>Start Service</b>:

            sudo systemctl start hello-devops

    <b>Check Status</b>:

            systemctl status hello-devops

7. **Step 7 - View the logs** 
   
    <b>View log</b>:

            journalctl -u hello-devops

    <b>Follow live logs</b>:

            journalctl -u hello-devops -f

8. **Step 8 - Enable Service on boot** 
   
    <b>To Enable</b>:

            sudo systemctl enable hello-devops

    <b>To Check Status</b>:

            systemctl is-enabled hello-devops

</details>


## Process Check ##
<details>
<summary><b>Command = ps</b></summary>
Descriptions: ps displays information about a selection of the active processes.<br>
SYNOPSIS: ps [options]<br>
EXAMPLES

        To see every process on the system using BSD syntax:
          ps ax
          ps axu

       To see every process on the system using standard syntax:
          ps -e
          ps -ef
          ps -eF
          ps -ely

       To print a process tree:
          ps -ejH
          ps axjf

       To get info about threads:
          ps -eLf
          ps axms

       To get security info:
          ps -eo euser,ruser,suser,fuser,f,comm,label
          ps axZ
          ps -eM

       To see every process running as root (real & effective ID) in user format:
          ps -U root -u root u

          To see every process with a user-defined format:
          ps -eo pid,tid,class,rtprio,ni,pri,psr,pcpu,stat,wchan:14,comm
          ps axo stat,euid,ruid,tty,tpgid,sess,pgrp,ppid,pid,pcpu,comm
          ps -Ao pid,tt,user,fname,tmout,f,wchan

       Print only the process IDs of syslogd:
          ps -C syslogd -o pid=

       Print only the name of PID 42:
          ps -q 42 -o comm=


1. **Performed Process Check Commands** 
   
    <b>To get the running process with list</b>:

            ps -la

    <b>To fetch the specific process details with PID</b>:

            ps -lp "process-ID" Ex: ps -lp 111019

</details>

<details>
<summary><b>Command = top</b></summary>
Descriptions: The  top  program  provides  a  dynamic  real-time  view  of  a running system.  It can display system summary information as well as a list of processes or threads currently being managed by the Linux kernel.<br>
SYNOPSIS: top [options]<br>
</details>

<details>
<summary><b>Command = pgrep</b></summary>
Descriptions:  pgrep looks through the currently running processes and lists the process IDs which match the selection criteria to stdout.<br>
SYNOPSIS: pgrep [options]<br>

OPTIONS

       -signal
       --signal signal
              Defines the signal to send to each matched process.  Either the numeric or the symbolic signal name can
              be  used.  In  pgrep  or pidwait mode only the long option can be used and has no effect unless used in
              conjunction with --require-handler to filter to processes with a userspace signal handler present for a
              particular signal.

       -c, --count
              Suppress normal output; instead print a count of matching processes.  When count does  not  match  any‐
              thing,  e.g. returns zero, the command will return non-zero value. Note that for pkill and pidwait, the
              count is the number of matching processes, not the processes that were successfully signaled or  waited
              for.

       -d, --delimiter delimiter
              Sets the string used to delimit each process ID in the output (by default a newline).  (pgrep only.)

       -e, --echo
              Display name and PID of the process being killed.  (pkill only.)

       -f, --full
              The  pattern  is normally only matched against the process name.  When -f is set, the full command line
              is used.

       -g, --pgroup pgrp,...
              Only match processes in the process group IDs listed.  Process group  0  is  translated  into  pgrep's,
              pkill's, or pidwait's own process group.

              -G, --group gid,...
              Only  match  processes  whose real group ID is listed.  Either the numerical or symbolical value may be
              used.

       -i, --ignore-case
              Match processes case-insensitively.

       -l, --list-name
              List the process name as well as the process ID.  (pgrep only.)

       -a, --list-full
              List the full command line as well as the process ID.  (pgrep only.)

       -n, --newest
              Select only the newest (most recently started) of the matching processes.

       -o, --oldest
              Select only the oldest (least recently started) of the matching processes.

       -O, --older secs
              Select processes older than secs.

       -P, --parent ppid,...
              Only match processes whose parent process ID is listed.

       -s, --session sid,...
              Only match processes whose process session ID is listed.  Session ID  0  is  translated  into  pgrep's,
              pkill's, or pidwait's own session ID.
              -t, --terminal term,...
              Only match processes whose controlling terminal is listed.  The terminal name should be specified with‐
              out the "/dev/" prefix.

       -u, --euid euid,...
              Only  match  processes whose effective user ID is listed.  Either the numerical or symbolical value may
              be used.

       -U, --uid uid,...
              Only match processes whose real user ID is listed.  Either the numerical or  symbolical  value  may  be
              used.

       -v, --inverse
              Negates the matching.  This option is usually used in pgrep's or pidwait's context.  In pkill's context
              the short option is disabled to avoid accidental usage of the option.

       -w, --lightweight
              Shows  all  thread ids instead of pids in pgrep's or pidwait's context.  In pkill's context this option
              is disabled.

       -x, --exact
              Only match processes whose names (or command lines if -f is specified) exactly match the pattern.

       -F, --pidfile file
              Read PIDs from file.  This option is more useful for pkill or pidwait than pgrep.

       -L, --logpidfile
              Fail if pidfile (see -F) not locked.
               -r, --runstates D,R,S,Z,...
              Match only processes which match the process state.

       -A, --ignore-ancestors
              Ignore all ancestors of pgrep, pkill, or pidwait.  For example, this can be useful when elevating  with
              sudo or similar tools.

       -H, --require-handler
              Only match processes with a userspace signal handler present for the signal to be sent.

       --cgroup name,...
              Match on provided control group (cgroup) v2 name. See cgroups(8)

       --ns pid
              Match  processes  that  belong  to the same namespaces. Required to run as root to match processes from
              other users. See --nslist for how to limit which namespaces to match.

       --nslist name,...
              Match only the provided namespaces. Available namespaces: ipc, mnt, net, pid, user, uts.

       -q, --queue value
              Use sigqueue(3) rather than kill(2) and the value argument is used to specify an  integer  to  be  sent
              with  the signal. If the receiving process has installed a handler for this signal using the SA_SIGINFO
              flag to sigaction(2), then it can obtain this data via the si_value field of the siginfo_t structure.

       -V, --version
              Display version information and exit.
        -h, --help
              Display help and exit.

OPERANDS
       pattern
              Specifies an Extended Regular Expression for matching against the process names or command lines.

EXAMPLES

       Example 1: Find the process ID of the named daemon:

              $ pgrep -u root named

       Example 2: Make syslog reread its configuration file:

              $ pkill -HUP syslogd

       Example 3: Give detailed information on all xterm processes:

              $ ps -fp $(pgrep -d, -x xterm)

       Example 4: Make all chrome processes run nicer:

              $ renice +4 $(pgrep chrome)


</details>

## Service Check ##

1. **Systemctl** 
   
    <b>to check the status of running service</b>: It will give the status of all services

            systemctl status

    <b>To check the status of any specific service</b>:

            systemctl status hello-devops.service

2. **Systemctl list-units** 
   
    <b>To check the list of all services</b>:

            systemctl list-untis

3. **Most Usefule Commands for systemctl**

        systemctl start <service>
        systemctl stop <service>
        systemctl restart <service>
        systemctl status <service>
        systemctl enable <service>
        systemctl disable <service>
        systemctl daemon-reload


## Log Check ##

1. **NOTE - TO PLAY WITH THE LOGS YOU NEEDS TO UPDATE THE hello-devops.sh FILE** 
   
    <b>Update hello-devops.sh file</b>:

            sudo nano opt/hello-devops-app/hello-devops.sh

    <b>Changes needs to be done</b>:

            update sleep 5 to sleep abc

    <b>Restart the service</b>:

            sudo systemctl restart hello-devops

    <b>Check status </b>:

            systemctl status hello-devops
            

1. **journalctl** 
   
    <b>To fetch the all logs of any service</b>:

            journalctl -u hello-devops.service

    <b>To fecth the latest 10 log record of service</b>:

            journalctl -u hello-devops.service -f   

    <b>To fecth the log record of any service like 10 min before</b>:

            journalctl -u hello-devops.service --since "2 minute ago"

2. **Most Usefule Commands for systemctl**

        journalctl -u <service>
        journalctl -u <service> -f
        journalctl -xe
        journalctl --since "10 minutes ago"



