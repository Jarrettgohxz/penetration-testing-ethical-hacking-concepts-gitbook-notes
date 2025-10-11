# dhcpserver

#### Common commands

{% code overflow="wrap" %}
```sh
$ vboxmanage dhcpserver add --ifname=<ifname> --ip=<ipv4> --netmask=<netmask> --lowerip=<lower_ip> --upperip=<upper_ip> --enable

$ vboxmanage dhcpserver remove --ifname=<ifname>

$ vboxmanage dhcpserver modify --ifname=<ifname> --interface=ifname > [--server-ip=address] [--lower-ip=address] [--upper-ip=address] [--netmask=mask] [ --enable | --disable ]

$ vboxmanage dhcpserver remove|start|stop|restart < --network=netname | --interface=ifname >

```
{% endcode %}

#### List

```sh
$ vboxmanage list dhcpservers
```
