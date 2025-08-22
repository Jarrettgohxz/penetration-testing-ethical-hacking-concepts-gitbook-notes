# Pass-the-Ticket (Kerberos)

This method aims to extract Kerberos tickets and session keys from _**LSASS**_ memory using mimikatz, before using the stolen ticket to perform actions as the injected user. This process will usually require us to have _**SYSTEM**_ privileges on the machine.

We will start off with using mimikatz to extract all the Kerberos tickets present on the local machine:

```
mimikatz # privilege::debug
mimikatz # sekurlsa::tickets /export
```

While mimikatz can extract both the **Ticket Granting Ticket** (**TGT**) and **Ticket Granting Service** (**TGS**) available in the memory, we will mostly be interested in the **TGT**s as it allows us request to access to any service that our stolen user is allowed to access.

Once we have obtained our desired ticket (from the command shown above), we can inject the tickets into the current session:

{% code overflow="wrap" %}
```
mimikatz # kerberos::ptt xxxx@test.domain.kirbi
```
{% endcode %}

After running the command, we can exit from the `mimikatz` shell back to the command prompt. We can use the `klist` command to view the injected tickets:

```powershell
C:\> klist
```

Note that if we execute the `whoami` command, we will still see the original user we were using before performing the attack, but any commands executed from this session will use the injected credentials.

### Using the injected ticket

Now that we have injected the ticket, we can perform lateral movements as the injected user. For example, we can attempt to start a service on a target remote machine:

{% code overflow="wrap" %}
```powershell
C:\> schtasks /RU "SYSTEM" xxxx
```
{% endcode %}

A few basic conditions on the target machine must be in our favor :&#x20;

a. `schtasks` or any other desired tools are allowed

b. The injected user must be allowed to perform the desired actions (eg. in the `Administrators` group)

c. Kerberos authentication is used (instead of NTLM)

* this should not be an issue since Kerberos is the default for a domain environment
* however, other factors may cause Kerberos to fail: DNS issues, SPN lookup failure

If all goes well, we will be able to successfully execute remote commands (eg. reverse shell) on the target machine as the injected user; or in some cases, as `SYSTEM` (eg. `sc.exe` which by default runs as `SYSTEM` ).

