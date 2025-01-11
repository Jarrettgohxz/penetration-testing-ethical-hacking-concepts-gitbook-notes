# impacket

> Impacket is a collection of Python3 classes focused on providing access to network packets. Impacket allows Python3 developers to craft and decode network packets in simple and consistent manner. It includes support for low-level protocols such as IP, UDP and TCP, as well as higher-level protocols such as NMB and SMB.

### List of available scripts

Run the following command to list all the available scripts:

`/usr/share/kali-menu/helper-scripts/impacket-scripts.sh`

```bash
$ /usr/share/kali-menu/helper-scripts/impacket-scripts.sh
impacket-addcomputer     impacket-getArch          impacket-mimikatz       impacket-rbcd           impacket-sniff
impacket-atexec          impacket-Get-GPPPassword  impacket-mqtt_check     impacket-rdp_check      impacket-sniffer
...
```



**impacket-smbserver**

```bash
$ impacket-smbserver -smb2support -username [smb_username] -password [smb_password] [sharename] [dir]
```

* -`smb2support`: SMB2 support (experimental!)
* `-username`, `-password`: Username and password combination required by the connecting user for authentication

**impacket-secretsdump**

```bash
# Simple usage
$ impacket-secretsdump -sam SAM -system SYSTEM target  
```

* `-sam`:  **SYSTEM** hive to parse
* `-system`:  **SAM** hive to parse
* `target`:  \[`[domain/]username[:password]@`] or `LOCAL` (if you want to parse local files)

**impacket-psexec**

```bash
# Simple usage
$ impacket-psexec -hashes LMHASH:NTHASH target
```

_**What is PsExec?**_

{% embed url="https://learn.microsoft.com/en-us/sysinternals/downloads/psexec" %}

* `-hashes`: NTLM hashes, format is `LMHASH:NTHASH`
* `target`: \[`[domain/]username[:password]@`]



{% embed url="https://www.kali.org/tools/impacket/" %}
