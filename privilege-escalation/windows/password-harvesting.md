# Password harvesting

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
