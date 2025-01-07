# Enumeration

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

&#x20;  b) Files with certain permission&#x20;

* `0777`: readable, writable and executable by all users
* `003`: writable and executable by `others`. Ignoring permissions for `owner` and `group`

<pre class="language-bash"><code class="lang-bash"><strong># both the commands below are the same
</strong><strong>$ find / -perm 777 -type f 2>/dev/null
</strong>$ find / -perm 0777 -type f 2>/dev/null

# eg. files with write and execute (wx) permissions for "others"
$ find / -perm 003 -type f 2>/dev/null

# eg. similar to above, but with folders/dirs instead
$ find / -perm 003 -type d 2>/dev/null
</code></pre>

### Automated tools

* LinPeas: [https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/tree/master/linPEAS](https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/tree/master/linPEAS)
* LinEnum: [https://github.com/rebootuser/LinEnum](https://github.com/rebootuser/LinEnum)
* LES (Linux Exploit Suggester): [https://github.com/mzet-/linux-exploit-suggester](https://github.com/mzet-/linux-exploit-suggester)
* Linux Smart Enumeration: [https://github.com/diego-treitos/linux-smart-enumeration](https://github.com/diego-treitos/linux-smart-enumeration)
* Linux Priv Checker: [https://github.com/linted/linuxprivchecker](https://github.com/linted/linuxprivchecker)

&#x20; &#x20;

{% embed url="https://tryhackme.com/r/room/linprivesc" %}
