---
hidden: true
icon: toolbox
---

# Fundamental Ethical Hacking Concepts for IoT Hackers

This content provides an introduction to prerequisite knowledge required in the [IoT Hacking Roadmap](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/iot-hardware-hacking/iot-hacking-roadmap) course.

## **1. Fundamental Cybersecurity Terminologies**

**Purpose**: To introduce the foundational cybersecurity knowledge required for the subsequent sections&#x20;

> Note that you do not need to memorize these concepts, but just grasp a general understanding of it. It will all make sense eventually as you explore more in this field!
>
> You may refer back to this page when you encounter any unfamiliar terms in the future chapters

**Key concepts**:

* OSINT: ...
* Reconnaissance: ...
* Information gathering:  ...
* Common Vulnerability and Exposures (CVEs): ...
* Zero-days: ...
* Binary: ...
* Exploits: ...&#x20;
* Payload: ...

## **2.** Linux Fundamentals

**Purpose**: To introduce the Linux operating system&#x20;

* Used widely in IoT/embedded systems

{% embed url="https://www.youtube.com/@Jarrettgxz" %}

**Topic overview**:

1. How to setup a Linux virtual machine (Ubuntu on VMWare)&#x20;

* [https://www.techpowerup.com/download/vmware-workstation-pro/](https://www.techpowerup.com/download/vmware-workstation-pro/)
* ...



2. Linux filesystem

* Common naming shortcuts: `~`, `/`
* Folders: `etc`, `dev`, `usr`, `sbin`
* Files: `/etc/shadow`, `/etc/hosts`, `~/.netrc`



3. Getting comfortable with the command-line (terminal)

* Installing tools & packages (`apt`)
* Basic commands: `ls`, `cat`, `ps w`, `netstat`, `pgrep`
* Keyboard shortcuts (ctrl+A, ctrl+E)



**Lab practice**

Practice your skills on a simulated Linux environment! Talk to the Discord bot (xxxx) to access the challenge files. Alternatively, you can access the challenge directly from the `iotsec.tools` CLI interface:

```shellscript
iotsec.tools> labs 1
```

\
**Solutions**

<details>

<summary>Try it out yourself first!</summary>

```shellscript
chall-1@lab> cat ~/flag.txt
chall-1@lab> cat /etc/shadow
#...

chall-1@lab> ps w | grep 22
# ...
```

</details>



## **3. Computer Networking Concepts**

**Purpose**: To introduce essential computer networking concepts that will be encountered not only in IoT hacking, but in everyday cybersecurity research

{% embed url="https://www.youtube.com/@Jarrettgxz" %}

**Tools:**

* nc, ip, dhclient, wget, nmap, wireshark, iotsec.tools

**Topic overview:**

1. IPv4 addresses

* How do devices on a network find each other to communicate



2. Transmission Control Protocol (TCP) vs User Datagram Protocol (UDP) communications

* **TCP**: for reliable and stable communication where data integrity is important&#x20;
* How to use the netcat tool (`nc`) to send TCP requests
* **UDP**: for fast communication where speed is important



3. Dynamic Host Configuration Protocol (DHCP)

* How devices connected to a router retrieve an IP address?
* How to use the `dhclient` tool to retrieve an IP address from the DHCP server
* How to use the `ip` tool to view the network configurations



4. HyperText Transfer Protocol (HTTP)

* Learn about the network protocol used by web servers
* How to use the `wget` tool to send HTTP requests



5. Ports & services

* What is a port and service?
* How to investigate open ports/services with `nmap`



6. Wireshark

* How to analyze network protocols



**Lab practice**

Practice your skills on a simulated router environment! Talk to the Discord bot (xxxx) to access the challenge files. Alternatively, you can access the challenge directly from the `iotsec.tools` CLI interface:

```shellscript
iotsec.tools> labs 2
```

**Solutions**

<details>

<summary>Try it out yourself first!</summary>

```shellscript
chall-2@lab> nmap

chall-2@lab> dhclient ...
chall-2@lab> ip addr

chall-2@lab> wget ...

chall-2@lab> tshark ...

```

</details>



## <mark style="color:red;">**---COMING SOON! (CONTENT LISTED BELOW)—**</mark>&#x20;

## 4. Introduction to MIPS Assembly

* **Purpose**: ...
* what is assembly?
* why learn MIPS assembly?
* legacy, still used in many devices
* little/big endianness
* stack structure, registers, delay slots, etc.
* basic instructions: sw, lw, move, addiu, etc.

## 5. MIPS Binary Reverse Engineering & Analysis for IoT Hacking (Ghidra)

* common instructions on function call: restore ra, etc. -> how overwriting it hijacks function file

## 6. MIPS Binary Exploitation for IoT Hacking (GDB/gdbserver)

* introduce basic stack buffer-overflow techniques
* **Lab challenge**
  * example on an emulated MIPS binary
