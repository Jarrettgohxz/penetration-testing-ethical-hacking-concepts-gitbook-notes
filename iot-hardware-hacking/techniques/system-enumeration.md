# System enumeration

#### Basic enumeration commands

```bash
# find
$ find . -name '*.xml'
$ find . -name '*.txt'
$ find . -name '*.json'

# strings
$ strings -f * | grep 'pass'
$ strings -f * | grep 'api'
```

#### Files/Directories to enumerate

1. RCS (Run Control Scripts)

* `/sbin/rcS`&#x20;
* `/etc/rcS.d/`&#x20;
*   `/etc/init.d/`&#x20;

    * contains shell scripts that manage system daemons, eg. Apache, SSH, etc.



2. `~/.netrc`

* Plain-text configuration file used by programs such as FTP and HTTP, to store auto-login credentials for network access

#### Discovering location of a binary

* Eg. `httpd` binary

```shellscript
$ find / -type f -name '*httpd*' 2>/dev/null

# from /etc/inittab and /etc/init.d 
$ cat /etc/inittab
$ grep -R "httpd" /etc/init.d 2>/dev/null 
```
