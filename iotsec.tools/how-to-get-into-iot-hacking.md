# How to get into IoT hacking?

## How I got started in IoT/hardware hacking

I started off with the curiosity of how vulnerabilties are exploited on IoT/hardware devices. Personally, I was particularly interested in binary exploitation (eg. stack buffer-overflow), and thought that working on a physical device would provide me with the best learning experience.

From there, I actively researched on existing vulnerabilities/CVEs on IoT devices, particularly those that involves "buffer overflow" type ones. I found a router model (_Linksys E1200 v2_) that had a bunch of existing CVEs with no publicly available/working exploit script. I went on to purchase a secondhand one from my local marketplace, along with a few tools: USB-UART adapter, digital multimeter and a stack of jumper wires.&#x20;

> Do not worry if you are unable to get your hands on a physical device, as I will provide methods to emulate a hardware environment later on!

I read a bunch of research articles, watched a bunch of YouTube videos, and experimented on the physical router to eventually craft a working proof-of-concept script for a few of the CVEs: stack buffer-overflow CVE ([CVE-2025-60690](https://nvd.nist.gov/vuln/detail/CVE-2025-60690)), and command injection ([CVE-2025-60689](https://nvd.nist.gov/vuln/detail/cve-2025-60689), [CVE-2025-34037](https://nvd.nist.gov/vuln/detail/cve-2025-34037)). You may read more about it [here](https://github.com/Jarrettgohxz/CVE-research/tree/main/Linksys/E1200-V2).

> Common Vulnerabilities Exposure (CVE) is a standardized, publicly available list or dictionary of known cybersecurity flaws and software or hardware vulnerabilities

## IoT Hacking Roadmap

I have curated a step-to-step guide on IoT hacking, along with useful learning resources such as custom labs/challenges, video guides and cheatsheet.&#x20;

**Overview of learning content:**

1. **IoT Reconnaissance/Information gathering**&#x20;

* **Open-Source Intelligence (OSINT)** techniques to gather information on a device without physical access
* Google dorking
* Federal Communications Commission (FCC) - provides useful data on devices
  * Internal hardware images
  * Identify presence of serial console/JTAG interfaces (for debug console access)
*   Other useful information

    * Firmware download
    * End-of-Life (EoL) and End-of-Support (EoS) dates
    * Release notes
    * Online forums



2. **Hardware interactions & debug console access (UART)**

* What is UART?
* Interacting with the hardware to map out the electrical UART components
* How to use the digital multimeter to:
  * Identify GND points
  * Identify specific UART pins
* How to gain a debug shell console (`picocom`) for further research on the software portion of the device



3. **Setting up the lab research environment**

* How to transfer files between device and host to load additional binaries (eg. `busybox-mipsel`)
* How to setup and additional console access (Dropbear SSH server)
* How to setup for dynamic binary analysis (`GDB` + `gdbserver`)



4. **System enumeration (via UART debug console)**

* How to analyze the device boot logs to gather information and find potential vulnerabilities
* How to investigate running processes and look for potentially vulnerable binaries



5. **Vulnerability research + Exploit development**

* **Case study 1:** Command injection (CVE-2025-60689, CVE-2025-34037)
* **Case study 2**: Stack buffer-overflow (CVE-2025-60690)



6. **Hardware emulation + Exploit testing**

* How to perform firmware emulation with FirmAE
* How to perform binary emulation with QEMU<br>

7. **IoT hacking labs + writeups**

* Compiled writeups from Picoctf, TryHackMe, Vulnhub, and custom challenges created by me (coming soon!)
* OWASP Iot GOAT
