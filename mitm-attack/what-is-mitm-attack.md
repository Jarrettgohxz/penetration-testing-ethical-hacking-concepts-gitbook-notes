---
description: Introduction to the Man-in-the-Middle attack.
---

# What is MitM attack?

Man-in-the-middle attack involves an attacker sitting in-between a client machine and a destination server, allowing interception of network traffic traversing between them. This would allow eavesdropping and modification of data/information, if encryption is not present: such as with HTTP and the default implementation of DNS. This form of attack can be done either on the public internet, or a private local area network (LAN). I will be focusing on the private LAN implementation for the following examples.

<mark style="color:red;">**PREVENTION MECHANISMS**</mark>

1. VPN
2. Firewall
   * ARP spoof prevention
   * Secure DNS
3. HTTPS over HTTP
   * Prevent sniffing and modification of data

Details about the prevention methods would be discussed further in the coming sections.
