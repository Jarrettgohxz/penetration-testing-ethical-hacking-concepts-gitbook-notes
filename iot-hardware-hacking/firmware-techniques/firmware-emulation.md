# Firmware emulation

## FirmAE

{% embed url="https://github.com/pr0v3rbs/FirmAE" %}

### 1. Installation steps&#x20;

> The installation steps for `binwalk` and `sasquatch` are performed on an Ubuntu 22.04 machine

```shellscript
# Clone FirmAE 
$ git clone --recursive https://github.com/pr0v3rbs/FirmAE

# Install dependencies (binwalk, sasquatch)
$ git clone https://github.com/devttys0/sasquatch.git
$ cd sasquatch

$ EXTRA_CFLAGS="-fcommon -Wno-error=misleading-indentation -Wno-error=address-of-packed-member -Wno-error=dangling-pointer" ./build.sh

$ which sasquatch 
/usr/local/bin/sasquatch

```

### 2. Run startup scripts

1. `download.sh`, `install.sh`, `init.sh`,

```bash
# Run download.sh script
$ ./download.sh 

# Run install.sh script. 
$ ./install.sh

# Run init.sh script 
$ ./init.sh
```

### 3. Start emulation

<pre class="language-bash"><code class="lang-bash"><strong># Check + Run  emulation
</strong>$ sudo ./run.sh -c &#x3C;brand> &#x3C;firmware> # check (best practice to ensure emulation goes smoothly)
$ sudo ./run.sh -r &#x3C;brand> &#x3C;firmware> # run without debugging 

# Auto “brand” 
$ sudo ./run.sh -r auto &#x3C;firmware>

# User/Kernel level debugging
$ sudo ./run.sh -d &#x3C;brand> &#x3C;firmware> # user-level debugging (shell, gdbserver, etc.)
$ sudo ./run.sh -b &#x3C;brand> &#x3C;firmware>
</code></pre>

**Example workflow**

A common workflow is set the brand as `auto`:

1. Run firmware emulation checks (`-c` flag)
2. Run user-level debuggin (`-d` flag)

* **option 2**: shell (debug console)

```bash
$ sudo ./run.sh -c auto FIRMWARE.bin
$ sudo ./run.sh -d auto FIRMWARE.bin
```

<figure><img src="../../.gitbook/assets/image (241).png" alt=""><figcaption></figcaption></figure>



### 4. View logs

The log files can be found under the `scratch/xxxx` folder, where `xxxx` is a unique ID for each run

{% code overflow="wrap" %}
```bash
$ cd scratch/xxxx
$ ls
makeNetwork.log qemu.initial.serial.log qemu.final.serial.log
...
```
{% endcode %}

**4.1 Useful log files**

1. `makeNetwork.log`
2. `makeImage.log`
3. `qemu.initial.serial.log`
4. `qemu.final.serial.log`
5. `emulation.log`

### 5. Cleanup&#x20;

> In the event that the process halts/freezes, and we are forced to use ctrl+c or ctrl+z to stop it, we have to manually cleanup the processes/files left behind&#x20;

{% code overflow="wrap" %}
```bash
$ ./util/cleanup.sh # from root firmware-mod-kit directory
$ sudo rm -rf scratch/xxxx

# clean up process
$ sudo -pkill -f firmae

# qclean up qemu process
$ pgrep -a qemu
QEMU-ID
$ sudo -pkill -f -9 QEMU-ID

# network interfaces
$ ifconfig
$ sudo ip link delete tapX # if any tapX interfaces still exist 

```
{% endcode %}



### Resources

{% embed url="https://github.com/pr0v3rbs/FirmAE" %}

{% embed url="https://github.com/firmadyne/firmadyne" %}

{% embed url="https://hackyboiz.github.io/2025/05/08/newp1ayer48/emulation1/en/" %}

<br>

