---
description: >-
  Network Address Translation (NAT) mode is the default networking mode used by
  VirtualBox.
---

# NAT

The following are the features of the _**NAT**_ settings:

1. Allows connection to the host machine (NAT gateway IP address)
2. Does not allow connection to the guest machine from the host
3. Does not allow connections to the machines on the same LAN as the host machine
4. Allows internet access

### Scenario

Given the following configurations:

1. Guest machine in a "_**NAT"**_ network setting(note: this is different from the "_**NAT network"**_ network setting)
2. Host machine with 2 services running: `111/tcp`, `631/tcp`, IP: `10.0.2.2` — this is the NAT gateway IP for the guest machine



The following image below displays the output from an `nmap` scan on the host machine (from the guest machine).

<figure><img src="../../../.gitbook/assets/image (11).png" alt=""><figcaption></figcaption></figure>



The image below displays the output from 3 commands:

1. TCP connection to the host machine at port _**111**_ (with _netcat_)
2. TCP connection at port _**631**_&#x20;
3. TCP connection at port _**632**_ — for control purposes

Notice that the response shows that ports _**111**_ and _**631**_ are open, while connection to port _**632**_ is reufsed — port is closed.

<figure><img src="../../../.gitbook/assets/image (7) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

### Conclusion

We can see that the guest machine in a "_**NAT"**_ network setting is able to communicate with the services on the host machine. For a more secure network setting, refer to the "[_**NAT network**_](https://jarrettgxz-sec.gitbook.io/offensive-security-concepts/virtualbox-network-setup/nat-network)" configuration.
