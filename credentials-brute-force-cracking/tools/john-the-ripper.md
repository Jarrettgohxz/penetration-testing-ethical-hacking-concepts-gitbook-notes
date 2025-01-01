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

### Hash formats

{% embed url="https://pentestmonkey.net/cheat-sheet/john-the-ripper-hash-formats" %}

### Rules

The --rules flag allows specification of rules to be applied to values in a word list, in order to generate possible password variations.

The instructions/format for the rules can be found in the `/etc/john/john.conf` file under a specific header in the format `[List.Rules:rule_format]`. A few examples include `single` or `wordlist`.

#### Single

`[List.Rules:Single]`

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
$ john --rule=single --wordlist=user.txt --format=[format] hash.txt
```

#### Wordlist

`[List.Rules:Wordlist]`

A rule (specified in the `/etc/john/john.conf` file) will be applied to each word from the supplied wordlist to generate additional variations. For example, it could append numbers to the value, capitalize them, etc.

```bash
$ cat long_wordlist.txt # eg. rockyou.txt
weakpass1
weakpass2
1weakpass
2weakpass
...
```

The `wordlist` ruleset may generate variations of these data such as: `weakpass12`,`12weakpass` etc.

* `--rules=single`: Best used to generate password guesses based on data related to a target user: usernames, passwords, etc. and apply simple transformations.
* `--rules=wordlist`: Best used to apply transformations to every word in a wordlist to generate variatons.

### Additional modules

Conversion of data format or password protected media to a format that _**john**_ can crack.

_**Eg**_. password protected PDF file to _**john**_ understandable format:

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
