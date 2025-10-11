# Network bridge

{% embed url="https://www.geeksforgeeks.org/computer-networks/what-is-bridge-in-computer-network-types-uses-functions-differences/" %}

{% embed url="https://wiki.archlinux.org/title/Network_bridge" %}

{% embed url="http://developers.redhat.com/blog/2018/10/22/introduction-to-linux-interfaces-for-virtual-networking#bridge" %}

{% embed url="https://www.baeldung.com/linux/bridging-network-interfaces" %}

### What is a network bridge?

A network bridge is a networking device in a network that is used to connect multiple LANs to a larger LAN.

### Creating a virtual network bridge

In this setup, we discuss how we can connect 2 **host-only networks** (from both VirtualBox and VMware)  through a network bridge.

```sh
# (1) 
sudo ip link add name bridge-iface type bridge # create bridge
sudo ip link set up dev bridge-iface # bring the bridge up

# (2) add host-only interfaces to the bridge (one from VirtualBox and another from VMware)
sudo ip link set dev vboxnet1 master bridge-iface
sudo ip link set dev vmnet1 master bridge-iface

# (3) bring the interfaces up
sudo ip link set up dev vboxnet0
sudo ip link set up dev vmnet8

```

#### Step 1

* Create a bridge named **bridge-iface**
* Enable the bridge&#x20;

#### Step 2

* Suppose that the interface from _VirtualBox_ and _VMware_ are named **vboxnet1** and **vmnet1** respectively
* Link both the interfaces to the bridge (acting as the _master_ device)

#### Step 3

* Enable both the **vboxnet1** and **vmnet1** interfaces

### Verify the bridge configuration

{% code overflow="wrap" %}
```sh
$ ip link show <iface> 
xxx: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 ... master <master-iface> # noticen the text master <master-iface>

# OR
$ bridge link
```
{% endcode %}

### Remove master configuration

```sh
$ sudo ip link set dev <iface> nomaster
```

