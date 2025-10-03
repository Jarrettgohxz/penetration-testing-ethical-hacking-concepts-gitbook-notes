# New Technologies Directory Services (NTDS)

### Resources

{% embed url="https://www.thehacker.recipes/ad/movement/credentials/dumping/ntds" %}

{% embed url="https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc753343(v=ws.11)" %}

{% embed url="https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc732530(v=ws.11)" %}

{% embed url="https://www.semperis.com/blog/ntds-dit-extraction-explained/" %}

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



We can now view the dumped files in the `c:\temp` directory, and provide the relevant paths to the 3 files listed above (`ntds.dit` and the other 2 registry files) to the **impacket's secretsdump.py** tool to extract the hashes:

{% code overflow="wrap" %}
```powershell
```
{% endcode %}

### (2) Remote dumping (with credentials)



