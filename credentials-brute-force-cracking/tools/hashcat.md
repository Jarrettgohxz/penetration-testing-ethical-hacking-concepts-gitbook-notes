# Hashcat

Cracking examples

1. _**JSON Web Tokens (JWT)**_

Eg. Cracking a JWT secret:

* `jwt.txt`: entire JWT sequence (header, payload and signature)
* `jwt.secrets.list`: JWT secrets wordlist

```bash
$ hashcat -m 16500 -a 0 jwt.txt jwt.secrets.list
```

**Flags**

* `-m/--hash-type`: Hash type
  * Eg. `-m 16500` : Hash type ofJWT (JSON Web Tokens)
* -a: Attack mode
  * Eg. `-a 0`: Dictionary attack



{% embed url="https://hashcat.net/wiki/doku.php?id=hashcat" %}
