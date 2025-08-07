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

a. `-Identity`&#x20;

> Specifies an Active Directory user object.

b. `-Server`

> Specifies the Active Directory Domain Services instance to connect to, by providing one of the following values for a corresponding domain name or directory server.

c. `-Properties`

> Specifies the properties of the output object to retrieve from the server.

#### 1. Users

```powershell
PS> GET-ADUser -Identity <username> -Server <server> -Properties <props>
```

* `-Properties *`:  to display all the attributes set on the object

#### 2. Groups

```powershell
PS> GET-ADGroup -Identity <groupname> -Server <server>
```

_**Enumerate group membership**_

```powershell
PS> GET-ADGroupMember -Identity <groupname> -Server <server>
```

#### 3. AD Objects

For a more generic search on any AD objects, we can utilize the `Get-ADObject` cmdlet.

#### 4. Domains

We can use the `Get-ADDomain` cmdlet to retrieve more information about a specific domain:

```powershell
PS> GET-ADDomain -Server <server>
```

### Examples

1. **Find value of an attribute for a user/group**

**Standard command to list all the properties**

```powershell
PS> Get-ADUser -Identity <identity> -Server <server> -Properties *
PS> Get-ADGroup -Identity <identity> -Server <server> -Properties *
```

Eg. Find the creation date for the group _**Test Group**_ (`Created` attribute)_:_

```powershell
# eg. We can first list out all the properties
PS> GET-ADGroup -Identity "Test Group" -Server xxxx -Properties *

CanonicalName    : ...
CN               : Test Group
Created          : dd/mm/yyy xx.xx.xx.xx
...
```

Display only the specified property, along with other default properties:

```powershell
PS> Get-ADGroup -Identity "Test-Group" -Server xxxx -Properties Created
```

To retrieve the `Created` attribute only:

```powershell
PS> GET-ADGroup -Identity "Test Group" -Server xxxx -Properties Created | Select-Object -ExpandProperty Created
```
