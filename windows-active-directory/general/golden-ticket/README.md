# Golden Ticket

{% code overflow="wrap" %}
```powershell
mimikatz # kerberos::golden /user:Administrator /domain:<child domain> /sid:S-xxx /service:krbtgt /rc4:<Password hash of krbtgt user>
```
{% endcode %}

a. `/user:Administrator` : ...

b. ...

c. `/service:krbtgt` : specifies that this ticket is a TGT

#### Comparisons with other tools

Notice that the following fields does not need to be specified when creating a TGT with other tools such as mimikatz `kerberos::tgt` , kekeo `tgt::ask` or Rubeus `asktgt` :

a. `/service:krbtgt`

b. `/sid:xxxx`

This is because these tools actually requests a real TGT from the KDC (automatically handles it), while in  a Golden Ticket attack, we bypass the KDC altogether and create our own TGTs.&#x20;

> NOTE: Even though Golden Ticket are always TGTs (`/service:krbtgt` by default), Mimikatz provides flexibility with this field and forces users to explicitly identify it.

