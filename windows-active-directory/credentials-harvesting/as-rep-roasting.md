# AS-REP roasting

{% embed url="https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-kile/b4af186e-b2ff-43f9-b18e-eedb366abf13" %}

{% embed url="https://www.picussecurity.com/resource/blog/as-rep-roasting-attack-explained-mitre-attack-t1558.004" %}

{% embed url="https://jumpcloud.com/it-index/what-is-as-rep-roasting" %}

{% embed url="https://www.kali.org/tools/impacket-scripts/#impacket-getnpusers" %}

{% embed url="https://www.netwrix.com/as-rep-roasting.html" %}

### What is AS-REP roasting?

#### Pre-authentication enabled

In a standard Kerberos authentication flow (with pre-authentication active), a user initiates the process by sending an **authentication service request** (**KRB\_AS\_REQ**) to the KDC, with a timestamp encrypted using its own password. The KDC will validate the timestamp (using its stored version of the user's password), and if valid, response with an **authentication service response** (**KRB\_AS\_REP**) containing a TGT.

#### Pre-authentication disabled

However, with pre-authentication disabled, the KDC prematurely sends an **authentication service response** (**KRB\_AS\_REP**) upon receiving the **KRB\_AS\_REQ** for a particular user acount, without requiring any valid authentication details. This response includes a segment encrypted with a user's password hash (the user will be specified in the **KRB\_AS\_REQ**). This allows an an attacker to extract the encrypted data without knowledge of any authentication credentials, to perform offline brute-force or dictionary attacks to obtain the user's password.

### (1) Retrieve a list of user accounts

First, we have to retrieve a list of user accounts in the AD network:

```powershell
C:\> powershell -ep bypass
PS> Import-Module PowerView.ps1
PS>  Get-DomainUser
```

### (2) Enumerate user accounts with pre-authentication disabled, and perform AS-REQ

Next, we can use the `impacket-GetNPUsers` script which&#x20;

> Queries target domain for users with 'Do not require Kerberos\
> preauthentication' set and export their TGTs for cracking:

{% code overflow="wrap" %}
```sh
$ impacket-GetNPUsers -dc-ip <DOMAIN_CONTROLLER> -usersfile <PATH_TO_USERS_LIST> -format {hashcat,john} <TARGET>
```
{% endcode %}

* `<TARGET>:` The domain user account to authenticate to the KDC with
  * as long as a valid user account is provided, this value will not affect the results of the script
* `-dc-ip:` Address of the domain controller
* `-usersfile:` List of domain users to check against (retrieved from previous step)
* `-format:` Output format (hashcat or john). Default is hashcat.

With this, we should retrieve the TGTs for users with the pre-authentication disabled.

### (3) Offline cracking

Given that we output the hashes in hashcat format, we can perform the following commands to crack the passwords:

```sh
$ hashcat -a 0 -m <hash_mode> <path_to_hashes> <wordlist>

# eg. 
$ echo xxx > hashes.txt
$ hashcat -a 0 -m <hash_mode> hashes.txt /usr/share/wordlist/rockyou.txt
```

* `-a`: Attack mode
  * `-a 0`: Dictionary attack
  * `-m` : Hash mode
* `-m <hash_mode>`: either one of **18200, 32100, 32200** (depending on the encryption type of the hashes obtained)



