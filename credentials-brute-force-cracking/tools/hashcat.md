# Hashcat

Cracking examples

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

#### General documentation page&#x20;

{% embed url="https://hashcat.net/wiki/doku.php?id=hashcat" %}
