---
description: Project started on 4 Dec 2025
---

# Linksys E1200(V2)

<figure><img src="../../.gitbook/assets/image (123).png" alt=""><figcaption></figcaption></figure>

## Learning outcomes



1. Techniques to gather information on a hardware without physical access to the device itself

* Google dork
  * Release notes, firmware download
  * Known CVEs&#x20;
  * PoCs for found CVEs
* FCC



2. Hardware interactions

* Identifying UART and potential GND points (visual inspection)
* Using the digital multimeter:
  * Identify GND points
  * Identify specific UART pins



3. Interacting with basic networking services on the device

* DHCP
* Nmap scan
* cURL, Netcat, etc.



4. How to gain a shell console from the UART interface + system enumeration

* Boot logs
* Firmware and OS versions, along with other useful information&#x20;
* Information gathering on a vulnerable binary



5. Techniques to interact with the device

* Simple techniques to reclaim memory space on the device
* &#x20;Transfer files between device and host



6. Understanding of the _MIPS_ architecture & assembly + reverse engineering and exploit development of a vulnerable binary (from a known CVE)

* Understand the vulnerability from the CVE description
* Work with exploit tools and techniques: pwn, Ghidra, GDB + gdbserver, objdump, etc.
* Demonstration of the steps taken to generate the final working payload for _remote-code execution_



7. **Bonus section**: persistence techniques from a real-world perspective

* "backdoor" access that can be remotely accessed

