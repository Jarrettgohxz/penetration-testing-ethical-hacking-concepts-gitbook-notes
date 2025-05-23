# Enumeration

## Basic enumeration commands (Linux)

1. `hostname`
2. `uname -a`
3. Files to view with the `cat` command

&#x20;  a) **/proc/version**

&#x20;  b) **/etc/issue**

&#x20;  c) **/etc/passwd** and **/etc/shadow**

* Readable **/etc/shadow** file
* Writable **/etc/passwd** and **/etc/shadow**

```bash
# rx /etc/passwd
$ ls -l /etc/passwd
-rw-r--r-x 1 root shadow xxxx xxx xx xxxx /etc/passwd

# rx /etc/shadow
$ ls -l /etc/shadow
-rw-r--r-x 1 root shadow xxxx xxx xx xxxx /etc/shadow
```

4. `env`
5. `id`

Suppose a user is in the _**adm**_ group. This user will be able to read the log files present in the `/var/log` or other related folder:

Practical example: [https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking/write-ups/tryhackme/silver-platter](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking/write-ups/tryhackme/silver-platter)

```bash
$ id
... ...(adm)

$ cd /var/log
/var/log$ less syslog
```



4. `history`
5. `sudo -l`

> The target system may be configured to allow users to run some (or all) commands with root privileges. The `sudo -l` command can be used to list all commands your user can run using `sudo`

8. `find`

&#x20;a) Files with SUID bit:&#x20;

```bash
$ find / -perm -u=s -type f 2>/dev/null

# SUID bit and writable by current user
$ find / -perm -u=s -writable -user $(whoami) -type f 2>/dev/null

#  SUID bit and writable by others
find / -perm -u=s -perm 002 -type f  2>/dev/null
```

&#x20;b) Files with SGID bit:

```bash
$ find / -perm -g=s-type f 2>/dev/null

# SGID bit and the group is root
$ find / -perm -g=s -group root -type f 2>/dev/null
```

&#x20;c) Files with certain permission&#x20;

* `0777`: readable, writable and executable by all users
* `003`: writable and executable by `others`. Ignoring permissions for `owner` and `group`
* `/001`: atleast executable permissions for others

<pre class="language-bash"><code class="lang-bash"><strong># both the commands below are the same
</strong><strong>$ find / -perm 777 -type f 2>/dev/null
</strong>$ find / -perm 0777 -type f 2>/dev/null

# eg. files with write and execute (wx) permissions for "others"
$ find / -perm 003 -type f 2>/dev/null

# eg. similar to above, but with folders/dirs instead
$ find / -perm 003 -type d 2>/dev/null

# eg. atleast executable by others
$ find / -perm /001 -type f 2>/dev/null
</code></pre>

**Find world-writable folders**

```bash
$ find / -writable -type d 2>/dev/null 
$ find / -perm -222 -type d 2>/dev/null
$ find / -perm -o x -type d 2>/dev/null
```

**Find world-executable folders**

```bash
$ find / -executable -type d 2>/dev/null 
$ find / -perm -111 -type d 2>/dev/null
$ find / -perm -o x -type d 2>/dev/null
```

#### Files to look out for

1. Writable `/etc/fstab`  ([https://jarrettgxz-sec.gitbook.io/offensive-security-concepts/privilege-escalation/linux/vulnerabilities-exploit/filesystem-sharing/nfs-attacker-machine](https://jarrettgxz-sec.gitbook.io/offensive-security-concepts/privilege-escalation/linux/vulnerabilities-exploit/filesystem-sharing/nfs-attacker-machine))
2. Writable `/etc/systemd/system` , `/lib/systemd/services`, `/usr/lib/systemd/system`, `/run/systemd/system` (systemd services) and other similar directories

### Automated tools

* LinPeas: [https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/tree/master/linPEAS](https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/tree/master/linPEAS)
* LinEnum: [https://github.com/rebootuser/LinEnum](https://github.com/rebootuser/LinEnum)
* LES (Linux Exploit Suggester): [https://github.com/mzet-/linux-exploit-suggester](https://github.com/mzet-/linux-exploit-suggester)
* Linux Smart Enumeration: [https://github.com/diego-treitos/linux-smart-enumeration](https://github.com/diego-treitos/linux-smart-enumeration)
* Linux Priv Checker: [https://github.com/linted/linuxprivchecker](https://github.com/linted/linuxprivchecker)

&#x20; &#x20;

{% embed url="https://tryhackme.com/r/room/linprivesc" %}
