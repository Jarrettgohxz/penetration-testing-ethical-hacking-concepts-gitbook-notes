# Hashcat

Cracking examples

1. _**JSON Web Tokens (JWT)**_

Eg. Cracking a JWT secret:

* `jwt.txt`: entire JWT sequence (header, payload and signature) (eg. `eyJhbGxxx.eyJ1c2xxx.gLYfqxxx` )
* `jwt.secrets.list`: JWT secrets wordlist (eg. [https://github.com/danielmiessler/SecLists/blob/master/Passwords/scraped-JWT-secrets.txt](https://github.com/danielmiessler/SecLists/blob/master/Passwords/scraped-JWT-secrets.txt))

```bash
$ hashcat -m 16500 -a 0 jwt.txt jwt.secrets.list
```

**Flags**

* `-m/--hash-type`: Hash type
  * Eg. `-m 16500` : Hash type ofJWT (JSON Web Tokens)
* -a: Attack mode
  * Eg. `-a 0`: Dictionary attack



{% embed url="https://hashcat.net/wiki/doku.php?id=hashcat" %}
