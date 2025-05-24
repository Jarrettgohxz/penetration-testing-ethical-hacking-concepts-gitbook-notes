# vboxmanage

VBoxManage is a command line tool for configurations of the Oracle VM VirtualBox.

### NAT network

List all the created NAT networks

```bash
$ vboxmanage natnetwork list

# List a specific NAT network
$ vboxmanage natnetwork list [netname]
$ vboxmanage natnetwork list "natnetwork1"
```

Create a new NAT network

```bash
$ vboxmanage natnetwork add --netname [netname] --network [network-range] --dhcp=on

# eg. 
$ vboxmanage natnetwork add --netname "natnetwork1" --network "10.0.22.0/24" --dhcp=on
```

Start the newly created NAT network

```bash
$ vboxmanage natnetwork start --netname [netname]

# eg.
$ vboxmanage natnetwork start --netname "natnetwork1"
```



### Troubleshooting

Suppose we connect a guest machine to a NAT network created awhile back ago, and have not connected to it ever since. After starting the NAT network with the commands listed above, we view the network configurations on the guest machine (`ip a`, `ifconfig`), and realised that there is no IPv4 address specified (`inet`).

To fix the issue, we can simply create and start a new NAT network, before configuring the guest machine to join it. This will remove any issues related to the old network configurations due to potentially outdated settings, etc.
