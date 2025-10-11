# Host-only network

{% embed url="https://www.virtualbox.org/manual/ch08.html#vboxmanage-hostonlyif" %}

#### Available commands

{% code overflow="wrap" %}
```sh
$ vboxmanage hostonlyif ipconfig <ifname> [ --dhcp | --ip=IPv4-address [--netmask=IPv4-netmask] | --ipv6=IPv6-address [--netmasklengthv6=length] ]

$ vboxmanage hostonlyif create

$ vboxmanage hostonlyif remove <ifname>
```
{% endcode %}

#### Create a new network interface on the host system

```sh
$ vboxmanage hostonlyif create
... created <vboxnet-iface>

$ sudo ip link set <vboxnet-iface> up
```

#### View created interfaces

```sh
$ vboxmanage list hostonlyifs
$ ifconfig <iface>
```

