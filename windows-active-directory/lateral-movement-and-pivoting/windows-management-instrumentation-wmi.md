# Windows Management Instrumentation (WMI)

### Resources

1. **Common Information Model (CIM)**

**a. General information**

{% embed url="https://learn.microsoft.com/en-us/windows/win32/wmisdk/common-information-model" %}

**b. New-CimSession**

{% embed url="https://learn.microsoft.com/en-us/powershell/module/cimcmdlets/new-cimsession?view=powershell-7.5" %}

**c. New-CimSessionOption**

{% embed url="https://learn.microsoft.com/en-us/powershell/module/cimcmdlets/new-cimsessionoption?view=powershell-7.5" %}



2. **Invoke-CimMethod**

{% embed url="https://learn.microsoft.com/en-us/powershell/module/cimcmdlets/invoke-cimmethod?view=powershell-7.5" %}



3. **Win32\_Product method**

**a. Install method**

{% embed url="https://learn.microsoft.com/en-us/previous-versions/windows/desktop/msiprov/install-method-in-class-win32-product?utm_source=chatgpt.com" %}

In this section, I will attempt to explain and illustrate how we can utilize the Windows Management Instrumentation (WMI) to perform lateral movement in an AD environment, to the best of my understanding. As this is a relatively new topic to me (as of 15/08/2025), I will try my best to consolidate what I can understand about the various commands and options. The primary resource will be the TryHackMe's "lateral movement and pivoting" room: &#x20;

{% embed url="https://tryhackme.com/room/lateralmovementandpivoting" %}

> Refer to the links outlined in the _**Resources**_ section above, to view the official documentation for the various commands used in this page.

### Connect to WMI from Powershell

#### (1) Creating credential

First, we need to create a [PSCredential](https://learn.microsoft.com/en-us/dotnet/api/system.management.automation.pscredential?view=powershellsdk-7.4.0) object with a specified username and password, and store it in the `$credential` variable. This variable will be used in a later command.

> PSCredential is a class under the [`System.Management.Automation`](https://learn.microsoft.com/en-us/dotnet/api/system.management.automation?view=powershellsdk-7.4.0) namespace, which  "Offers a centralized way to manage usernames, passwords, and credentials."

{% code title="Powershell" overflow="wrap" %}
```powershell
$username = 'admin_name' 
$password = 'admin_password'
$securePassword = convertTo-SecureString $password -AsPlainText -Force;

# create a new System.Management.Automation.PSCredential object with the specified username and password - store in the $credential variable
$credential = New-Object System.Management.Automation.PSCredential $username, $securePassword;
```
{% endcode %}

#### (2) Creating new CIM session

Now, we can establish a WMI session that will be stored in the `$Session` variable. This variable can be supplied to our future commands, allowing us to perform actions as the authenticated user:

{% code title="Powershell" overflow="wrap" %}
```powershell
# (1) Configure connection options
$Opt = New-CimSessionOption -Protocol Dcom 

# (2) Establish a new session against a remote host - store in $Session variable
$Session = New-CimSession -ComputerName TARGET -Credential $credential -SessionOption $Opt -ErrorAction Stop
```
{% endcode %}

**a. New-CimSessionOption**

The value provided to the `-Protocol` option can be of the following values: **Dcom**, **Wsman**, **Default**.

The following outlines the difference between the **Dcom** and **Wsman** options (information retrieved from the [TryHackMe room](./)):

1\)  Dcom

> RPC over IP will be used for connecting to WMI. This protocol uses port 135/TCP and ports 49152-65535/TCP, just as explained when using sc.exe

2\) Wsman

> WinRM will be used for connecting to WMI. This protocol uses ports 5985/TCP (WinRM HTTP) or 5986/TCP (WinRM HTTPS)

**b. New-CimSession**

* `-ComputerName` :&#x20;
* `-Credential` :
* `-SessionOption` :
* `-ErrorAction` :&#x20;



### Remote process creation&#x20;

### Creating services remotely

### Creating scheduled tasks remotely

### Installing `.msi` packages

