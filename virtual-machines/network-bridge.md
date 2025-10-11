# Network bridge

In this setup, we discuss how we can connect 2 or more **host-only networks** (from either VirtualBox or VMware) through a network bridge.

```sh
# create bridge
sudo ip link add name bridge-iface type bridge
sudo ip link set up dev bridge-iface

# add host-only interfaces to the bridge (one from VirtualBox and another from VMware)
sudo ip link set dev vboxnet0 master bridge-iface
sudo ip link set dev vmnet8 master bridge-iface

# bring the interfaces up
sudo ip link set up dev vboxnet0
sudo ip link set up dev vmnet8

```

* ...
