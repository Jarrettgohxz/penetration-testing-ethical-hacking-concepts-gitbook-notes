# Command Prompt (cmd)

`cmd` can be a useful tool when enumerating AD, as it is not commonly monitored by defence systems such as antivirus or the blue team. Moreover, it can be embedded in phishing payloads such as with VBScript, or any other macro languages to perform initial enumeration.

### `net` command

> For the full list of available options, refer to the official documentation in the link below:

{% embed url="https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/net-commands-on-operating-systems?utm_source=chatgpt.com" %}

#### 1. USERS

```sh
net USERS /DOMAIN
net USERS <username> /DOMAIN
```

#### 2. GROUPS

```sh
net GROUPS /DOMAIN
net GROUPS <group> /DOMAIN
```

**Example**

```sh
net GROUPS /DOMAIN
The request will be processed at a domain controller for domain xxxx.com.


Group Accounts for \\THMDC.xxxx.com                                     
                                                                                
------------------------------------------------------------------------------- 
*Cloneable Domain Controllers
*DnsUpdateProxy
*Domain Admins
...

```

#### 3. ACCOUNTS

```sh
net ACCOUNTS /DOMAIN
```

**Example**

```sh
net ACCOUNTS /DOMAIN
The request will be processed at a domain controller for domain xxxx.com.

Force user logoff how long after time expires?:       Never
Minimum password age (days):                          0
Maximum password age (days):                          Unlimited
Minimum password length:                              0
Length of password history maintained:                None
Lockout threshold:                                    Never
Lockout duration (minutes):                           30
Lockout observation window (minutes):                 30
Computer role:                                        PRIMARY
```

_**Options overview**_

* `/DOMAIN`&#x20;

> Performs the operation on a domain controller of the current domain. Otherwise, the operation is performed on the local computer.

