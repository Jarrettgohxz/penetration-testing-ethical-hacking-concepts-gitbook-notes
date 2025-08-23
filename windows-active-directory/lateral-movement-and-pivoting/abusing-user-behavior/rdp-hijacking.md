# RDP hijacking

## Resources

1. `tscon`

{% embed url="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tscon" %}

## Hijack RDP session

When an administrator uses Remote Desktop to connect to machine and closes the Remote Desktop Protocol (RDP) client instead of logging off, the session associated with the connection will remain open on the server indefinitely.&#x20;

If we have SYSTEM privileges on Windows Server 2016 and earlier, it is possible to take over any existing RDP session without requiring a password.

> Note: Windows Server 2019 won't allow you to connect to another user's session without the password

First, we have to retrieve a command prompt session as the SYSTEM user. Next, we can list the existing sessions on a server:

```powershell
C:\> query user
 USERNAME              SESSIONNAME        ID  STATE   IDLE TIME  LOGON TIME
 <username>                               3  Disc            .  xxxx
 ...
```

Notice the value of `Disc` under the **STATE** field, which means that the connection has been left open by the user and isn't being used at the moment. We can hijack the session:

{% code overflow="wrap" %}
```powershell
C:\> tscon <ID> /dest:<current_session>
```
{% endcode %}

* `<ID>`: Specifies the ID of the session to which you want to connect
* `/dest` : Specifies the name of the current session.

