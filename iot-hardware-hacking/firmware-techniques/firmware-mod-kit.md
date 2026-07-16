# firmware-mod-kit

**Source:**

{% embed url="https://github.com/rampagex/firmware-mod-kit" %}

**Fork** (if for whatever reasons, they removed the source):

{% embed url="https://github.com/Jarrettgohxz/firmware-mod-kit" %}

## `Installation`

{% code title="" %}
```bash
# clone from source
$ git clone https://github.com/Jarrettgohxz/firmware-mod-kit.git
$ cd firmware-mod-kit

# install dependencies
$ sudo apt-get install git build-essential zlib1g-dev liblzma-dev python3-magic autoconf python-is-python3
```
{% endcode %}

## `extract-firmware.sh`

* extracts root filesystem from a firmware image (similar to `binwalk`)

{% code title="" %}
```bash
$ ./extract-firmware.sh FIRMWARE.bin
```
{% endcode %}

* extracts to **fmk/rootfs**

## `build-firmware.sh`

{% code title="" %}
```bash
$ ./build-firmware.sh 

# options
$ ./build-firmware.sh -nopad -min
```
{% endcode %}

* builds the content in **fmk/rootfs**
* output to **fmk/new-firmware.bin**

> notes extracted directly from Github repo

The optional `-nopad` switch will instruct build-firmware.sh to NOT pad the firmware up to its original size.

The optional `-min` switch will use the maximum squashfs block size of 1MB. This will decrease the firmware image size at the cost of additional CPU and RAM resources utilized on the target device. Do not use this switch unless you must. This is a very large block size for embedded systems. The original firmware squashfs block size is preserved on rebuild, and the original block size should be the one used unless you are sure you know what you're doing. Too large a block size may appear to work fine, but runtime performance of the firmware may suffer in all or some loads.

## Extract, modify, build

Let's take a look at a simple example of how we can extract filesystem from a firmware, modify it, and build it back into a functional version



