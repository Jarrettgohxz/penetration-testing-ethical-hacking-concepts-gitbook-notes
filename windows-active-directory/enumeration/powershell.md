# Powershell

Powershell is an extension to the command prompt, and provides more control over commands.&#x20;

From the official Microsoft docs:

> The Active Directory module for Windows PowerShell is a PowerShell module that consolidates a group of cmdlets. You can use these cmdlets to manage your Active Directory domains, Active Directory Lightweight Directory Services (AD LDS) configuration sets, and Active Directory Database Mounting Tool instances in a single, self-contained package.
>
> If you don't have the Active Directory module installed on your machine, you need to download the correct Remote Server Administration Tools (RSAT) package for your OS.

The commands utilized are referred to as `cmdlets` .

{% embed url="https://learn.microsoft.com/en-us/powershell/module/activedirectory/get-aduser?view=windowsserver2022-ps" %}

### AD enumeration

**Important option used in the subsequent commands**

> Note that some of the commands (eg. `Get-ADDomain` , etc.) may not support all the options listed below.  Refer to the respective documentation in the official link above for more information, and this list is provided just for a quick reference

a. `-Identity`&#x20;

> Specifies an Active Directory user object.

b. `-Server`

> Specifies the Active Directory Domain Services instance to connect to, by providing one of the following values for a corresponding domain name or directory server.

c. `-Properties`

> Specifies the properties of the output object to retrieve from the server.

#### 1. Users

```powershell
PS> GET-ADUser -Identity <username> -Server <server> -Properties <properties>
```

* `-Properties *`:  to display all the attributes set on the object

#### 2. Groups

```powershell
PS> GET-ADGroup -Identity <groupname> -Server <server> -Properties *
```

`-Properties *`:  to display all the attributes set on the object

_**Enumerate group membership**_

```powershell
PS> GET-ADGroupMember -Identity <groupname> -Server <server>
```

#### 3. AD Objects

For a more generic search on any AD objects, we can utilize the `Get-ADObject` cmdlet.

**Examples using `Get-ADObject`**

_Useful reference:_

{% embed url="https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/windows-active-directory/enumeration/powershell/objectclass" %}

1. Filter by `ObjectClass` , `Name` , etc.

`ObjectClass`

{% code title="" %}
```powershell
PS> Get-ADObject -Filter 'ObjectClass -eq "container"'
DistinguishedName                                   Name           
-----------------                                   ----
CN=Users,DC=test,DC=com                             Users
CN=Computers,DC=test,DC=com                         Computers       
CN=System,DC=test,DC=com                            System
CN=WinsockServices,CN=System,DC=za,DC=test,DC=com   WinsockServices
CN=Program Data,DC=za,DC=tryhackme,DC=com           Program Data 
...
redacted 
...
```
{% endcode %}

```powershell
PS> Get-ADObject -Filter 'ObjectClass -eq "user"'
PS> Get-ADObject -Filter 'ObjectClass -eq "organizationalUnit"'
# and many more!
```

`Name`

```powershell
PS> Get-ADObject -Filter 'Name -eq "Computers"'
DistinguishedName                            Name       ObjectClass         ObjectGUID
-----------------                            ----       -----------         ----------
CN=Computers,DC=test,DC=com                  Computers  container           xxxx
OU=Computers,DC=test,DC=com                  Computers  organizationalUnit  xxxx
...

PS> Get-ADObject -Filter 'Name -eq "Users"'                                                       

DistinguishedName                             Name      ObjectClass            ObjectGUID
-----------------                             ----      -----------            ----------
CN=Users,DC=test,DC=com                       Users     container              xxxx
CN=Users,CN=Builtin,DC=test,DC=com            Users     group                  xxxx
OU=Users,OU=Accounts,DC=test,DC=com           Users     organizationalUnit     xxxx
...

PS> Get-ADObject -Filter 'Name -eq "WinSockServices"'         
                                                                                                              
DistinguishedName                              Name             ObjectClass   ObjectGUID
-----------------                              ----             -----------   ----------
CN=WinsockServices,CN=System,DC=test,DC=com    WinsockServices  container     xxxx
...

```

We can even add the `-Properties *` option to view the full list of properties each object has.&#x20;

> Note that the example outputs shown above simply illustrates a hypothetical example that have been slightly modified based on my experiment on a test AD network.

#### 4. Domains

We can use the `Get-ADDomain` cmdlet to retrieve more information about a specific domain:

```powershell
PS> GET-ADDomain -Server <server>
```

### Examples

1. **Find the value of a property for a user/group**

Suppose we want to find the creation date for the group _**Test Group**_ (`Created` attribute)_:_

```powershell
# eg. We can first list out all the properties
PS> GET-ADGroup -Identity "Test Group" -Server xxxx -Properties *

CanonicalName    : ...
CN               : Test Group
Created          : dd/mm/yyy xx.xx.xx.xx
...
```

To display only the specified property, along with other default properties (automatically included by the command):

```powershell
PS> Get-ADGroup -Identity "Test-Group" -Server xxxx -Properties Created
```

To retrieve the `Created` attribute only:

```powershell
PS> GET-ADGroup -Identity "Test Group" -Server xxxx -Properties Created | Select-Object -ExpandProperty Created
```
