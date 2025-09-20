# Golden Ticket

{% embed url="https://tools.thehacker.recipes/mimikatz/modules/kerberos/golden" %}

{% code overflow="wrap" %}
```powershell
mimikatz # kerberos::golden /user:Administrator /domain:<domain> /sid:S-xxx /service:krbtgt /rc4:<Password hash of krbtgt user>
```
{% endcode %}

a. `/user:Administrator` : To impersonate the `Administrator` user

b. `/domain` : Specify the FQDN of where the ticket will be valid

c. `/sid:S-xxx` : The security identifier (SID) of the user to impersonate&#x20;

* Used to construct the Privilege Attribute Certificate (PAC) inside the Kerberos ticket

c. `/service:krbtgt` : specifies that this ticket is a TGT

d. `/rc4` : password hash of the **KRBTGT** account for the specified domain (`/domain` )

#### Comparisons with other tools

Notice that the following fields does not need to be specified when creating a TGT with other tools such as mimikatz `kerberos::tgt` , kekeo `tgt::ask` or Rubeus `asktgt` :

a. `/service:krbtgt`

b. `/sid:xxxx`

This is because these tools automatically includes the `/service` field, before sending an actual TGT request to the KDC (which handles the `/sid`).&#x20;

While for the Golden Ticket attack, we bypass the KDC altogether and create our own TGTs. Therefore, we have to perform a request to the domain controller to retrieve the SID, and manually include it in the `/sid` option.

> NOTE: Even though Golden Ticket are always TGTs (`/service:krbtgt` by default), Mimikatz provides flexibility with this field and forces users to explicitly identify it.

