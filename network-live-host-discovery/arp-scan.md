# arp-scan

```bash
$ sudo arp-scan <host_range>
# eg.
$ sudo arp-scan 10.10.10.0/24
```

`--localnet` or `-l`

> This command will send ARP queries to all valid IP addresses on your local networks

```bash
$ sudo arp-scan --localnet <host_range>
$ sudo arp-scan -l <host_range>

```

Allow to specify interface

```bash
$ sudo arp-scan [host] -I [iface]
$ sudo arp-scan [host] --interface=[iface]
```

{% embed url="https://www.royhills.co.uk/wiki/index.php/Arp-scan_Documentation" %}
