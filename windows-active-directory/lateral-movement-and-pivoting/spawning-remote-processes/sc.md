# sc

{% embed url="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/sc-create" %}

`sc.exe` uses the following ports:

* 135/TCP, 49152-65535/TCP (DCE/RPC)
* 445/TCP (RPC over SMB Named Pipes)
* 139/TCP (RPC over SMB Named Pipes)

It requires the supplied username and password to be part of the `Administrators` group.

### Basic commands

```powershell

# create
sc.exe \\TARGET create <servicename> binPath= "<service_bin_file" start= auto

# start
sc.exe \\TARGET start <servicename>
```

* `binPath` : Specifies a path to the service binary file. This value can be used to perform remote code execution too
* `start` : Specifies the start type for the service. Refer to the documentation link above for the full list of available options.
  * `auto` specifies a service that automatically starts each time the computer is restarted and runs even if no one logs on to the computer.

#### Cleanup

```powershell
sc.exe \\TARGET stop <servicename>
sc.exe \\TARGET delete <servicename>
```

