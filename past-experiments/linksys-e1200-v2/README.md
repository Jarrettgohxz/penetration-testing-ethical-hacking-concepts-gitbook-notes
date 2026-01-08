# Linksys E1200(V2)

<figure><img src="../../.gitbook/assets/image (123).png" alt=""><figcaption></figcaption></figure>

## Learning outcomes



1. Various techniques to gather information on a hardware without physical access to the device itself

* Google dork
* FCC
* Release notes, firmware download
* Known CVEs&#x20;
* PoCs for found CVEs



2. Hardware interactions

* Identifying UART and potential GND points (visual inspection)
* Using the digital multimeter:
  * Identify GND points
  * Identify specific UART pins



3. Interacting with basic networking services&#x20;

* DHCP
* Nmap scan
* cURL, Netcat, etc.



4. How to gain a shell console from the UART interface + system enumeration

* Boot logs
* Firmware and OS versions, along with other useful information&#x20;
* Information gathering of a vulnerable binary



5. Reverse engineering + exploit development of a vulnerable binary

* Simple techniques to reclaim memory space and transfer files between device and host
* Exploit tools and techniques: pwn, Ghidra, GDB + gdbserver, objdump, etc.
* Demonstration of the steps taken to generate the final working payload



6. **Bonus section**: persistence techniques from a real-world perspective

* "backdoor" access that can be remotely accessed

