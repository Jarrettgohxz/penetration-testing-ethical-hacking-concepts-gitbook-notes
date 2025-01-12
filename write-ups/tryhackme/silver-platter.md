# Silver Platter

{% embed url="https://tryhackme.com/r/room/silverplatter" %}

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

**Silverpeas** is a ...

#### Trying to attack the website

From the results obtained in `nmap`above, I tried to lookup for CVEs related to the particular version of **nginx** the web server is running: _**nginx 1.18.0**._&#x20;

...



### 3. Enumerating port 80 with common _silverpeas_ directories

From a quick on Google, I gathered various URL paths that are commonly used on a **silverpeas** application. Using the target IP and port 80 as the main host, I tried visiting the brief list of paths listed below:

1. `/portal`
2. `/portal/login`
3. `admin`
4. `/portal/admin`
5. `/silverpeas`
6. `/silverpeas/portal`
7. ...

All the paths returned status code _**404**_ (Not found).



### 4. Concentrating my efforts on port 8080 (running Silverpeas)

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

### 5. Continuing my adventure on port 8080!

**Searching for CVEs and exploits relating to JSP/2.3**

From the X-powered-by response headers, ...



I tried using a few Metasploit payloads:

a) `exploit/multi/http/struts_include_params`

b) `expoit/multi/http/struts2_content_type_ognl`



### 6. Further research on &#x53;_&#x69;lverpeas_

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
Host: 10.10.14.253:8080 

Login=scr1ptkiddy&DomainId=0
```

Notice that the `Login` field (presumably the username section) has the value **scr1ptkiddy**, which was found in step 2.

The server returned the following URL value in the `Location` header:

`http://10.10.14.253:8080/silverpeas/look/jsp/MainFrame.jsp`

I visited the URL, and was navigated to a dashboard.

...



```http
POST /silverpeas/AuthenticationServlet 
HTTP/1.1 
Host: 10.10.14.253:8080 

Login=Manager&DomainId=0
```



`http://10.10.14.253:8080/silverpeas/Main//look/jsp/MainFrame.jsp`

\
After looking around the website, ...

`tim`&#x20;

`cm0nt!md0ntf0rg3tth!spa$$w0rdagainlol`



### 7. Privilege escalation

...
