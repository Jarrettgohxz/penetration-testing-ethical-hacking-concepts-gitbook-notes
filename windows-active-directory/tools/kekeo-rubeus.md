# kekeo/rubeus

{% embed url="https://github.com/GhostPack/Rubeus?tab=readme-ov-file#s4u" %}

{% embed url="https://github.com/gentilkiwi/kekeo" %}

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

<mark style="color:$danger;">**\*\* PENDING CONFIRMATION OF AVAILABLE FLAG OPTIONS FOR**</mark> `rubeus.exe`

```powershell
kekeo # tgs::s4u /tgt:<path_to_TGT> /user:<username> /service:<servicename>
C:\> rubeus.exe s4u /ticket:<TGT> /user:<username>  ...
```

* ...



{% embed url="https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-sfu/3bff5864-8135-400e-bdd9-33b552051d94" %}





