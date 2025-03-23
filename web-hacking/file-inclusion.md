---
description: >-
  Vulnerabilities include: path/directory traversal (dot-dot-slash) and
  local/remote file inclusion. Related techniques will be discussed.
---

# File inclusion

The most common default base directory for web content is`/var/www`, such as: `/var/www/html`.

## List of common files to read

The following list includes some of the common files to read when a file inclusion vulnerability is discovered:

### Linux

* _`/proc/version`_: Version of the Linux kernel
* _`/etc/shadow`_: contains information about all registered user that has access to a system
* _`/etc/passwd`_: contains information about the system's users' passwords
* _`/root/.bash_history`_: contains the history commands for _**root**_ user
* _`/root/.ssh/id_rsa`_: contains private SSH keys for a root or any known valid user on the server

### Windows

* _`C:\boot.ini`_: contains the boot options for computers with BIOS firmware

### Path traversal attack with wfuzz

Eg. Suppose we have found a PHP file on the server named `file.php` that accepts a query parameter `input`, allowing us to view the contents of a specified file. A fuzzing tool can be used to test the paths that may be vulnerable to a traversal attack.

**Basic command with wfuzz:**

```bash
$ wfuzz -w <path_to_wordlist> <url>/file.php?input=FUZZ
```

Sometimes, there may be many unnecessary results returned. Filter flags such as _`--hc`_,_`--hl`_ can be used to filter unwanted results.

The following wordlist can be used: `/usr/share/wfuzz/wordlist/Injections/traversal.txt`

{% embed url="https://wfuzz.readthedocs.io/en/latest/user/basicusage.html#fuzzing-paths-and-files" %}
Fuzzing examples
{% endembed %}

## Null-byte injection

A null-byte is a control character with a value of zero, that can be represented as `0x00` in hex, `%00` in url-encoding or simply`\0` in the C programming language (where it represents the end of a string; also known as a _null terminator_ or _null character_).&#x20;

In the null-byte injection attack, the null-byte is used to bypass input validations. Languages used on the web such as _**PHP**_ uses similar string-handling methods to those in the C programming language. Thus, it is vulnerable to this attack, as the null-byte character is interpreted as the string terminator, which can cause input to be prematurely terminated.

&#x20;This issue is fixed in PHP 5.3.4. [https://bugs.php.net/bug.php?id=39863](https://bugs.php.net/bug.php?id=39863)



### Automated file inclusion tool <mark style="color:orange;">(test pending...)</mark>

{% embed url="https://github.com/kurobeats/fimap" %}

