# Microsoft Management Console (MMC)

The Microsoft Management Console (MMC) provides a GUI. when used with the [Remote Server Administration Tool's](https://learn.microsoft.com/en-us/powershell/module/activedirectory/?view=windowsserver2022-ps) (RSAT) AD snap-ins, it can be used to enumerate and modify AD objects (with proper permissions).

However, this requires a remote desktop (RDP) access to the target machine. Running MMC normally may not work if the target computer is not domain-joined, as the local account cannot be used to authenticate to the domain. As a workaround, the `runas.exe` binary can be used:

```powershell
runas.exe /netonly /user:<domain>\<username> mmc.exe
```

Now, all the network connections initiated by MMC will use the injected AD credentials.
