---
icon: toolbox
---

# Fundamental Ethical Hacking Concepts for IoT Hackers

This content provides an introduction to prerequisite knowledge required in the [IoT Hacking Roadmap](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/iot-hardware-hacking/iot-hacking-roadmap) course.

## **1. Fundamental cybersecurity terminologies**

* OSINT, reconnaissance, information gathering
* exploit, payload, binary
* CVE, zero-day

## **2. Computer networking**

* HTTP (web interface)
* SSH (used for port forwarding in post exploitation)
* TCP client/listener
* reverse shells

## 3. Linux fundamentals

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
