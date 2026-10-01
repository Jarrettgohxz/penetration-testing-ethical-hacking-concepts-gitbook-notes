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

**You will learn about**:

* IP addresses
  * How do devices on a network find each other to communicate?&#x20;
* TCP vs UDP communications
* Dynamic Host Configuration Protocol (DHCP)
  * How devices connected to a router retrieves an IP address?
* HyperText Transfer Protocol (HTTP)
  * Learn about the network protocol used by web servers
* Ports & services
  * What is a port and service?
  * How to investigate open ports/services with Nmap?

**Additional tools**

* **Wget**
  * Learn how to send HTTP requests to retrieve files
* **Netcat**
  * Learn how to send TCP requests&#x20;

**Lab practice**

Practice your skills on a simulated router environment! Talk to the Discord bot (xxxx) to access the challenge files. Alternatively, you can access the challenge directly from the `iotsec.tools` CLI interface:

```shellscript
iotsec.tools> labs 1
```

<details>

<summary>Solution</summary>

```
iotsec.tools> $ wget ...
iotsec.tools> $ dhclient ...
```

</details>



## <mark style="color:red;">**--— COMING SOON! -----—**</mark>&#x20;

## 3. Linux fundamentals

* **Purpose**: To introduce the Linux operating system used widely in IoT/embedded systems
* How to setup a Linux VM (Ubuntu on VMWare) for Windows users
* Filesystem
  * Common naming shortcuts: `~`, `/`
  * Folders: `etc`, `dev`, `usr`, `sbin`, and more!
  * Files: `/etc/shadow`, `/etc/hosts`, `~/.netrc`, and more!
* Basic commands
  * `ls`, `ps w`, `netstat`, `pgrep`, and more!

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
