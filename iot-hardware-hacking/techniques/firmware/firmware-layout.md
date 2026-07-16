# Firmware layout

A firmware `(.bin`, `.img`) file contains multiple layers:

1.

Let's take a look at a simple example at a [firmware](https://github.com/Jarrettgohxz/iot.tools/releases/download/linksys-e1200-fw-v2.0.02/linksys_e1200_fw2.0.02.bin) file that I have extracted directly from the Linksys E1200 router:

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

<figure><img src="../../../.gitbook/assets/image (2).png" alt=""><figcaption></figcaption></figure>

We notice 4 distinct portions from the `binwalk` output:

1. `0xB674`: **LZMA compressed data**

* raw SPI flash dumps (padding bytes or custom MIPS assembly code) - `0x0` to `0xB674`
* bootloader (for initialization of the system - `0xB674` to `0x3FFF`

2. `0x40000`: **TRX firmware header**

* checksum value (28 bytes) - `0x40000` to `0x4001C`
* re-computed for, and changes across different firmware versions (wtith varying kernel, SquashFS)
  * automatically handled when using `build-firmware.sh` from [firmware-mod-kit](https://github.com/Jarrettgohxz/firmware-mod-kit)

3. `0x4001C`: gzip compressed data

* ...

4. `0x18F7FC`: Squashfs filesystem



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



OTHER POINTS

1. checking TRX firmware header checksum after modifications (firmware-mod-kit) and before - should change
2. show steps to extract bootloader (from .bin) to covert to .trx and EXPLAIN

