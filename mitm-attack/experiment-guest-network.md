# Experiment (guest network)

Some guest networks may have a security setting which prevents hosts on the network from communicating with each other. This effectively prevents the basic forms of MitM attacks such as direct ARP/DNS spoofing of other hosts, etc.&#x20;

Let's assume the following:

1. Router have host isolation feature, but does not have built-in ARP spoofing prevention mechanisms for itself
2. The packet exchanged between the target host and remote server are not encrypted

I am experimenting with a method which involves the following steps (<mark style="color:red;">**not tested, just theorized only**</mark>):

1. ARP spoof packet to the router to trick it in thinking that attacker machine's MAC address is that of the target host

* All packets destined for the target host would come to the attacker (note that packets coming from the target are not spoofed)

2. Leaving as it is from step 1, denial-of-service would happen for the target. To continue with the attack to allow a MitM position, have a remote-controlled host on the internet to spoof the return packet that the target host is expecting

* This packet's destination MAC address would contain the actual address of the target host&#x20;
* The usual pattern is that the router would check that the destination MAC address is itself, before going on to resolve the IP address - <mark style="color:yellow;">will this trick the router to not ARP resolve the IP address and directly sent it to the destination MAC address instead?</mark>
* the goal is to have the router to directly send the packet to the target host, bypassing the need for ARP table lookup (which will return the MAC address of the attacker instead)

3. If this is successful, a MitM position is established, bypassing the host isolation feature
