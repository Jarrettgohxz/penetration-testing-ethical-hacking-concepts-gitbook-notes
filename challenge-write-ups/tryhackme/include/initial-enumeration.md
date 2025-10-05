# Initial enumeration

In this step, we aim to discover open ports/services on the web server. The following shows how we can do it with `nmap`:

```sh
$ nmap -sS -n -Pn -v <target> 
```

{% embed url="https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/tools-services/network-recon-and-attacks/nmap-general-overview" %}

{% embed url="https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/network-port-scan-services-enumeration/nmap" %}

The following displays the output from the scan:

<figure><img src="../../../.gitbook/assets/image (39).png" alt=""><figcaption></figcaption></figure>

As we can see, there are multiple ports open, which is really exciting for us 🤤.&#x20;

The first service that I would like to find would be HTTP, which relates to a web application. Since the common HTTP(S) ports (**80** and **443**) are not open, we have to enumerate through each of the found ports to find the one that serves the content.&#x20;

We can manually visit each port from the browser. However, some security-enhanced ones such as Firefox may block non-standard ports. Alternatively, we can use the `curl` tool to test it too:

```bash
$ curl http://<target>:<port>
```

Ports _**4000**_ and _**50000**_ are found to return valid HTTP content (headers and body), this indicates that a web application is present.&#x20;
