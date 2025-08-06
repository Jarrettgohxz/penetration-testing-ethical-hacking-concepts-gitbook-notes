# runas.exe

{% embed url="https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc771525(v=ws.11)" %}

`runas.exe` is a legitimate, built-in Windows tool that allows a program to be executed under a specified user's credentials.

### Legitimate use cases

There are various legitimate use cases for the `runas.exe` binary, such as running admin tasks as a privileged user, performing test cases as another account, accessing remote network resource as another user (`/netonly` flag), all without switching user accounts. This supports the principle of least privilege: users will stay logged in as non-admins, and privileges are only elevated for selected programs/tasks.

### How it can be abused

As the `runas.exe` binary is treated as a legitimate software, it is trusted by most antivirus systems, and usage of this tool during a security assessment will usually not be flagged.&#x20;

#### Basic command

```powershell
runas.exe /netonly /user:<domain>\<username> <program_to_execute>
```

* `/netonly`

> Indicates that the user information specified is for remote access only

This option allows us to perform network connections using a specified account, but prevent authentication against the domain controller

* `/user`&#x20;

> Specifies the name of the user account under which to run the specified program

#### Launching a command prompt with the `/netonly` option

```powershell
runas.exe /netonly /user:<domain>\<username> cmd.exe
```
