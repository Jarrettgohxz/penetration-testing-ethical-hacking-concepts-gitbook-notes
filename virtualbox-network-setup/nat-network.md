---
description: The NAT network mode is different from the NAT mode.
---

# NAT network

The following are the features of the _**NAT network**_ settings:

1. ...



In this mode, the same features of the NAT mode is enabled, with the additional feature to allow the guest VM to communicate with the other VMs connected to the same NAT network on the same host machine. <mark style="color:red;">\*\* TO CONFIRM IF GUEST VM ABLE TO COMMUNICATE WITH HOSTS ON THE SAME LAN AS HOST MACHINE</mark>

Essentially, the NAT network mode contains both the elements present in the NAT and Internal network mode (discussed below).

### Example

Assume there is a need to simulate a LAN environment involving 2 machines, where 1 is the attacker, and another the target. Suppose there is only a single computer running VirtualBox to work with, where the physical network interface on the host machine is not enabled.

The NAT network mode can be used to simulate the LAN environment, along with selection of the operating system of choice of each machine on the LAN. In this case, the host machine would be acting as the router, with switching and routing functions.
