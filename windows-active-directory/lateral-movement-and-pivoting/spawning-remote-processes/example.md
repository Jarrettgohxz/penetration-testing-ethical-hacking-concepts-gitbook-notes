# Example

Suppose the following scenario where we have obtained two sets of AD credentials: one with low privileges, and another with administrative access. Our goal is to obtain a shell session on an _IIS_ server with administrative privileges.

There are 2 servers we will be working with:

a. Intermediary (`jmp.domain`)

b. IIS (`iis.domain`)

Let's assume that the Intermediary server have no data that will be interesting to us, and it simply functions as an intermediary to get to the _IIS_ server. The main goal is the _IIS_ server, which is only accessible/routable from the intermediary server due to network restrictions, firewalls, etc.

The first set of AD credential allows us to gain a remote shell session on the intermediary machine (`jmp.domain`), via SSH. From there, we can use the obtained admin credentials to move laterally to the _IIS_ server (`iis.domain`), to gain a remote session with administrative privileges.

### (1) Using `sc.exe`

#### 1. SSH into the "intermediate" server (with the first set of low-privileged credentials)

#### 2. Craft the reverse shell payload (`msfvenom`) and upload it to the IIS server (with admin credentials)

#### 3. Spawn a remote netonly shell session on the intermediate server (as the admin)&#x20;

#### 4. Start a service (`sc.exe`) on the IIS server that automatically executes the uploaded reverse shell payload



{% embed url="https://jarrettgxz-sec.gitbook.io/networking-concepts/networking-tools/miscellaneous/smbclient" %}
