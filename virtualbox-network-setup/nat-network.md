---
description: The NAT network mode is different from the NAT mode.
---

# NAT network

The following are the features of the _**NAT network**_ settings:

1. Does not allow connection to the host machine (NAT gateway IP address)
2. Does not allow connection to the guest machine from the host
3. Does not allow connections to the machines on the same LAN as the host machine
4. Allows internet access

This network configuration is similar to the "_**NAT**_" network settings, with the only difference that this method does not allow connections to the host machine. The example scenario below illustrates this.

### Scenario

Given the following configurations:

1. Guest machine in a "_**NAT network"**_ network setting (note: this is different from the "_**NAT "**_ network setting)
2. Host machine with 2 services running: `111/tcp`, `631/tcp`, IP:  `10.0.22.1`&#x20;

> Note the 2 services are known to be running as with discovered when the guest machine is connected to the host with a "_**NAT**_" network setting.

The following image below displays the output from an `nmap` scan on the host machine (from the guest machine). As we can see, the only service available is on port 53 (_DNS_).

<figure><img src="../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

The image below illustrates 3 connections:

1. TCP connection to port 111 — connection refused, even though the service is actually running&#x20;
2. TCP connection to port 112 — control purposes
3. TCP connection to port 631 — connection refused, but
4. &#x20;it is actually running, same as with port `111`

<figure><img src="../.gitbook/assets/image (9) (1).png" alt=""><figcaption></figcaption></figure>

### Conclusion

The NAT network configuration allows us to create an isolated and secure environment for a machine, where connections to the host machine are disabled.

### Example

Assume there is a need to simulate a LAN environment involving 2 machines, where 1 is the attacker, and another the target. Suppose there is only a single computer running VirtualBox to work with, where the physical network interface on the host machine is not enabled.

The NAT network mode can be used to simulate the LAN environment, along with selection of the operating system of choice of each machine on the LAN. In this case, the host machine would be acting as the router, with switching and routing functions.
