# vboxmanage

VBoxManage is a command line tool for configurations of the Oracle VM VirtualBox.

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

### Power button

This section outlines the commands that can be used to control the power options for a particular running virtual machine through the terminal.\


**List all running virtual machines:**

```bash
$ vboxmanage list runningvms
"name_of_vm" {xxxx}
```

**Power-off the machine:**

```bash
$ vboxmanage controlvm "name_of_vm" poweroff
# or
$ vboxmanage controlvm "name_of_vm" acipowerbutton
```
