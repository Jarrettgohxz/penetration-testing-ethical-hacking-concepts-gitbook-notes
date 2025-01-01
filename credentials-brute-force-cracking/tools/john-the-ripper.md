# John the ripper

### Main folder

`~/.john`

1. Cracked passwords: `~/.john/john.pot`

### Basic usage

```bash
$ john  <text_file_containing_hash_to_crack>
$ john --format=[format] --wordlist=[wordlist] <text_file_containing_hash_to_crack> 
```

### Hash formats

{% embed url="https://pentestmonkey.net/cheat-sheet/john-the-ripper-hash-formats" %}

### Brute-forcing NTLM hash plaintext value (SAM database)

Load the single NTLM hash value or the whole line of entry from the SAM database into a _**.txt**_ file. Eg. retrieved from TryHackMe practice room:

`jchambers:1114:aad3b435b51404eeaad3b435b51404ee:69596c7aa1e8daee17f8e78870e25a5c:::`

{% embed url="https://tryhackme.com/r/room/meterpreter" %}

```bash
$ echo 69596c7aa1e8daee17f8e78870e25a5c > ntlm.txt
$ cat ntlm.txt
69596c7aa1e8daee17f8e78870e25a5c

$ echo jchambers:1114:aad3b435b51404eeaad3b435b51404ee:69596c7aa1e8daee17f8e78870e25a5c::: > sam_entry.txt
$ cat sam_entry.txt
jchambers:1114:aad3b435b51404eeaad3b435b51404ee:69596c7aa1e8daee17f8e78870e25a5c:::

$ john --wordlist=/usr/share/wordlists/rockyou.txt --format=NT ntlm.txt
...
Trustno1         (jchambers)   
...

$ john --wordlist=/usr/share/wordlists/rockyou.txt --format=NT sam_entry.txt
...
Trustno1         (jchambers)   
...
```
