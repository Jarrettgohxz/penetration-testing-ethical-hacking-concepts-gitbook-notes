# Linksys E1200(V2)

## 1. Initial research&#x20;

### 1.1 Google dork

The following displays a few Google dork queries I used to discover the CVEs related to this router model, with the second one being specific to overflow type attacks:

```
"linksys" "e1200" cve site:nist.gov 
"linksys" "e1200" cve site:nist.gov "overflow"
```

The following are found CVEs (non-exhaustive) for the firmware version **E1200\_v2.0.11.001\_us.tar.gz**, with the last 4 being stack-based buffer overflow:

1. [https://nvd.nist.gov/vuln/detail/CVE-2025-60689](https://nvd.nist.gov/vuln/detail/CVE-2025-60689)
2. [https://nvd.nist.gov/vuln/detail/CVE-2025-60690](https://nvd.nist.gov/vuln/detail/CVE-2025-60690)
3. [https://nvd.nist.gov/vuln/detail/CVE-2025-60691](https://nvd.nist.gov/vuln/detail/CVE-2025-60691)
4. [https://nvd.nist.gov/vuln/detail/CVE-2025-60692](https://nvd.nist.gov/vuln/detail/CVE-2025-60692)
5. [https://nvd.nist.gov/vuln/detail/CVE-2025-60693](https://nvd.nist.gov/vuln/detail/CVE-2025-60693)

### 1.2 FCC

FCC ID: **Q87-E1200V2**

**FCC links:**

1. [**https://openwrt.org/toh/hwdata/linksys/linksys\_e1200\_v2**](https://openwrt.org/toh/hwdata/linksys/linksys_e1200_v2https:/wikidevi.wi-cat.ru/Linksys_E1200_v2https:/wiki.dd-wrt.com/wiki/index.php/Linksys_E1200v2https:/industrycanada.co/3839A-E1200V2https:/fcc.report/FCC-ID/Q87-E1200V2)
2. [**https://wikidevi.wi-cat.ru/Linksys\_E1200\_v2**](https://openwrt.org/toh/hwdata/linksys/linksys_e1200_v2https:/wikidevi.wi-cat.ru/Linksys_E1200_v2https:/wiki.dd-wrt.com/wiki/index.php/Linksys_E1200v2https:/industrycanada.co/3839A-E1200V2https:/fcc.report/FCC-ID/Q87-E1200V2)
3. [**https://wiki.dd-wrt.com/wiki/index.php/Linksys\_E1200v2**](https://openwrt.org/toh/hwdata/linksys/linksys_e1200_v2https:/wikidevi.wi-cat.ru/Linksys_E1200_v2https:/wiki.dd-wrt.com/wiki/index.php/Linksys_E1200v2https:/industrycanada.co/3839A-E1200V2https:/fcc.report/FCC-ID/Q87-E1200V2)
4. [**https://industrycanada.co/3839A-E1200V2**](https://openwrt.org/toh/hwdata/linksys/linksys_e1200_v2https:/wikidevi.wi-cat.ru/Linksys_E1200_v2https:/wiki.dd-wrt.com/wiki/index.php/Linksys_E1200v2https:/industrycanada.co/3839A-E1200V2https:/fcc.report/FCC-ID/Q87-E1200V2)
5. [**https://fcc.report/FCC-ID/Q87-E1200V2**<br>](https://openwrt.org/toh/hwdata/linksys/linksys_e1200_v2https:/wikidevi.wi-cat.ru/Linksys_E1200_v2https:/wiki.dd-wrt.com/wiki/index.php/Linksys_E1200v2https:/industrycanada.co/3839A-E1200V2https:/fcc.report/FCC-ID/Q87-E1200V2)

### 1.3 Other useful information

1. **Linksys End-Of-Life (EOL) and End-Of-Support (EOS) period**

{% embed url="https://openwrt.org/toh/hwdata/linksys/linksys_e1200_v2https:/wikidevi.wi-cat.ru/Linksys_E1200_v2https:/wiki.dd-wrt.com/wiki/index.php/Linksys_E1200v2https:/industrycanada.co/3839A-E1200V2https:/fcc.report/FCC-ID/Q87-E1200V2" %}

2. **Download firmware**

{% embed url="https://support.linksys.com/kb/article/316-en/" %}

{% embed url="https://downloads.linksys.com/support/assets/gpl/E1200_v2.0.11.001_us.tar.gz" %}
v2.0.11.001\_us.tar.gz
{% endembed %}

3. **Release notes**

{% embed url="https://downloads.linksys.com/downloads/releasenotes/E1200_v2_v2.2_FwReleaseNotes.txt" %}

* It appears that the latest release that is documented is for 2.0.09 on Jan 5, 2018

## 2. Hardware overview

<figure><img src="../.gitbook/assets/image (108).png" alt=""><figcaption></figcaption></figure>

### 2.1 Identifying Ground points

By looking at the PCB, we can identify a few potential candidates for the Ground points:

<figure><img src="../.gitbook/assets/image (107).png" alt=""><figcaption></figcaption></figure>

We can use the digital multimeter in continuity mode to test the GND points, which can be identified when a "beep" sound is heard:

{% embed url="https://667177664-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FMsAGomcNx5xaB1xFygc9%2Fuploads%2FwQGqpJinzjtUuJtn9D1g%2FGND.mp4?alt=media&token=69323bb1-ab16-484c-bd6e-e51301df5a89" %}

* **Confirmed GND points**

<figure><img src="../.gitbook/assets/image (109).png" alt=""><figcaption></figcaption></figure>

### 2.2 Identifying UART pins (TX, RX, GND, 3.3V)

{% file src="../.gitbook/assets/UART pins identification.mp4" %}





### 2.3 Taking a closer look at TX+RX

{% file src="../.gitbook/assets/UART TX+RX.mp4" %}





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

#### LAN

_\[...insert TCP scan results]_

#### WAN

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

#### LAN

_\[...insert UDP -p67 scan results]_

#### WAN

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

#### LAN

_\[...insert combined scan results]_

#### WAN

_\[...insert combined scan results]_

Refer to the following links for more information on the Nmap options:

{% embed url="https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/2-network-port-scan-services-enumeration/nmap" %}

{% embed url="https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/tools-services/network-recon-and-attacks/nmap-general-overview#scan-optimization" %}

## 4. System enumeration (via shell)

...

