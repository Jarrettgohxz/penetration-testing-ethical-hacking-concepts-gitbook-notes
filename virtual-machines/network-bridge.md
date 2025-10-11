# Network bridge

{% embed url="https://www.geeksforgeeks.org/computer-networks/what-is-bridge-in-computer-network-types-uses-functions-differences/" %}

{% embed url="https://wiki.archlinux.org/title/Network_bridge" %}

{% embed url="http://developers.redhat.com/blog/2018/10/22/introduction-to-linux-interfaces-for-virtual-networking#bridge" %}

{% embed url="https://www.baeldung.com/linux/bridging-network-interfaces" %}

### What is a network bridge?

A network bridge is a networking device in a network that is used to connect multiple LANs to a larger LAN.

### Creating a virtual network bridge

In this setup, we discuss how we can connect 2 interfaces:&#x20;

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

### Create virtual network bridge between 2 host-only VM interfaces

Suppose we want to create a network bridge (on a host OS) to bridge 2 host-only networks (from both VirtualBox and VMware). The method above of simply making the bridge interface the master of the 2 host-only interfaces will not work, since the host-only interfaces are fundamentally isolated, and the layer 2 packets (which the network bridge depends upon) will not leave the respective host-only interfaces.

#### TAP interface

{% embed url="https://www.baeldung.com/linux/create-check-network-interface" %}

I would like to experiment with a TAP interface instead ...

