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

```bash
$ 
```

**impacket-psexec**

```bash
$ 
```
