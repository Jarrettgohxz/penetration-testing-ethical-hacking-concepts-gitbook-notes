---
description: >-
  The bridged adapter mode allows a guest VM to access the network via the
  physical interface of the host machine.
---

# Bridged adapter



The following are the features of the _**Bridged Adapter**_ settings:

1. ...



In this way, the guest VM is able to communicate with the host machine itself, the addresses in the LAN of the host machine and also the internet.&#x20;

### Demonstration

#### Setting up on VirtualBox

#### Network communication example

1. The host machine itself
2. Addresses on the LAN of the host machine
3. External networks such as the internet

### Example

Assume there is a need to run a LAN-based attack simulation with two computers on the same physical LAN. Suppose the attacker machine OS is running on a VirtualBox instance on a host machine, along with another target machine running on bare-metal (not on any VM). With the default NAT networking mode, the attacker machine OS would not be able to communicate/send network traffic to the target machine.&#x20;

With the bridged adapter mode enabled on the VM,  the attacker machine would be able to retrieve an IP address that is on the same LAN subnet as the target machine, and be able to send network traffic as if its directly connected to the same physical LAN.&#x20;





