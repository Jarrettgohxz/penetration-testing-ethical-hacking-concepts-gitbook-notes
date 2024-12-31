---
description: Network port/service enumeration techniques with network-mapper (nmap).
---

# nmap

### TCP connect scan

`-sT`flag

> `-sT` (TCP connect scan) . TCP connect scan is the default TCP scan type when SYN scan is not an option. This is the case when a user does not have raw packet privileges or is scanning IPv6 networks. Instead of writing raw packets as most other scan types do, Nmap asks the underlying operating system to establish a connection with the target machine and port by issuing the connect system call.

Used when user does not have raw packet privileges.

### TCP SYN scan

`-sS`flag

> SYN scan is the default and most popular scan option for good reasons. It can be performed quickly, scanning thousands of ports per second on a fast network not hampered by restrictive firewalls. It is also relatively unobtrusive and stealthy since it never completes TCP connections.

Also known as _**half-open**_ scanning.

### UDP scan

`-sU` flag

> While most popular services on the Internet run over the TCP protocol, UDP \[6] services are widely deployed. DNS, SNMP, and DHCP (registered ports 53, 161/162, and 67/68) are three of the most common. Because UDP scanning is generally slower and more difficult than TCP, some security auditors ignore these ports.

### Window scan

`-sW` flag

> Window scan is exactly the same as `ACK` scan except that it exploits an implementation detail of certain systems to differentiate open ports from closed ones, rather than always printing unfiltered when a `RST` is returned.&#x20;

For certain systems, an open port will return a positive TCP window field size (even for `RST` packets), while closed ones will return a zero window size. This allows resolving the TCP port as closed/open rather than unfiltered when a `RST` is received.(as in the ACK scan).

### TCP ACK scan

`-sA`flag

> This scan is different than the others discussed so far in that it never determines open (or even open|filtered) ports. It is used to _**map out firewall rulesets**_, determining whether they are stateful or not and which ports are filtered.

For unfiltered systems, both open and closed ports will return a `RST` packet.

### Custom TCP scan

`--scanflags` flag

> Truly advanced Nmap users need not limit themselves to the canned scan types offered. The --scanflags option allows you to design your own scan by specifying arbitrary TCP flags.

### Other possible scan types

`-sY`, `-sN`, `-sF`,`-sX`, `-sM`, etc.

{% embed url="https://linux.die.net/man/1/nmap" %}

### Default port range

The default port range for most of the scan types above are the 1000 most popular port defined in the configuration file. (`/usr/share/nmap/nmap-services`?)

### Port options

| `-p-`      | all ports            |
| ---------- | -------------------- |
| `-p1-1023` | scan ports 1 to 1023 |

### Service/version info scan

```bash
$ nmap -sV <host>
```

For example, the following is a truncated output from Metasploitable 2:

```bash
21/tcp   open  ftp         vsftpd 2.3.4
22/tcp   open  ssh         OpenSSH 4.7p1 Debian 8ubuntu1 (protocol 2.0)
23/tcp   open  telnet      Linux telnetd
25/tcp   open  smtp        Postfix smtpd
...
```

### Idle/Zombie scan

`-sI` _zombie host_\[:_probeport_]

An _idle/zombie_ host is required. This host should be idle, and not have any other ongoing forms of interactions with the other devices in the network.

This scan works based on the fact that the TCP Identification (ID) field increments by 1 for every packet sent outward by a host on the network. The overview of the steps involved in an idle/zombie scan is highlighted:

1. Attacker sends a `SYN/ACK` packet to the idle host
   * The idle host will respond with a `RST` packet containing its IP header`ID` value
2. Attacker sends a TCP `SYN` scan packet to the target at the desired port, with the source IP address as that of the idle host
3. Attacker sends another `SYN/ACK`packet to the idle host, and determine if the target's port is open|filtered/close based on the updated IP header `ID` value (discussed below)

_**Consider the following scenarios:**_

_a) Target port is closed_

The IP header `ID` value will increment by 1 for the idle host from **step 1** above. In **step 2**, if the port on the target host is closed, it will respond with a `RST` packet, to which the idle host will not respond with anything.&#x20;

Overall, the IP header `ID` value incremented by _**1**_.



_b) Target port is open_

The IP header ID value increments by 1 from **step 1** mentioned above. In **step 2**, the target host will respond with a SYN/ACK packet, to which the idle host will respond with a RST packet (as the idle host did send any SYN packets). The IP header `ID` value increments by 1 again.

Overall, the IP header `ID` value incremented by **2**.
