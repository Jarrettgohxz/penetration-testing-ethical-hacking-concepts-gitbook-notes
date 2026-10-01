---
hidden: true
icon: toolbox
---

# Fundamental Ethical Hacking Concepts for IoT Hackers

This content provides an introduction to prerequisite knowledge required in the [IoT Hacking Roadmap](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/iot-hardware-hacking/iot-hacking-roadmap) course.

## **1. Fundamental cybersecurity terminologies**

* **Purpose**: To introduce the foundational cybersecurity knowledge required for the subsequent sections&#x20;

**You will learn about**:

* OSINT, Reconnaissance, Information gathering
* Common Vulnerability and Exposures (CVEs), Zero-days
* Binary, Exploits, Payload

## **2. Computer networking concepts**

* **Purpose**: To introduce essential computer networking concepts that will be encountered not only in IoT hacking, but in everyday cybersecurity research

{% embed url="https://www.youtube.com/@Jarrettgxz" %}

**You will learn about**:

* IPv4 addresses
  * How do devices on a network find each other to communicate
* Transmission Control Protocol (TCP) vs User Datagram Protocol (UDP) communications
  * **TCP**: for reliable and stable communication where data integrity is important&#x20;
  * How to use the netcat tool (`nc`) to send TCP requests
  * **UDP**: for fast communication where speed is important
* Dynamic Host Configuration Protocol (DHCP)
  * How devices connected to a router retrieve an IP address?
  * How to use the `dhclient` tool to retrieve an IP address from the DHCP server
  * How to use the `ip` tool to view the network configurations
* HyperText Transfer Protocol (HTTP)
  * Learn about the network protocol used by web servers
  * How to use the `wget` tool to send HTTP requests
* Ports & services
  * What is a port and service?
  * How to investigate open ports/services with Nmap
* Wireshark
  * How to analyze network protocols



**Lab practice**

Practice your skills on a simulated router environment! Talk to the Discord bot (xxxx) to access the challenge files. Alternatively, you can access the challenge directly from the `iotsec.tools` CLI interface:

```shellscript
iotsec.tools> labs 1
```

**Solutions**

<details>

<summary>Try it out yourself first!</summary>

```
iotsec.tools> $ wget ...
iotsec.tools> $ dhclient ...
```

</details>

## 3. Linux fundamentals

* **Purpose**: To introduce the Linux operating system used widely in IoT/embedded systems
* How to setup a Linux VM (Ubuntu on VMWare) for Windows users
* Filesystem
  * Common naming shortcuts: `~`, `/`
  * Folders: `etc`, `dev`, `usr`, `sbin`, and more!
  * Files: `/etc/shadow`, `/etc/hosts`, `~/.netrc`, and more!
* Basic commands
  * `ls`, `ps w`, `netstat`, `pgrep`, and more!



## <mark style="color:red;">**--— COMING SOON! -----—**</mark>&#x20;

## 4. Introduction to MIPS assembly

* **Purpose**: ...
* what is assembly?
* why learn MIPS assembly?
* legacy, still used in many devices
* little/big endianness
* stack structure, registers, delay slots, etc.
* basic instructions: sw, lw, move, addiu, etc.

## 5. MIPS binary reverse engineering & analysis for IoT hacking (Ghidra)

* common instructions on function call: restore ra, etc. -> how overwriting it hijacks function file

## 6. MIPS binary exploitation for IoT hacking (GDB/gdbserver)

* introduce basic stack buffer-overflow techniques
* **Lab challenge**
  * example on an emulated MIPS binary
