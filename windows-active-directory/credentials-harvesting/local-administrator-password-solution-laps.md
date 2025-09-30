# Local Administrator Password Solution (LAPS)

### Resources

#### (1) Learning resources

1. **ms-Mcs-AdmPwd attribute**

{% embed url="https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-ada2/ad2ce8fa-42a0-4371-ad18-5d1d1c488b22" %}

2. What is Windows LAPS?

{% embed url="https://learn.microsoft.com/en-us/windows-server/identity/laps/laps-overview" %}

3. Windows LAPS PowerShell cmdlets

{% embed url="https://learn.microsoft.com/en-us/windows-server/identity/laps/laps-management-powershell" %}

#### (2) Exploitation examples

{% embed url="https://viperone.gitbook.io/pentest-everything/everything/everything-active-directory/laps" %}

{% embed url="https://github.com/passtheticket/Abusing_Laps_Toolkit" %}

PDF: [https://www.exploit-db.com/docs/english/50680-abusing-laps---paper.pdf?utm\_source=dlvr.it\&utm\_medium=twitter](https://www.exploit-db.com/docs/english/50680-abusing-laps---paper.pdf?utm_source=dlvr.it\&utm_medium=twitter)

### Basic concepts

What is the `ms-Mcs-AdmPwd` attribute?

...



### AllExtendedRights

#### 1. What is the "All extended rights" attribute given to an AD organizational unit (OU) under the context of LAPS?

For a given OU with this attribute set, any extended right holders (groups, users, etc.) will be able to read the LAPS password for any machines under that particular OU. Since the LAPS password mostly involves the local administrator account, this means that the rights holder will be able to retrieve the password for that account (stored in the `ms-Mcs-AdmPwd` attribute).

#### Exploitation steps

1. Find an OU has the "All extended rights" attribute that deals with LAPS

...

2. Retrieve the extended right holders for that particular OU

```powershell
PS> Find-AdmPwdExtendedRights -Identity <OU>
```

...

3. Retrieve the users in the group

Given that a particular group has the extended rights, ...

```powershell
PS> net groups <GROUP>
PS> Get-ADGroupMembers ...
```

...

4. Retrieve the LAPS password

Given that we have compromised or impersonate a particular user of the group (found in the previous step), we can retrieve the LAPS password of a particular machine under the OU. This will provide us with the local administrator password for that machine.

First, we have to load the credentials for the user to impersonate using either a TGT (ptt) or simply using a username and password combination with the `runas.exe` utility:  &#x20;

```powershell
mimikatz # kerberos::ptt ...
PS> runas.exe /netonly ...
```

Next, we can retrieve the password:

```powershell
PS> Get-AdmPwdPassword -ComputerName <TARGET_COMPUTER>
```

...



