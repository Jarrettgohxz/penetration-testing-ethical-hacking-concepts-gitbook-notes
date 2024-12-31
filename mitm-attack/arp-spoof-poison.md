---
description: >-
  The Address Resolution Protocol (ARP) is a networking protocol used on a local
  network for address resolution, to discover the MAC/hardware address of a
  device associated with an IP address.
---

# ARP spoof/poison

This protocol involves a table keeps track of the IP address to MAC address mapping.  ARP spoofing involves manipulating and poisoning the ARP table of a device on a local network.&#x20;

In an ARP spoof attack, falsified and gratuitous ARP packets are sent to the target machine, in order to poison the ARP table. This essentialy tricks the target in believing that an IP address on a LAN rightfully linking to a different MAC address, now belongs to the attacker machine's MAC address.  This causes any outbound traffic to the destination IP address that have been spoofed to be redirected to the attacker machine instead.

The same falsified packets can be sent to the router gateway too, to redirect incoming traffic destined for the actual target device, to be sent to the attacker machine instead.

## dSniff's arpspoof tool

### Installation

```shell
$ sudo apt install dsniff
```

### Usage

```sh
$ sudo arpspoof -i <iface> -t <target_ip> <host_ip_to_spoof_as> 
```

Example: Run an ARP spoof attack on the interface **eth0**, targeting IP address <mark style="color:green;">**192.168.1.22**</mark> to redirect traffic intended for <mark style="color:green;">**192.168.1.254**</mark> to the attacker machine MAC address instead.

```sh
$ sudo arpspoof -i eth0 -t 192.168.1.22 192.168.1.254 
```

The **-r** flag can be used in conjunction with the **-t** flag to poison both the target and the host to be able to capture traffic coming from both directions.

To verify if the ARP spoof attack is successful

* Run the following command on the victim's machine to view the local ARP cache

```bash
$ arp -a
```

{% embed url="https://www.kali.org/tools/dsniff/" %}

## Other experimentation

### Windows defender firewall

I have experimented an ARP spoof attack on a Windows machine that has the built-in defender firewall enabled on a public network.&#x20;

From the results, it appears that the firewall does not block/filter ARP packets, and is not able to prevent a spoofing attempt.

### Elicit a false and non-existent IP address mapping in the ARP table

I have experimented with a technique whereby an IP address that does not exist on a LAN could have an entry added to a device's ARP table, mapping to an attacker controlled MAC address.&#x20;

As of now, I have not managed to find a full exploit with this technique, but rather use it to aid my understanding of how ARP works.&#x20;

_<mark style="background-color:red;">**NOTE**</mark>_: I am currently only theorizing on this concept, and it may not be completely accurate, or even relevant in real-life context. I am more than happy to receive any suggestions or constructive criticism!

#### When will a device send an ARP request?

When a device on a LAN needs to send traffic to a destination IP address, it would first consult it's own ARP table, to find the associated MAC address. If there is no entry present, it would send an ARP broadcast request. The device with the IP address would respond with an ARP reply, indicating it's own MAC address. Consequently, the IP-to-MAC address mapping would be added to the source device's ARP table cache.

#### Demonstration

Trick the device to send an ARP request

