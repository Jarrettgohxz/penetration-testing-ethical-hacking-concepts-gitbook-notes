# 🔥 Advanced IoT Hacking Topics

## &#x20;1. **Advanced firmware techniques**

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



## **2. Advanced Raspberry Pi usage**

* How to use Raspberry Pi as an IoT hacking bridge between device and host (your machine)
* How to use Raspberry Pi as an UART/JTAG interface
* How to emulate physical environment on a Raspberry Pi
  * Bare-metal OS flashing (requires compilation for ARM)
  * Firmware emulation



## **3. Wireless (Bluetooth) attacks** (coming soon!)

...

