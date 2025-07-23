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

#### Simple path traversal payloads

With knowledge of the current directory, I started off with simple file traversal payloads.



#### Additional LFI exploitation techniques

{% embed url="https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/File%20Inclusion/LFI-to-RCE.md" %}

#### Brute force discovery

{% embed url="https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/File%20Inclusion/Intruders/JHADDIX_LFI.txt" %}

