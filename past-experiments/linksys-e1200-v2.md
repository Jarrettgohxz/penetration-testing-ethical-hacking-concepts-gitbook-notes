# Linksys E1200(V2)

## 1. Initial research on router model

### 1.1 Google dork

### 1.2 FCC

...



## 2. Hardware overview



## 3. System enumeration (external)

### 3.1 Automatic IP lease (DHCP)

An ethernet cable will be used to connect the "Ethernet" port of the router and a test machine (running Ubuntu OS). We will be using Wireshark to view the live network traffic flowing between the router and test machine.

Right after the ethernet cable is plugged in, a bunch of network traffic starts flowing on the Wireshark screen. The particular type of traffic of interest would be **DHCP:**

_\[...insert wireshark view]_



From the image, we can see the [DHCP DORA ](https://www.pynetlabs.com/what-is-dhcp/)process: Discover, Offer, Request, ACK.

### 3.2 Network services scan (Nmap)

* `<host>` will be the IP address of the local gateway (eg. **192.168.1.1**)

### TCP scan

```shellscript
$ sudo nmap -sS -p- -T4 -n -Pn  <host>
```

_\[...insert TCP scan results]_

### UDP scan

```shellscript
$ sudo nmap -sU -F -T4 -n -Pn --max-retries 1 <host>
```

> Note: UDP scans are much slower than TCP because they often don't receive a response, forcing Nmap to wait for a timeout

Hence, the following flags can be used to make the UDP scan more efficient::

1. &#x20;`--max-retries` is important to cap the max retransmission for UDP scans
2. `-F` scans fewer ports

_\[...insert UDP scan results]_

#### Limitations of the UDP scan

Notice that this particular UDP scan did not return port 67, which is used in the DHCP process discussed earlier. We can perform another scan to confirm that this port is open:

```shellscript
$ sudo nmap -sU -p67 -n -Pn <host>
```

_\[...insert UDP -p67 scan results]_

### Targeted TCP+UDP scan

Now that we have discovered the open TCP and UDP ports, we can perform a targeted scan on the found ports. This will involve the following additional scan types:

1. `-sC`: default script scan
2. `-sV`: version detection

{% code overflow="wrap" %}
```shellscript
$ sudo nmap -sC -sV -p T:<found_TCP_ports>,U:<found_UDP_ports> -n -Pn --max-retries 1 <host>

# eg.
$ sudo nmap -sC -sV -sS -sU -p T:80,U:53,1900 -n -Pn --max-retries 1 192.168.1.1
```
{% endcode %}

_\[...insert combined scan results]_

Refer to the following links for more information on the Nmap options:

{% embed url="https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/2-network-port-scan-services-enumeration/nmap" %}

{% embed url="https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/tools-services/network-recon-and-attacks/nmap-general-overview#scan-optimization" %}



## 4. System enumeration (via shell)

