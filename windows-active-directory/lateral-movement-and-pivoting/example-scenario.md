---
description: >-
  The following outlines the setup which we will be working with for the next
  few sections under "Lateral movement & Pivoting".
---

# Example scenario

Suppose the following scenario where we have obtained two sets of AD credentials:&#x20;

a. Low privileges (user)

b. Administrative access (admin)&#x20;

Our goal is to obtain a shell session on an _IIS_ server with administrative privileges. There are 2 servers we will be working with:

a. Intermediary (`jmp.test.com`)

b. IIS (`iis.test.com`)

Let's assume that the Intermediary server have no data that will be interesting to us, and it simply functions as an intermediary to get to the _IIS_ server. The main goal is the _IIS_ server, which is only accessible/routable from the intermediary server due to network restrictions, firewalls, etc.

The first set of AD credential allows us to gain a remote shell session on the intermediary machine (`jmp.domain`), via SSH.&#x20;

However, the _IIS_ server does not expose a SSH service. Thus, we need to make use of the session we have on the intermediary server to move laterally to the _IIS_ server (`iis.test.com`) using the obtained admin credentials, to gain a remote session with administrative privileges.&#x20;
