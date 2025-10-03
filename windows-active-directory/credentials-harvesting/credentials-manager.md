# Credentials Manager

### Resources

1. **MITRE ATT$CK**

{% embed url="https://attack.mitre.org/techniques/T1555/004/" %}

2. **Additional resources (The Hacker Recipes)**

{% embed url="https://www.thehacker.recipes/ad/movement/credentials/dumping/windows-credential-manager" %}

3. **GetWebCredentials.ps1 (nishang)**

{% embed url="https://github.com/samratashok/nishang/blob/master/Gather/Get-WebCredentials.ps1" %}

4. **cmdkey**

{% embed url="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/cmdkey" %}



### (1) vaultcmd

**1.1** `/list`

By default, Windows has two vaults: **Web** and **Windows machine credentials**. The following command displays the two vaults:

```powershell
C:\> vaultcmd /list
```

**1.2** `/listproperties`

The following commands will list the properties of the web and windows machine credentials respectively:&#x20;

```powershell
C:\> vaultcmd /listproperties:"web credentials"
C:\> vaultcmd /listproperties:"windows credentials"
```

**1.3** `/listcreds`

List more information about the stored credentials (for web and windows machine respectively):

```powershell
C:\> vaultcmd /listcreds:"web credentials"
C:\> vaultcmd /listcreds:"windows credentials"
```

### (2) cmdkey

```powershell
C:\> cmdkey /list
```

### Overview of differences between `vaultcmd` and `cmdkey`

1. `vaultcmd /list`&#x20;

a. Displays both the **Web Credentials** and **Windows Credentials**

&#x20;2\. `cmdkey /list`&#x20;

a. Displays the credentials stored under **Windows Credentials** only

b. Displays the entries added via `cmdkey /add` or `runas.exe /savecred` commands

c. The output from the `vaultcmd /list` may overlap with the results from `vaultcmd /listcreds`











