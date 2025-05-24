# Overview

The following provides an overview of the comparisons between the common VirtualBox network settings.&#x20;

> Note: The following are assumed:
>
> 1. &#x20;NO port forwarding rules are being added
> 2. The host machine is not on the same NAT network as the host (but rather acting as the NAT) — for the "_**NAT network**_" configuration.

<table><thead><tr><th>Mode</th><th width="160.818115234375">Can connect to host?</th><th width="289.818115234375">Can connect to machines on the same LAN as the host?</th><th width="330.8182373046875">Can access internet?</th></tr></thead><tbody><tr><td><strong>Bridged Adapter</strong></td><td><mark style="color:green;">✓</mark></td><td><mark style="color:green;">✓</mark></td><td><mark style="color:green;">✓</mark></td></tr><tr><td><strong>NAT</strong></td><td><mark style="color:green;">✓</mark></td><td><mark style="color:red;">✘</mark></td><td><mark style="color:green;">✓</mark></td></tr><tr><td><strong>NAT Network</strong></td><td><mark style="color:red;">✘</mark></td><td><mark style="color:red;">✘</mark></td><td><mark style="color:green;">✓</mark></td></tr><tr><td><strong>Internal Network</strong></td><td><mark style="color:green;">✓</mark></td><td><mark style="color:red;">✘</mark></td><td><mark style="color:red;">✘</mark></td></tr></tbody></table>
