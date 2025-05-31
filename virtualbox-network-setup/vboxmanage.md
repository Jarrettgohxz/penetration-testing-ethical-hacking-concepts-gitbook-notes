# vboxmanage

VBoxManage is a command line tool for configurations of the Oracle VM VirtualBox.

### NAT network

**List all the created NAT networks**

```bash
$ vboxmanage natnetwork list

# List a specific NAT network
$ vboxmanage natnetwork list [netname]
$ vboxmanage natnetwork list "natnetwork1"
```

**Create a new NAT network**

```bash
$ vboxmanage natnetwork add --netname [netname] --network [network-range] --dhcp=on

# eg. 
$ vboxmanage natnetwork add --netname "natnetwork1" --network "10.0.22.0/24" --dhcp=on
```

**Start the newly created NAT network**

```bash
$ vboxmanage natnetwork start --netname [netname]

# eg.
$ vboxmanage natnetwork start --netname "natnetwork1"
```

### Troubleshooting

Suppose we have issues connecting the `eth0` interfance on a Linux guest machine to the **NAT network**. Even after restarting the network interface:

```bash
$ ip link set eth0 down
$ ip link set eth0 up
```

The interface still have issues, such that the network configurations on the guest machine have no IPv4 address  (`inet`) specified.

```bash
$ ip addr show eth0
$ ifconfig eth0
```

Pinging the gateway and other common addresses does not work:

```bash
$ ping <gateway>
$ ping 1.1.1.1

... Destination Host Unreachable

```

**Restart the network**&#x20;

```bash
$ vboxmanage dhcpserver remove --netname [nat_network]
$ vboxmanage natnetwork stop --netname [nat_network]
$ vboxmanage natnetwork start --netname [nat_network]

# eg.
$ vboxmanage dhcpserver remove --netname "isolate"
$ vboxmanage natnetwork stop --netname "isolate"
$ vboxmanage natnetwork start --netname "isolate"
```

**Create a new NAT network**

If the above solution fails, we can simply create and start a new NAT network (refer to the examples above), before configuring the guest machine to join it. This will remove any issues related to the old network configurations due to potentially outdated settings, etc.
