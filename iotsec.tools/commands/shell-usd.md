# shell, $

## CLI

Provides a shell on the Docker environment to access the raw tools (without any command wrapper). Run the `shell` command:

```shellscript
iotsec.tools> shell
shell> 
```

Alternatively, you may access the shell anytime by prefixing the `$` symbol:

```shellscript
[module]> $ <command>

# eg. 
[module]> $ ping 8.8.8.8
...
```



## List of installed tools

1. **Network configuration**

* ip, ifconfig, dhclient

2. **Network services**

* wget, netcat (nc), nmap

3. Firmware based

* binwalk, firmware-mod-kit (`extract-firmware.sh`, `build-firmware.sh`), FirmAE (`run.sh`, ...)



**You may install additional tools with `apt`:**

```shellscript
shell> sudo apt install <tool>
```



