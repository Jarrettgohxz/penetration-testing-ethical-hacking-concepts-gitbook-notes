# Psexec (\*\*pending test)

{% embed url="https://learn.microsoft.com/en-us/sysinternals/downloads/psexec" %}

> PsExec is a light-weight telnet-replacement that lets you execute processes on other systems, complete with full interactivity for console applications, without having to manually install client software. PsExec's most powerful uses include launching interactive command-prompts on remote systems and remote-enabling tools like IpConfig that otherwise do not have the ability to show information about remote systems.

PsExec connects on port 445/TCP (SMB), and requires the supplied username to be part of the **Administrators** group on the remote machine.

### Basic commands

```powershell
psexec \\MACHINE_IP -u <username> -p <password> -i <remote_command>

# eg. to get a shell on a remote server using admin credentials
psexec \\MACHINE_IP -u Administrator -p pass1234 -i cmd.exe
```
