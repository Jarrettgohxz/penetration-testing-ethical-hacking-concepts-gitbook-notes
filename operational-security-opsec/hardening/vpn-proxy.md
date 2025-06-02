# VPN/Proxy

### Verify the VPN connection



1. **Verify configured network interfaces**
   * Ensure that additional interfaces (on top of the default ones such as `eth0` and `lo`) are added
   * Some other names are: `tun0`, `tun1`, etc.

```bash
$ ifconfig
# or
$ ip a

eth0 ...
lo ...
vpn_provider_wg ... # VPN provider interface (WireGuard)
```



2. **Verify public IP address (Ensure there is no IP leak)**
   * Ensure that the address of the VPN server is displayed instead

```bash
$ curl ifconfig.me
[vpn_ip_addr]
```



3. **Verify DNS resolution**
   * For most cases, the VPN provider will update the `/etc/resolv.conf` file to include their own DNS server address(es).
   * Trusted and secure DNS servers such as Google (`1.1.1.1`) and Cloudflare (`8.8.8.8`) may be used too.

```bash
$ cat /etc/resolv.conf

nameserver [vpn_dns_server1]
nameserver [vpn_dns_server2]
nameserver ...
```

> Note: Some VPNs use `systemd-resolved` or other resolvers, so DNS settings might be managed elsewhere (`/run/systemd/resolve/resolv.conf`).



4.  Verify if there are WebRTC, DNS or IP leaks.

    * This step presents another method to test for IP leak
    * Additional tests for WebRTC and DNS leaks should be performed too

    Website to run the test: [https://browserleaks.com](https://browserleaks.com/).

