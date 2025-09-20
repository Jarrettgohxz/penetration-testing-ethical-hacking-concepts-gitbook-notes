# Inter-Realm TGT

{% code overflow="wrap" %}
```powershell
mimikatz # kerberos::golden /sids:xxx ...
```
{% endcode %}

Essentially the same as the Mimikatz command to create a Golden Ticket, with the additional `/sids` option to specify the extra SID of the target domain.
