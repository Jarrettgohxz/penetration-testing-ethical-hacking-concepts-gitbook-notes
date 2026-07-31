# Understanding the firmware layout

## Full firmware image `(.bin)`

> This will be the image we use when flashing directly on the physical hardware chip

A full firmware `(.bin`, `.img`) file contains multiple layers:

1. **Hardware initialization layer**

* **Paddings/custom instructions**: uncompressed assembly instructions or paddings
* **Bootloader**: compressed data (eg. LZMA)
* will usually be constant between different firmware versions for the same router model (not affected by changes to the kernel or filesystem)
  * it is usually statically stored on the physical device's non-volatile memory

2. **TRX firmware header**

* contains a checksum value that changes whenever the kernel or filesystem is modified
* [reference](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/iot-hardware-hacking/firmware-techniques/firmware-mod-kit#extract-modify-build)

3. **Kernel**
4. **Root filesystem**

* eg. SquashFS, jefferson, cramfs
* contains the standard Linux directory tree

Let's take a look at a simple example at a [firmware](https://github.com/Jarrettgohxz/iot.tools/releases/download/linksys-e1200-fw-v2.0.02/linksys_e1200_fw2.0.02.bin) file that I have extracted directly from the **Linksys E1200 router**:

{% code title="Output from "binwalk"" %}
```shellscript
$ binwalk linksys_e1200_fw2.0.02.bin

DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
46708         0xB674          LZMA compressed data, properties: 0x5D, dictionary size: 65536 bytes, uncompressed size: 291900 bytes
262144        0x40000         TRX firmware header, little endian, image size: 7045120 bytes, CRC32: 0x88847E55, flags: 0x0, version: 1, header size: 28 bytes, loader offset: 0x1C, linux kernel offset: 0x14F7FC, rootfs offset: 0x0
262172        0x4001C         gzip compressed data, maximum compression, has original file name: "piggy", from Unix, last modified: 2012-02-15 12:33:30
1636348       0x18F7FC        Squashfs filesystem, little endian, non-standard signature, version 3.0, size: 5666326 bytes, 1667 inodes, blocksize: 65536 bytes, created: 2012-02-15 12:44:17
```
{% endcode %}

<figure><img src="../../.gitbook/assets/image (2) (1).png" alt=""><figcaption></figcaption></figure>

We notice 4 distinct portions from the `binwalk` output:

1. `0xB674`: **LZMA compressed data**

* raw SPI flash dumps (padding bytes or custom MIPS assembly code) - `0x0` to `0xB673`
  * refer to the notes below to view the custom MIPS assembly code
* bootloader (for initialization of the system) - `0xB674` to `0x3FFF`&#x20;

2. `0x40000`: **TRX firmware header**

* checksum value (28 bytes) - `0x40000` to `0x4001C`
* re-computed for, and changes across different firmware versions (wtith varying kernel, SquashFS)
  * automatically handled when using `build-firmware.sh` from [firmware-mod-kit](https://github.com/Jarrettgohxz/firmware-mod-kit)

3. `0x4001C`: gzip compressed data

* contains the Kernel

4. `0x18F7FC`: Squashfs filesystem

* contains the SquashFS filesystem (Little Endian)
* detected as having a "non-standard signature"
  * the `binwalk --extract` command with the **unsquashfs** tool (installed by default on most Linux systems), will fail
  * we will need the [Sasquatch](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/iot-hardware-hacking/techniques/firmware/firmware-reversing-analysis#setup-sasquatch) tool for this

### Analysis of the MIPS instructions (top portion of the firmware)

First, we use the `dd` tool to extract 80 bytes (20 instructions) from the start of the firmware. Next, we use the `mipsel-linux-gnu-objdump` tool to read the MIPS disassembly code

{% code title="" %}
```bash
$ dd if=linksys_e1200_fw2.0.02.bin of=linkys-e1200-fw2.0.0.2-RAW-FIRST-FEW-BYTES.bin bs=1 count=80
80+0 records in
80+0 records out
80 bytes copied, 0.00023909 s, 335 kB/s


$ mipsel-linux-gnu-objdump -D -b binary -m mips:isa32 -EL linkys-e1200-fw2.0.0.2-RAW-FIRST-FEW-BYTES.bin

linkys-e1200-fw2.0.0.2.bin-RAW-FIRST-FEW-BYTES:     file format binary
Disassembly of section .data:
00000000 <.data>:
   0:   3c12b800        lui     s2,0xb800
   4:   24075350        li      a3,21328
   8:   8e510000        lw      s1,0(s2)
   c:   340affff        li      t2,0xffff
  10:   022a5024        and     t2,s1,t2
  14:   1547000f        bne     t2,a3,0x54
  18:   00000000        nop
  1c:   3c0a00f0        lui     t2,0xf0
  20:   022a5024        and     t2,s1,t2
  24:   3c070010        lui     a3,0x10
  28:   11470040        beq     t2,a3,0x12c
  2c:   00000000        nop
  30:   24070311        li      a3,785
  34:   8e4b0090        lw      t3,144(s2)
  38:   10eb003c        beq     a3,t3,0x12c
  3c:   00000000        nop
  40:   ae470090        sw      a3,144(s2)
  44:   240b0001        li      t3,1
  48:   ae4b0080        sw      t3,128(s2)
  4c:   1000ffff        b       0x4c

```
{% endcode %}

## Extracted/operational/logical firmware image `(.trx)`

> This will be the image we use for [emulation](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/iot-hardware-hacking/techniques/firmware/firmware-emulation), or that is provided as an image to the web UI firmware upgrade page

### Example 1 (Linksys E1200)

Referring to the same full firmware image from Linksys router before, we can carve away the top portion, to provide a functional image:

> We can use the `dd` (disk-duplicator) command to carve the functional portions in to a new file (`linksys_e1200_fw2.0.02_carved.trx`)

{% code title="" %}
```bash
$ dd if=linksys_e1200_fw2.0.02.bin \
     of=linksys_e1200_fw2.0.02_carved.trx \
     bs=65536 skip=4 count=123 status=none
```
{% endcode %}

* **4\*65536 = 0x40000** (starting location of the TRX firmware header)
* **123\*65536 = 0x7b0000** (size of the entire functional image)

The extracted firmware `(linksys_e1200_fw2.0.02_carved.trx`) file will only contain the bottom 3 portions extracted from the full firmware (`.bin`) image:

1. `0x0`: TRX firmware header
2. `0x1C`: Kernel
3. `0x14F7FC`: SquashFS filesystem (or others eg. **jefferson**, **cramfs**, etc.)

{% code title="" %}
```bash
$ binwalk linksys_e1200_fw2.0.02_extracted.trx

DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
0             0x0             TRX firmware header, little endian, image size: 7045120 bytes, CRC32: 0x88847E55, flags: 0x0, version: 1, header size: 28 bytes, loader offset: 0x1C, linux kernel offset: 0x14F7FC, rootfs offset: 0x0
28            0x1C            gzip compressed data, maximum compression, has original file name: "piggy", from Unix, last modified: 2012-02-15 12:33:30
1374204       0x14F7FC        Squashfs filesystem, little endian, non-standard signature, version 3.0, size: 5666326 bytes, 1667 inodes, blocksize: 65536 bytes, created: 2012-02-15 12:44:17
```
{% endcode %}

<figure><img src="../../.gitbook/assets/image (200).png" alt=""><figcaption></figcaption></figure>



### Example 2 (D-Link DIR815)

Let's take another example on the [D-Link DIR815 ](https://github.com/Jarrettgohxz/iot.tools/releases/download/dlink-dir815A1-v1.03b01/dlink-dir815A1-v1.03b01.bin)router:

{% code title="" %}
```bash
$ binwalk DIR815A1_FW103b01.bin

DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
0             0x0             DLOB firmware header, boot partition: "dev=/dev/mtdblock/2"
108           0x6C            LZMA compressed data, properties: 0x5D, dictionary size: 33554432 bytes, uncompressed size: 3017436 bytes
983148        0xF006C         PackImg section delimiter tag, little endian size: 15738880 bytes; big endian size: 2682880 bytes
983180        0xF008C         Squashfs filesystem, little endian, version 4.0, compression:lzma, size: 2682341 bytes, 1519 inodes, blocksize: 524288 bytes, created: 2012-03-09 10:16:45
```
{% endcode %}

Firmware portions:

1. `0x0`: **DLOB firmware header**

* propritary D-Link wrapper
* contains a checksum value

2. `0x6C`: **Kernel**
3. `0xF008C`: **SquashFS filesystem**

