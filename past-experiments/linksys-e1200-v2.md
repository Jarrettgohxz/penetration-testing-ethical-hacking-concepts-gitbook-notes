# Linksys E1200(V2)

## 1. Initial research on router model





## 2. Hardware overview



## 3. System enumeration (external)

### 3.1 Automatic IP lease (DHCP)

An ethernet cable will be used to connect the "Ethernet" port of the router and a test machine (running Ubuntu OS). We will be using Wireshark to view the live network traffic flowing between the router and test machine.

Right after the ethernet cable is plugged in, a bunch of network traffic starts flowing on the Wireshark screen. The particular type of traffic of interest would be **DHCP:**





### 3.2 Network services scan (Nmap)

* `<host>` will be the IP address of the local gateway (eg. **192.168.1.1**)

```shellscript
$ sudo nmap -sS -sV -p- -T4 -n -Pn <host> # TCP
$ sudo nmap -sU -sV -p- -T4 -n -Pn --max-retries 1 <host> # UDP
```

> Note: UDP scans are much slower than TCP because they often don't receive a response, forcing Nmap to wait for a timeout
>
> Hence, the `--max-retries` is important to cap the max retransmission for UDP scans

Refer to the following links for more information on the Nmap options:

{% embed url="https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/2-network-port-scan-services-enumeration/nmap" %}

{% embed url="https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/tools-services/network-recon-and-attacks/nmap-general-overview#scan-optimization" %}







## 4. System enumeration (via shell)