* Send a ICMP echo-request (ping) with the source IP address spoofed  ([https://github.com/Jarrettgohh/network-offensive-security-experimentations/blob/main/ping-spoof/ping-spoof.py](https://github.com/Jarrettgohh/network-offensive-security-experimentations/blob/main/ping-spoof/ping-spoof.py))

```python
from scapy.all import *

ip=IP()
ip.src=<fake_ip_to_add_to_target_cache> # Fake IP address to add into target's ARP cache table 
ip.dst=<target_ip> # Target IP address

icmp=ICMP()
icmp.type=8 # ping request

send(ip/icmp)
```

In response to the ping request, the target device would first search in it's own ARP cache, which it won't be able to find, after which it would send an ARP broadcast request looking for the MAC address associated with the source IP address of the ping packet.

Fake ARP replies can be sent to the target device claiming that <mark style="color:red;"><</mark>fake\_ip\_to\_add\_to\_target\_cache<mark style="color:red;">>is-at<</mark>attacker's MAC address<mark style="color:red;">></mark>, allowing a fake entry to be added to its ARP cache.

```sh
$ sudo arpspoof -i <iface> -t <target_ip> <fake_ip_to_add_to_target_cache> -r
```

#### Possible attack scenario (not tested)

There is a certain ARP spoofing prevention mechanism in some routers known as IP & MAC binding. This security feature aims to keep a record of the legitimate mapping between IP and MAC addresses on the LAN. If a rogue device tries to send falsified ARP packets in the case of an ARP spoof attack, the router will drop it if it doesn't match up with the record table.

This security mechanism only works if there is already an ARP table entry - to be referenced as the legitimate mapping.&#x20;

Let's assume the following process of a router (acting as the DHCP server) assigning an IP address to a new device connected to the network:

1. The DHCP server does not check its ARP cache to ensure that there are no existing IP address record that matches prior to offering an IP address
2. A gratuitous ARP broadcast message would be sent from the router (before it offers) and the device (when it receives an offer) to verify if this IP address already exists
3. The router updates its IP-MAC binding table in response to ARP messages (before an entry for a particular IP address exists in the ARP cache).

This assumption can be exploited, to flood the router's ARP table with fake MAC address mapping for all the other IP addresses that has not already been assigned a MAC address. This could lead to some potential consequences. For example, the subnet range assigned for the router on a particular interface is 192.168.1.0/28.&#x20;

* Subnet range: 192.168.1.1 - 192.168.1.14
* Network: 192.168.1.0
* Broadcast: 192.168.1.15

Assuming the following parameters:

* Gateway IP: 192.168.1.1
* Attacker IP: 192.168.1.2
* IP for the new device: 192.168.1.3

Attack scenario

1. Elicit an ARP broadcast message from the router for the IP addresses in the range: 192.168.1.3 - 192.168.1.14 - less the gateway and attacker's addresses.
2. A certain script could be used on the attacker machine to send gratuitous ARP replies to the router claiming that <mark style="color:red;"><</mark>fake\_ip\_to\_add\_to\_target\_cache<mark style="color:red;">>is-at<</mark>attacker's MAC address<mark style="color:red;">></mark>, where <mark style="color:red;">fake\_ip\_to\_add\_to\_target\_cache</mark> would be the IP address in the range described above.
   * Normally, the router would check the packets against its IP-MAC binding and drop the packets for a false ARP packet. However, in this case, there isn't an IP-MAC binding entry present.
   * The ARP cache of the router would be updated as follows:

```
192.168.1.3 at <attacker's MAC address>
192.168.1.4 at <attacker's MAC address>
...
```

2. Following, a new device joins the network and receives an IP address offer from the router. Prior to the offer, the router would send an ARP broadcast looking for the MAC address associated with the IP address it plans to offer. Since the MAC address mapped to the IP address is that of the attacker machine, all the other devices on the network would ignore the ARP broadcast, while the attacker machine itself could be simply configured to ignore it too. This would trick the router in thinking that the address is not in use, and move ahead with the process. The same technique could be used to trick the receiving device too.
3. Any outbound traffic from the new device would have the source IP address (that is mapped to the attacker's MAC address on the router's IP-MAC binding), but with a source MAC address that is its own
   * This causes the router to reject the packet as it contradicts the IP-MAC binding
   * Consequently, the device would experience a denial-of-service,  and be denied access to any local or public resources and services.&#x20;

#### Consequences

From the denial-of-service scenario of the device, it could lead to a social engineering situation, potentially acting as a precursor for further attacks such as evil twin attack:

{% embed url="https://jarrettgxz-sec.gitbook.io/offensive-security/mitm-attack/evil-twin-attack" %}

## <mark style="color:orange;">Prevention methods</mark>

#### 1. Virtual Private Network (VPN)

* Encrypts the data&#x20;

Even if the ARP spoof attack is successful, and an attacker is intercepting the network traffic, the data would be protected from sniffing and modification.

This effectively mitigates the consequences from an ARP spoof attack

#### 2. Third-party firewall provider

* ARP spoof packet filter

A third-party firewall provider would have rules or configuration options to detect and filter ARP spoofing attempts. This would prevent any malicious ARP packets from updating the local cache/table, effectively rendering the attack useless.

#### 3. Router security features

* Switch port security
* Static ARP entries
* IP & MAC binding
* Dynamic ARP inspection (DAI) with DHCP snooping
* Guest network client isolation

## Resources

{% embed url="https://www.mankier.com/8/arpspoof" %}
arpspoof examples
{% endembed %}

{% embed url="https://security.stackexchange.com/questions/277940/possible-workaround-for-ip-mac-binding-security-feature-on-routers" %}
Information Security Stack Exchange post
{% endembed %}

{% embed url="https://www.tp-link.com/us/configuration-guides/configuring_firewall/?configurationId=18571#anti_arp_spoofing_2_1" %}
TP-LINK router firewall IP-MAC binding
{% endembed %}
