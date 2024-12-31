---
description: General overview of useful commands used in the Network mapper (nmap) tool.
---

# nmap

Refer to the sections under _**NETWORK HACKING**_ for specific use cases.

For non-root users, some of the commands listed below may return an error message regarding root access privilege requirements, simply add **sudo** before the nmap command, followed by entering your account password to proceed.

```bash
sudo nmap ...
```

### Port number to service mapping data

`/usr/share/nmap/nmap-services`

### List Scan

> The list scan is a degenerate form of host discovery that simply lists each host of the network(s) specified, without sending any packets to the target hosts. By default, Nmap still does reverse-DNS resolution on the hosts to learn their names.

`-sL` flag

<pre class="language-bash"><code class="lang-bash">$ nmap [host] -sL

# eg. 
# -v for verbose and -n for no DNS resolution
<strong>nmap 10.10.0.1-5 -n -v -sL 
</strong>Starting Nmap ...( https://nmap.org ) at ...
Nmap scan report for 10.10.0.1
Nmap scan report for 10.10.0.2
Nmap scan report for 10.10.0.3
Nmap scan report for 10.10.0.4
Nmap scan report for 10.10.0.5
Nmap done: 5 IP addresses (0 hosts up) scanned in 0.00 seconds
</code></pre>

### Scan optimization&#x20;

The following methods listed below can be used to optimize scan speeds by removing unneccessary steps in the scan process. These steps may be needed at times, and may not be appropriate to be used at all times.

_**No DNS resolution**_

```bash
$ nmap -n <host>
```

_**No Ping scan**_

```bash
$ nmap -Pn <host>
```

> This option skips the Nmap discovery stage altogether. Normally, Nmap uses this stage to determine active machines for heavier scanning. By default, Nmap only performs heavy probing such as port scans, version detection, or OS detection against hosts that are found to be up. Disabling host discovery with `-Pn` causes Nmap to attempt the requested scanning functions against _every_ target IP address specified.

_**Always perform DNS resolution**_&#x20;

`-R:`To query the DNS server even for offline hosts.

```bash
$ nmap -R <host>
```

### Other useful flags

| `-F`                    | 100 most common ports                    |
| ----------------------- | ---------------------------------------- |
| `-r`                    | scan ports in consecutive order          |
| `-T<0-5>`               | -T0 being the slowest and T5 the fastest |
| `--max-rate 50`         | rate <= 50 packets/sec                   |
| `--min-rate 15`         | rate >= 15 packets/sec                   |
| `--min-parallelism 100` | at least 100 probes in parallel          |
| `--max-parallelism 200` | at most 200 probes in parallel           |

### Spoofing and decoys

_**Spoof source address**_

`-S` _IP\_Address_&#x20;

#### Spoof source MAC address

`--spoof-mac` _MAC address, prefix, or vendor name_&#x20;



_**Decoys**_

`-D` _decoy1_\[,_decoy2_]\[,ME]\[,...]&#x20;

a) `ME` represents the attacker's IP

b) `RND` can be used to generate random addresses

```bash
# eg. 
$ nmap <host> -D 10.10.10.20,10.10.10.22,ME
$ nmap <host> -D 10.10.10.22,RND,ME
```

### Fragmentation

`-f`flag

> The -`f` option causes the requested scan (including ping scans) to use tiny fragmented IP packets. The idea is to split up the TCP header over several packets to make it harder for packet filters, intrusion detection systems, and other annoyances to detect what you are doing.

> Specify `-f` again to use 16 bytes per fragment (reducing the number of fragments).

```bash
$ nmap <host> -f -f
# OR 
$ nmap <host> -ff
```



`--mtu` option

&#x20;Or you can specify your own offset size with the `--mtu`option. Don't also specify `-f` if you use `--mtu`. The offset must be a multiple of eight.



_**TCP header fragmentation theory**_

The process of reassembling the fragmented packets is based on the Identification (ID) and Fragment Offset fields.

### Nmap Scripting Engine (NSE)

`--script` _flag_

_Scripts can be found in_ `/usr/share/nmap/scripts`

| Script Category | Description                                                            |
| --------------- | ---------------------------------------------------------------------- |
| `auth`          | Authentication related scripts                                         |
| `broadcast`     | Discover hosts by sending broadcast messages                           |
| `brute`         | Performs brute-force password auditing against logins                  |
| `default`       | Default scripts, same as `-sC`                                         |
| `discovery`     | Retrieve accessible information, such as database tables and DNS names |
| `dos`           | Detects servers vulnerable to Denial of Service (DoS)                  |
| `exploit`       | Attempts to exploit various vulnerable services                        |
| `external`      | Checks using a third-party service, such as Geoplugin and Virustotal   |
| `fuzzer`        | Launch fuzzing attacks                                                 |
| `intrusive`     | Intrusive scripts such as brute-force attacks and exploitation         |
| `malware`       | Scans for backdoors                                                    |
| `safe`          | Safe scripts that won’t crash the target                               |
| `version`       | Retrieve service versions                                              |
| `vuln`          | Checks for vulnerabilities or exploit vulnerable services              |

```bash
$ nmap ... -sC
$ nmap ... --script=default # equivalent to -sC

# eg. auth script
$ nmap ... --script=auth 
```

**Example**

```bash
$ nmap 10.10.10.22 -sS -sC -n
# OR
$ nmap 10.10.10.22 -sS --script=default -n


```

`--script` `"SCRIPT-NAME"`

```bash
# includes all the script with ftp word in the script name, eg. ftp-brute
$ nmap ... --script "ftp*"
```

{% embed url="https://tryhackme.com/r/room/nmap04" %}



{% embed url="https://linux.die.net/man/1/nmap" %}
