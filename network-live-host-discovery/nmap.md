---
description: Live host discovery techniques with network-mapper (nmap).
---

# nmap

### No port scan (host discovery only)

`-sn` flag; different from `-sN`

> Nmap, by default, uses a ping scan to find live hosts, then proceeds to scan live hosts only.
>
> This option tells Nmap not to do a port scan after host discovery, and only print out the available hosts that responded to the scan. This is often known as a _**ping scan**_

```bash
$ nmap [host] -sn

# eg. 
# -n for no DNS resolution 
$ nmap 10.10.0.1-5 -n -sn
Starting Nmap 7.94SVN ( https://nmap.org ) at 2024-12-15 17:45 +08
Nmap scan report for 10.10.0.1
Host is up (0.35s latency).
Nmap done: 5 IP addresses (1 host up) scanned in 7.33 seconds
```

### ICMP ping types

1. `-PE`

* ICMP type 8 (Echo request). A reply of type 0 (Echo reply) indicates availability. This option is commonly blocked by firewalls. The next few optios can be used instead, and may give results against some networks that may have forgotten about it.
* Note that this option is the default implemented by nmap. However, yhe `-PE` flag explicitly forces nmap to send ICMP Echo Requests to discover live hosts, essentially overriding or specifying this method for the scan.

2. `-PP`

* ICMP type 13 (Timestamp request). A reply of type 14 (Timestamp reply ) indicates availability.

3. `-PM`&#x20;

* ICMP type 17 (Address mask query). A reply of type 18 (Address mask reply) indicates availability.

### Other types of ping scans

_Note_: When the term _**ping scan**_ is mentioned in the context of `nmap`, it doesn't refer to the traditional ICMP Echo request packet (ping), but is rather a broader term for the packet sent to "ping" a host and discover if its alive, such as: TCP, UDP, SCTP and even ICMP packets itself.

_`Port list`_: Refers to the range of ports to send the ping scan.&#x20;

> Examples are `-PS22` and `-PS22-25,80,113,1050,35000`. Note that there can be no space between `-PS` and the _port list_. If multiple probes are specified they will be sent in paralle

**TCP**

a) TCP SYN

`-PS`_port list_

b) TCP ACK

`-PA`_port list_

_Default ports for TCP SYN and ACK ping scan is port_ `80`&#x20;

```bash
# eg. TCP ping scan commonly open ports 
$ sudo nmap -PS22,80,443
$ sudo nmap -PA22,80,443
```

_**UDP**_&#x20;

a) `-PU` _port list_

_Default ports for UDP ping scan is port_ `40125`

```bash
# eg. UDP ping scan commonly open ports 
$ sudo nmap -PU53,161,162
```

> If an open port is reached, most services simply ignore the empty packet and fail to return any response. This is why the default probe port is 40125, which is highly unlikely to be in use.

_**SCTP INIT**_

a) `-PY` _port list_

_The default port for SCTP INIT ping scan is port_ `80`

```bash
# eg.
$ sudo nmap -PY36412,7,116,2905,386
```

{% embed url="https://linux.die.net/man/1/nmap" %}
