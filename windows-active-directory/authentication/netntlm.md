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

This will trick the server to communicate with the rogue server (running Responder tool) instead of the legitimate device, to capture the NTLM challenge, where we can proceed to crack it and potentially retrieve a user password.





