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
* Other useful information
  * Firmware download
  * End-of-Life (EoL) and End-of-Support (EoS) dates
  * Release notes
  * Online forums
* **Lab challenge**&#x20;
  * FCC (link coming soon!)



2. **Hardware interactions & debug console access (UART)**

* What is UART?
* Interacting with the hardware to map out the electrical UART components
* How to use the digital multimeter to:
  * Identify GND points
  * Identify specific UART pins
* How to gain a debug shell console (`picocom`) for further research on the software portion of the device



3. **Firmware/Binary emulation**

* **Purpose**: To perform research without access to a physical device
* What is emulation?&#x20;
* What are the different types of emulation (firmware, binary).
* Why is this helpful in IoT security research?
* How to perform complete firmware emulation with FirmAE
* How to perform binary emulation with QEMU
* **Lab challenge**&#x20;
  * ... (coming soon!)



4. **IoT software/system reconnaissance (via UART debug console)**

* **Purpose**: To gather information regarding the software components (where most vulnerabilities are found)
* How to analyze the device boot logs to gather information and find potential vulnerabilities
* How to investigate running processes and look for potentially vulnerable binaries
* **Case study**: Investigating a command injection vulnerability via the boot logs



5. **Setting up the lab research environment**

* **Purpose**: To create a stable and efficient security research environment
* How to transfer files between device and host to load additional binaries (eg. `busybox-mipsel`)
* How to setup and additional console access (Dropbear SSH server)
* How to setup for dynamic binary analysis (GDB + gdbserver)



6. **Vulnerability research + Exploit development**

* How to perform static/dynamic binary analysis with Ghidra and GDB+gdbserver
  * Setting up on FirmAE
  * Setting up on the physical device (via UART console)
* How to set custom breakpoints on a binary file with binary patching (to bypass hardware limitations)
* **Case study 1:** Command injection on Linksys E1200 v2 router ([CVE-2025-60689](https://github.com/Jarrettgohxz/CVE-research/tree/main/Linksys/E1200-V2/CVE-2025-60689), [CVE-2025-34037](https://github.com/Jarrettgohxz/CVE-research/tree/main/Linksys/E-series/CVE-2025-34037))
* **Case study 2**: Stack buffer-overflow on Linksys E1200 v2 router ([CVE-2025-60690](https://github.com/Jarrettgohxz/CVE-research/tree/main/Linksys/E1200-V2/CVE-2025-60690))
* **Lab challenge**&#x20;
  * ... (coming soon!)



7. **Putting it all together: Final lab challenge!**

* Combine your knowledge from all the previous sections on provided firmware image:
  * Peform firmware emulation&#x20;
  * Perform software recconnaissance via the emulated debug console
  * Load additional binary tools&#x20;
  * Investigate the command injection vulnerability
  * Craft the final exploit to achieve remote-code execution and a root shell!



8. **Additional practice: IoT hacking labs + writeups**

* Compiled writeups from Picoctf, TryHackMe, Vulnhub, and custom challenges created by me (coming soon!)
* OWASP Iot GOAT

## Advanced IoT Hacking Topics&#x20;

1. **Advanced firmware techniques**

* **Firmware reverse engineering & analysis**
  * How to retrieve the Linux filesystem from firmware images
  * How to perform analysis to uncover hidden vulnerabilities&#x20;
* **Firmware modification & re-flashing**
  * How to insert custom logic into firmware images and flash it back onto the physical memory chip for persistence
* **Case study 1**: How to create a persistent backdoor (rootkit) on the device by modifiying original firmware image
  * startup binary hijacking
  * NVRAM, bootloader corruption - for persistence across factory resets
* **Case study 2**: How to create a persistent backdoor (rootkit) on the device by modifiying an open-source firmware image
* **Firmware extraction:** How to retrieve firmware image from the physical device
  * UART debug console: Linux device blocks
  * Specialized hardware tools (eg. CH341A, Raspberry Pi)
  * Official vendor webpage



2. **Wireless (Bluetooth) attacks** (coming soon!)





