# Local Security Authority Subsystem Service (LSASS)

### Resources

1. **LSASS**

{% embed url="https://jumpcloud.com/it-index/what-is-the-local-security-authority-subsystem-service-lsass-exe" %}

2. **ProdDump**

{% embed url="https://learn.microsoft.com/en-us/sysinternals/downloads/procdump" %}

2. **Mimidrv**

{% embed url="https://medium.com/@matterpreter/mimidrv-in-depth-4d273d19e148" %}

3. **MITRE technique, OS Credential Dumping: LSASS Memory (T1003.001)**

{% embed url="https://attack.mitre.org/techniques/T1003/001/" %}

### What is LSASS?

Local Security Authority Server Service (LSASS) is a Windows process that handles the operating system security policy and enforces it on a system. The LSASS process stores user credentials in memory to enable users to access network resources, such as file shares and other network services, without needing to enter credentials each time.

Thus, the LSASS process is often targeted by attackers due to the sensitive information it contains about user accounts, to dump credentials for privilege escalation or lateral movement.

The following techniques can be used to exploit this (requires administrator privileges):

> As defined in the MITRE ATT\&CK framework: **OS Credential Dumping: LSASS Memory (T1003.001)**

### ProcDump

...

### Mimikatz









