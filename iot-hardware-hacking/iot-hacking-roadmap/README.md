# 🛣️ IoT Hacking Roadmap

I have curated a step-to-step guide on IoT hacking, along with useful learning resources such as custom labs/challenges, video guides and cheatsheet.

## **1. IoT Reconnaissance/Information gathering**

* What is **Open-Source Intelligence (OSINT)** techniques, and how it can be used to gather information on a device without physical access
* Google dorking
* Federal Communications Commission (FCC) - provides useful data on devices
  * Internal hardware images
  * Identify presence of serial console/JTAG interfaces (for debug console access)
* Other useful information
  * Firmware download
  * End-of-Life (EoL) and End-of-Support (EoS) dates
  * Release notes
  * Online forums
* **Lab challenge**
  * FCC (link coming soon!)

## **2. Hardware interactions & debug console access (UART)**

* What is UART?
* Interacting with the hardware to map out the electrical UART components
* How to use the digital multimeter to:
  * Identify GND points
  * Identify specific UART pins
* How to gain a debug shell console (`picocom`) for further research on the software portion of the device

## **3. Firmware/Binary emulation**

* **Purpose**: To perform research without access to a physical device
* What is a firmware image, and binary file?
* What is emulation?
* What are the different types of emulation (firmware, binary).
* Why is this helpful in IoT security research?
* How to obtain the firmware image (covered in detail in the advanced topics)
* How to perform complete firmware emulation with FirmAE
* How to perform binary emulation with QEMU

> Take note that the all the content covered in the next few steps can be performed through a firmware emulation (debug shell console) without access to a physical device. However, feel free to work on a physical device too if you have access to one!

## **4. IoT embedded software system enumeration**

* **Purpose**: To gather information regarding the software components (where most vulnerabilities are found)
* What is enumeration, and how can it be done on the software system?
* How to analyze the device boot logs to gather information and find potential vulnerabilities
* How to investigate running network services and look for potentially vulnerable processes
  * Direct debug console enumeration
  * Nmap scripts
* **Case study**: Investigating a command injection vulnerability on the Linksys E1200 v2 router (recconnaissance from the boot logs)

## **5. Setting up the lab research environment**

* **Purpose**: To create a stable and efficient IoT security research environment
* How to transfer files between device and host to load additional binaries (eg. `busybox-mipsel`)
* How to setup and additional console access (Dropbear SSH server)
* How to setup for dynamic binary analysis (GDB + gdbserver)

## **6. Firmware reverse engineering & analysis**

* **Purpose**: To extract useful data from the firmware image
* What is reverse engineering?
* How to retrieve the Linux filesystem from the firmware
* How to perform analysis to uncover hidden vulnerabilities
* **Lab challenge**
  * ... (coming soon!)

## **7. Common IoT vulnerability classes**

* What is OS command injection?
* What is stack buffer-overflow?
* **Case study 1**: OS command injection on Linksys E1200 v2 router ([CVE-2025-60689](https://github.com/Jarrettgohxz/CVE-research/tree/main/Linksys/E1200-V2/CVE-2025-60689), [CVE-2025-34037](https://github.com/Jarrettgohxz/CVE-research/tree/main/Linksys/E-series/CVE-2025-34037))
* **Case study 2**: Stack buffer-overflow on Linksys E1200 v2 router ([CVE-2025-60690](https://github.com/Jarrettgohxz/CVE-research/tree/main/Linksys/E1200-V2/CVE-2025-60690))
* **Case study 3**: Command injection on D-Link DIR-815 router

## **8. IoT vulnerability research + Exploit development**

* Introduction to Ghidra and GDB/gdbserver
* How to perform reverse engineering (static binary analysis) with Ghidra
* How to perform dynamic binary analysis with GDB+gdbserver
  * Setting up on the firmware emulation environment (FirmAE)
  * Setting up on the physical device (via UART console)
* How to set custom breakpoints on a binary file with a custom binary patching method (to bypass hardware limitations)
* **Case study 1 (follow-up):** Crafting exploit for OS command injection vulnerability on Linksys E1200 v2 router ([CVE-2025-60689](https://github.com/Jarrettgohxz/CVE-research/tree/main/Linksys/E1200-V2/CVE-2025-60689), [CVE-2025-34037](https://github.com/Jarrettgohxz/CVE-research/tree/main/Linksys/E-series/CVE-2025-34037))
* **Case study 2 (follow-up)**: Crafting exploit for stack buffer-overflow on Linksys E1200 v2 router ([CVE-2025-60690](https://github.com/Jarrettgohxz/CVE-research/tree/main/Linksys/E1200-V2/CVE-2025-60690))
* **Case study 3 (follow-up)**: Crafting exploit for command injection vulnerability on D-Link DIR-815 router
* **Lab challenge**
  * ... (coming soon!)

## **9. Putting it all together: Final lab challenge!**

* Combine your knowledge from all the previous sections on provided firmware image:
  * Peform firmware emulation
  * Perform software reconnaissance via the emulated debug console
  * Load additional binary tools
  * Investigate the command injection vulnerability
  * Craft the final exploit, and test it on the emulated environemnt to achieve remote-code execution and a shell!
  * Run the exploit on the lab server and retrieve the flag!

## **10. Additional practice: IoT hacking labs + writeups**

* Compiled writeups from Picoctf, TryHackMe, Vulnhub, and custom challenges created by me (coming soon!)
* OWASP Iot GOAT
