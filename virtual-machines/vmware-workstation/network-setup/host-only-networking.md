# Host-only networking

{% embed url="https://techdocs.broadcom.com/us/en/vmware-cis/desktop-hypervisors/workstation-pro/17-0/using-vmware-workstation-pro/configuring-network-connections/configuring-host-only-networking.html" %}

When VMware Workstation Pro is installed on a Windows or Linux host system, a host-only network will be set up by default. The virtual network interface name will be `VMnet1` by default. In a host-only network, the guest VMs and the host machine's virtual network adapter are connected to a prviate Ethernet network, which is completely contained within the host system. The virtual network adapter will be visible on the host OS, along with a DHCP server. The image illustration below shows the configuration:

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

> Image taken directly from the VMware Workstation Pro Host-only networking information page (link above)
