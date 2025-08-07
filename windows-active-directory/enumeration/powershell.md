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

1. **Find value of an attribute for a user**

<pre class="language-powershell"><code class="lang-powershell"><strong>PS> Get-ADUser -Identity &#x3C;identity> -Server &#x3C;server> -Properties *
</strong></code></pre>

Eg. Find the value of the _Title_ attribute of _jarrett_:

```powershell
PS> Get-ADUser -Identity jarrett -Server xxxx -Properties Title
```



2. **Find the value of an attribute that is not shown directly**

Eg. Find the value of the _whenCreated_ attribute for the group _Test Group_:

```powershell
# Eg. List all properties
PS> Get-ADGRoup -Identity "Test-Group" -Server xxxx -Properties *

# Eg. list specific property: whenCreated
PS> Get-ADGRoup -Identity "Test-Group" -Server xxxx -Properties whenCreated
```

3. ...

