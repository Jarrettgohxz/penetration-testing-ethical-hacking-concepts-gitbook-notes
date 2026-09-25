---
icon: toolbox
---

# Fundamental Ethical Hacking Concepts for IoT Hackers

This content provides an introduction to prerequisite knowledge required in the [IoT Hacking Roadmap](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/iot-hardware-hacking/iot-hacking-roadmap) course.

## **1. Fundamental cybersecurity terminologies**

* **Purpose**: To introduce the foundational cybersecurity knowledge required for the subsequents sections&#x20;
* **You will learn about**:
  * OSINT, Reconnaissance, Information gathering
  * Common Vulnerability and Exposures (CVEs), Zero-days
  * Binary, Exploits, Payload

## **2. Computer networking concepts**

* **Purpose**: To introduce essential computer networking concepts that will be encountered not only in IoT hacking, but in everyday cybersecurity research
* **You will learn about**:
  * IP addressing and subnets
  * Domain Name System (DNS)
  * HyperText Transfer Protocol (HTTP) used by web servers
  * Secure SHell (SSH) used for connecting to remote servers and for port forwarding
  * TCP reverse shells

## 3. Linux fundamentals

* Why learn Linux?
  * wide usage in servers, most common system found on IoT/embedded devices
* how to setup a Linux VM (VMWare) for Windows users
* filesystem (etc, dev, usr, sbin, etc.)
* basic commands
  * ls, ps w, netstat -tln, pgrep, etc.

## 4. Introduction to MIPS assembly

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
