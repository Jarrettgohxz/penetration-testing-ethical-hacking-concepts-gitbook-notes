# Common enumeration

## Resources

1. PowerShell history

{% embed url="https://0xdf.gitlab.io/2018/11/08/powershell-history-file.html" %}

{% embed url="https://learn.microsoft.com/en-us/powershell/module/psreadline/about/about_psreadline?view=powershell-7.5" %}

{% embed url="https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_history?view=powershell-7.5" %}

2. Windows registry

{% embed url="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/reg-query" %}

{% embed url="https://learn.microsoft.com/en-us/troubleshoot/windows-server/performance/windows-registry-advanced-users" %}

### PowerShell history

We can view the PowerShell history from the [PSReadline](https://learn.microsoft.com/en-us/powershell/module/psreadline/about/about_psreadline?view=powershell-7.5) module, which stores it in a file.

> PSReadLine provides an improved command-line editing experience in the PowerShell console.

The file can be found at:

```
C:\Users\<USER>\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt
```

For more information on the PSReadline options, we can run the `Get-PSreadlineOption` command.

### Registry

We can utilize the Windows registry to harvest information. The following command examples can be used to query the registry for the _password_ keyword:

```powershell
reg query HKLM /f password /t REG_SZ /s
reg query HKU /f password /t REG_SZ /s
```

a. `HKM`, `HKU`: These values refers to the _keyname_ option which must be specified

* `HKLM`: **HKEY\_LOCAL\_MACHINE** key which contains configuration information particular to the computer (for any user)
* &#x20;`HKU`: **HKEY\_USERS** key which contains all the actively loaded user profiles on the computer

> Since we did not specify a remote machine (`\\<computername>\` ), the operation will default to the local computer

b. `/f` : Specifies the data or pattern to search for

* In our case, the pattern we are searching for is _password_

c. `/t` : Specifies registry types to search. Valid types are: **REG\_SZ**, **REG\_MULTI\_SZ**, etc.

* In ourcase, we specify it as **REG\_SZ**, which is simply a fixed-length text string

d. `/s` : Specifies to query all subkeys and value names recursively
