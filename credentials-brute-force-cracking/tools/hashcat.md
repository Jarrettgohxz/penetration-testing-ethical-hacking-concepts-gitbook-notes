# Hashcat

### Examples

1. _**JSON Web Tokens (JWT)**_

Eg. Cracking a JWT secret:

* `jwt.txt`: entire JWT sequence (header, payload and signature) (eg. `eyJhbGxxx.eyJ1c2xxx.gLYfqxxx` )
* `jwt.secrets.list`: JWT secrets wordlist

```bash
$ hashcat -m 16500 -a 0 jwt.txt jwt.secrets.list
```

**Flags**

* `-m/--hash-type`: Hash type/mode
  * Eg. `-m 16500` : Hash type of JWT (JSON Web Tokens)
*   `-a`: Attack mode

    * Eg. `-a 0`: Dictionary attack



**Possible wordlists**

1. scraped JWT secrets: [https://github.com/danielmiessler/SecLists/blob/master/Passwords/scraped-JWT-secrets.txt](https://github.com/danielmiessler/SecLists/blob/master/Passwords/scraped-JWT-secrets.txt)
2. rockyou.txt: [https://github.com/danielmiessler/SecLists/blob/master/Passwords/Leaked-Databases/rockyou.txt.tar.gz](https://github.com/danielmiessler/SecLists/blob/master/Passwords/Leaked-Databases/rockyou.txt.tar.gz)

#### List of hash type/mode

{% embed url="https://hashcat.net/wiki/doku.php?id=hashcat" %}

{% embed url="https://hashcat.net/wiki/doku.php?id=example_hashes" %}



1. **13100**&#x20;

* **Kerberos 5, etype 23, TGS-REP)**

```
$krb5tgs$23$*<SERVICE_USERNAME>$<DOMAIN>$<SPN>@<DOMAIN>*$<HASH_VALUE>
```

> Notice the value **23** in the first section of the hash: `krb5tgs$23$` , this refers to the **etype 23**

a. `<SERVICE_USERNAME>`: service account username

* eg. `svc-user`

b. `<DOMAIN>`: Domain

* eg. `test.loc`

c. `<SPN>`: Service Principal Name

* eg. `http/mach.test.loc@test.loc`

d. `<HASH_VALUE>`: Rest of the hash value



2. **19600**&#x20;

* **Kerberos 5, etype 17, TGS-REP (AES128-CTS-HMAC-SHA1-96)**

```
$krb5tgs$17$<SERVICE_USERNAME>$<DOMAIN>$<HASH_VALUE>
```

> Notice the value **17** in the first section of the hash: `krb5tgs$17$` , this refers to the **etype 17**



3. **19700**&#x20;

* **Kerberos 5, etype 18, TGS-REP (AES256-CTS-HMAC-SHA1-96)**

```
$krb5tgs$18$<SERVICE_USERNAME>$<DOMAIN>$<HASH_VALUE>
```

> Notice the value **18** in the first section of the hash: `krb5tgs$18$` , this refers to the **etype 18**

#### General documentation page&#x20;

{% embed url="https://hashcat.net/wiki/doku.php?id=hashcat" %}
