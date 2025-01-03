# vboxmanage

VBoxManage is a command line tool for configurations for the Oracle VM VirtualBox.

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
