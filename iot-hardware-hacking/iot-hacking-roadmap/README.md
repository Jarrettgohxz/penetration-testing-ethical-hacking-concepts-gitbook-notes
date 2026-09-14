# 🛣️ IoT Hacking Roadmap

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
* How to obtain the firmware image (covered in detail in the advanced topics)
* How to perform complete firmware emulation with FirmAE
* How to perform binary emulation with QEMU

> Take note that the all the content covered in the next few steps can be performed through a firmware emulation (debug shell console) without access to a physical device. However, feel free to work on a physical device too if you have access to one!



4. **IoT software/system reconnaissance**

* **Purpose**: To gather information regarding the software components (where most vulnerabilities are found)
* How to analyze the device boot logs to gather information and find potential vulnerabilities
* How to investigate running network services and look for potentially vulnerable processes
  * Direct debug console enumeration
  * Nmap scripts&#x20;
* **Case study**: Investigating a command injection vulnerability on the Linksys E1200 v2 router (recconnaissance from the boot logs)



5. **Setting up the lab research environment**

* **Purpose**: To create a stable and efficient IoT security research environment
* How to transfer files between device and host to load additional binaries (eg. `busybox-mipsel`)
* How to setup and additional console access (Dropbear SSH server)
* How to setup for dynamic binary analysis (GDB + gdbserver)



6. **Firmware reverse engineering & analysis**

* How to retrieve the Linux filesystem from the firmware
* How to perform analysis to uncover hidden vulnerabilities&#x20;
* **Lab challenge**&#x20;
  * ... (coming soon!)



7. **Vulnerability research + Exploit development**

* How to perform static/dynamic binary analysis with Ghidra and GDB+gdbserver
  * Setting up on FirmAE
  * Setting up on the physical device (via UART console)
* How to set custom breakpoints on a binary file with binary patching (to bypass hardware limitations)
* **Case study 1:** Command injection on Linksys E1200 v2 router ([CVE-2025-60689](https://github.com/Jarrettgohxz/CVE-research/tree/main/Linksys/E1200-V2/CVE-2025-60689), [CVE-2025-34037](https://github.com/Jarrettgohxz/CVE-research/tree/main/Linksys/E-series/CVE-2025-34037))
* **Case study 2**: Stack buffer-overflow on Linksys E1200 v2 router ([CVE-2025-60690](https://github.com/Jarrettgohxz/CVE-research/tree/main/Linksys/E1200-V2/CVE-2025-60690))
* **Lab challenge**&#x20;
  * ... (coming soon!)



8. **Putting it all together: Final lab challenge!**

* Combine your knowledge from all the previous sections on provided firmware image:
  * Peform firmware emulation&#x20;
  * Perform software reconnaissance via the emulated debug console
  * Load additional binary tools&#x20;
  * Investigate the command injection vulnerability
  * Craft the final exploit, and test it on the emulated environemnt to achieve remote-code execution and a shell!
  * Run the exploit on the lab server and retrieve the flag!



9. **Additional practice: IoT hacking labs + writeups**

* Compiled writeups from Picoctf, TryHackMe, Vulnhub, and custom challenges created by me (coming soon!)
* OWASP Iot GOAT

## Advanced IoT Hacking Topics&#x20;

1. **Advanced firmware techniques**

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



2. **Advanced Raspberry Pi usage**

* How to use Raspberry Pi as an IoT hacking bridge between device and host (your machine)
* How to use Raspberry Pi as an UART/JTAG interface
* How to emulate physical environment on a Raspberry Pi
  * Bare-metal OS flashing (requires compilation for ARM)
  * Firmware emulation



3. **Wireless (Bluetooth) attacks** (coming soon!)
