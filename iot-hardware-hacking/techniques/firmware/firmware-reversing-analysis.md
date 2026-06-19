# Firmware reversing/analysis

### Setup (`sasquatch`)

The `sasquatch` binary is needed to extract content from a **Squashfs** filesystem. Usually, this can be performed with the `unsquashfs` binary installed by default. However, `unsquashfs` will not work with non-standard, modified **Squashfs** filesystem that are commonly used by vendors.

Fortunately, `sasquatch` provides a method to identify and adapt to changing compression headers, algorithms, block size or magic bytes, etc.

> Note that the `sasquatch` binary is likely installed by default on Kali Linux. You are only required to compile it from source if you are using another Linux flavor such as Ubuntu, etc.

{% code title="" %}
```bash
# Install dependencies
$ sudo apt install build-essential liblzma-dev liblzo2-dev zlib1g-dev

# Clone from source
$ git clone 
https://github.com/devttys0/sasquatch.git

$ cd sasquatch
$ cd squashfs4.3/squashfs-tools/sasquatch
$ EXTRA_CFLAGS="-fcommon -Wno-error=misleading-indentation -Wno-error=address-of-packed-member -Wno-error=dangling-pointer" ./build.sh

$ which sasquatch
/usr/local/bin/sasquatch

```
{% endcode %}

### Binwalk

* No option: simply show the sections
* `-e` / `--extract`  Automatically extract known file types

#### NO option

{% code title="" %}
```bash
$ binwalk <FIRMWARE>.bin

# eg.
$ binwalk DIR815A1_FW103b01.bin
```
{% endcode %}

<figure><img src="../../../.gitbook/assets/image (197).png" alt=""><figcaption></figcaption></figure>

We can see the following sections of the binary:

1. DLOB Firmware header
2. LZMA compressed data
3. Section delimeter
4. Squashfs filesystem

* This is what we are looking for

#### `-e` / `--extract` flag

{% code title="" %}
```bash
$ binwalk -e <FIRMWARE>.bin

# eg.
$ binwalk -e DIR815A1_FW103b01.bin
```
{% endcode %}

We will know be able to access the file system via the `squashfs-root` directory

<figure><img src="../../../.gitbook/assets/image (199).png" alt=""><figcaption></figcaption></figure>



### Resources

{% embed url="https://www.youtube.com/watch?v=GIU4yJn2-2A" %}





