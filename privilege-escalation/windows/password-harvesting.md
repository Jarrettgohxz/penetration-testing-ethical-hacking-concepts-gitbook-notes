# Password harvesting

### Unattended installations

The following locations may contain administrative credentials that are used in unattended installations:

* `C:\Unattend.xml`
* `C:\Windows\Panther\Unattend.xml`
* `C:\Windows\Panther\Unattend\Unattend.xml`
* `C:\Windows\system32\sysprep.inf`
* `C:\Windows\system32\sysprep\sysprep.xml`

### Powershell History

The Powershell history can be viewed using Powershell at the file path: `$Env:userprofile\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt`

To view the file from a command prompt (`cmd.exe`), replace the `$Env:userprofile` at the start of the previously shown path to `%userprofile%`.

_**Powershell**_

```powershell
PS> type $Env:userprofile\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt
PS> Get-Content $Env:userprofile\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt
```

_**Command prompt (cmd.exe)**_

```powershell
cmd> type %userprofile%\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt
cmd> Get-Content %userprofile%\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt
```

Note: The `type` command is an alias for the `Get-Content` cmdlet.

_**Purpose of viewing the Powershell history**_:

There may be instances where there might be plaintext passwords provided directly to commands for user creation, login, etc. These passwords can be retrieved by viewingh the history.

```powershell
# Eg. Adding a new user to a resource, while providing plaintext password
PS> cmdkey /add:<target_resource> /user:<username> /pass:<plaintext_password>
```

### Saved credentials

View the stored credentials

The example below shows that the credentials for a user `rand_username` is stored:

```powershell
PS> cmdkey /list

Currently stored credentials:
  
    Target: Domain:interactive=rand_username       
    Type: Domain Password                           
    User: rand_username

...
```

We can used the stored credentials to run command as the user:

```powershell
PS> runas /savecred /user:rand_username <command_to_run>
```

### Internet Information Services (IIS)

The internet information services is a default web server on Windows installations. The configuration file is named `web.config`, which can store passwords for authentication for various services. Depending on the installed version of _**IIS**_, the `web.config` file can be found in the following locations:

* `C:\inetpub\wwwroot\web.config`
* `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config\web.config`

The following command allows us to find database connection strings from the `web.config` file:

```powershell
PS> type C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config\web.config | findstr connectionString
```

This command consists of two parts separated by the pipe (`|`) operator:

1. `type C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config\web.config`
   * View the contents of the `web.config` file
2. `findstr connectionString`
   * Utilizes the `findstr` command (similar to the `grep` command in Unix based systems) to find filter out the portion of the contents regarding the database connection strings
