# John the ripper

### Main folder

`~/.john`

1. Cracked passwords: `~/.john/john.pot`

### Basic usage

```bash
$ john  <text_file_containing_hash_to_crack>
$ john --format=[format] --wordlist=[wordlist] <text_file_containing_hash_to_crack>
$ john --format=[format] --wordlist=[wordlist] --rules=[rule]  <text_file_containing_hash_to_crack>
```

```bash
# show cracked passwords
$ john --show <text_file_containing_hash_to_crack>
```

### Hash formats

{% embed url="https://pentestmonkey.net/cheat-sheet/john-the-ripper-hash-formats" %}

### Rules

The `--rules` flag allows specification of rules to be applied to values in a word list, in order to generate possible password variations.

The instructions/format for the rules can be found in the `/etc/john/john.conf` file under a specific header in the format `[List.Rules:rule_format]`. A few examples include `single` or `wordlist`.

#### Single

`[List.Rules:Single]` (/etc/john/john.conf)

Uses information from a given set of data consisting of user-specific information such as username, passwords used in other applications, private information such as pet's name, etc. to generate variations of the initial supplied data.

_**Eg.**_ Information have been gathered about a target, and the following word list have been generated - consisting of the username/passwords used on other sites (leaked or hacked via means) and pet's name.

```bash
$ cat user.txt
thundereagle
jarrett
jarrettgoh
qwerty
qwerty123
```

The `single` ruleset may generate variations of these data such as: `thundere@gle`, `j@rrett`, etc.

```bash
$ john --rules=single --wordlist=user.txt --format=[format] hash.txt
```

#### Wordlist

`[List.Rules:Wordlist]` (/etc/john/john.conf)

A rule will be applied to each word from the supplied wordlist to generate additional variations. For example, it could append numbers to the value, capitalize them, etc.

```bash
$ cat long_wordlist.txt # eg. rockyou.txt
weakpass1
weakpass2
1weakpass
2weakpass
...
```

The `wordlist` ruleset may generate variations of these data such as: `weakpass12`,`12weakpass` etc.



_**Overview**_

* `--rules=single`: Best used to generate password guesses based on data related to a target user: usernames, passwords, etc. and apply simple transformations.
* `--rules=wordlist`: Best used to apply transformations to every word in a wordlist to generate variatons.

### Printing results to stdout without cracking hashes

The --stdout flag can be used to print the generated results without actually using it to crack any hashes

```bash
$ john ...options --stdout
```

Suppose you would like to apply certain rules (eg. `single`) to a word list and save it to an output file, without cracking any hashes.

```bash
$ john --wordlist=<wordlist> --rules=single --stdout > output.txt

# extend output.txt with additional rules
$ john --wordlist=<wordlist> --rules=wordlist --stdout >> output.txt
```



### Additional modules

1. **`unshadow`**

```bash
$ unshadow 
Usage: unshadow PASSWORD-FILE SHADOW-FILE

# Assume a root shell on the target machine (with escalated privileges)
$ echo /etc/passwd > passwd.txt
$ echo /etc/shadow > shadow.txt
$ unshadow passwd.txt shadow.txt > password.txt


$ john password.txt
...
# OR
$ john --wordlist /usr/share/wordlists/rockyou.txt password.txt
...
```

2. **Conversion of data format or password protected media to a format that&#x20;**_**john**_**&#x20;can crack.**

_**Eg**_. Conversion of password protected PDF file to _**john**_ understandable format:

* /usr/share/john/pdf2john.pl&#x20;
* /usr/bin/pdf2john&#x20;
* /opt/pdf2john.pl
* ...

Given a `.pdf` file named `private.pdf`&#x20;

```bash
# Convert the private.pdf file to a john format, and save the output to pdf.hash
$ /usr/bin/pdf2john private.pdf > pdf.hash
```

Now,  _**john**_ can be ran on the `pdf.hash` file

```bash
# Note: the --format flag is not required as john will automatically infer the format
# The format can still be specified explicitly with the --format flag
# for some instance when john don't recognise the format accurately
$ john --rules=[rule] --wordlist=[wordlist] pdf.hash
```

### Examples

#### 1. Brute-forcing NTLM hash (SAM database)

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
