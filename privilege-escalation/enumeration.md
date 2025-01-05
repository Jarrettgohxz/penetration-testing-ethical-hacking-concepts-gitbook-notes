# enumeration

## Basic enumeration commands (Linux)

1. `hostname`
2. `uname -a`
3. Files to view with the `cat` command

&#x20;  a) **/proc/version**

&#x20;  b) **/etc/issue**

&#x20;  c) **/etc/passwd**

&#x20; d) **/etc/shadow**

4. `env`
5. `id`
6. `history`
7. `sudo -l`

> The target system may be configured to allow users to run some (or all) commands with root privileges. The `sudo -l` command can be used to list all commands your user can run using `sudo`

8. `find`

&#x20;a) Files with SUID bit:&#x20;

```bash
$ find / -perm -u=s -type f 2>/dev/null
```



&#x20; &#x20;

{% embed url="https://tryhackme.com/r/room/linprivesc" %}
