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

<pre class="language-bash"><code class="lang-bash"># Run download.sh script
$ ./download.sh 

# Run install.sh script. 
$ ./install.sh

# Run init.sh script 
$ ./init.sh

<strong># Check + Run  emulation
</strong>$ sudo ./run.sh -c &#x3C;brand> &#x3C;firmware>
$ sudo ./run.sh -r &#x3C;brand> &#x3C;firmware>

# Auto “brand”
$ sudo ./run.sh -r auto &#x3C;firmware>

# User/Kernel level debugging
$ sudo ./run.sh -d &#x3C;brand> &#x3C;firmware>
$ sudo ./run.sh -b &#x3C;brand> &#x3C;firmware>
</code></pre>

**Example**

```bash
$ sudo ./run.sh -d auto firmware_file.bin
```

### Resources

{% embed url="https://github.com/pr0v3rbs/FirmAE" %}

{% embed url="https://github.com/firmadyne/firmadyne" %}

{% embed url="https://hackyboiz.github.io/2025/05/08/newp1ayer48/emulation1/en/" %}

<br>

