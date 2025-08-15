# Psexec

{% embed url="https://learn.microsoft.com/en-us/sysinternals/downloads/psexec" %}

> PsExec is a light-weight telnet-replacement that lets you execute processes on other systems, complete with full interactivity for console applications, without having to manually install client software. PsExec's most powerful uses include launching interactive command-prompts on remote systems and remote-enabling tools like IpConfig that otherwise do not have the ability to show information about remote systems.

PsExec connects on port 445/TCP (SMB), and requires the supplied username to be part of the **Administrators** group on the remote machine.

### Basic commands

```powershell
psexec \\MACHINE_IP -u <username> -p <password> -i <remote_command>

# eg. (1) 
psexec \\MACHINE_IP -u Administrator -p pass1234 -i -s cmd.exe

# eg. (2) 
psexec \\MACHINE_IP -u Administrator -p pass1234 -i -s "<reverse_shell_payload>"
```

* `-s` : Run the remote process in the System account
* `-i` : Run the program so that it interacts with the desktop of the specified session on the remote system

> Note that eg. (1) may not work for certain situations, such as when the command is ran from a remotely accessed machine (eg. via **SSH**).
