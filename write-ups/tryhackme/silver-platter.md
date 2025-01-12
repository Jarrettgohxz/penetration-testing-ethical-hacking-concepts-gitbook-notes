# Silver Platter

{% embed url="https://tryhackme.com/r/room/silverplatter" %}

1. Run `nmap` on the target IP address

```bash
$ nmap -sS -n -v -Pn [target_ip]
80 ...
8080 ...
22 ... 
```

The results showed that there were 3 open ports: `22`, `80` and `8080`. I tried enumerating SSH at port 80 first, trying to find a CVE for the version.

After realizing that port 22 was least likely to be the vulnerable service (probably a rookie mistake for thinking that it was the vulnerable one in the first place :D), I went on to visit the website at port 80 instead.

2. Gathering information from the website at port `80`, and trying to attack it

#### Information gathering

After running through the website with interception from Burp suite community, I viewed the sitemap generated (**Target** -> **Site map**), but didn't find any useful information.&#x20;

After reading through the text content present, a particular term: **silverpeas**, caught my eye. I decided to research about it.&#x20;

**Silverpeas** is a ...

#### Trying to attack the website

From the results obtained in `nmap`above, I tried to lookup for CVEs related to the particular version of **nginx** the web server is running: _**nginx 1.18.0**._&#x20;

...

3. Enumerating port 80 with common **silverpeas** directories

From a quick on Google, I gathered various URL paths that are commonly used on a **silverpeas** application. Using the target IP and port 80 as the main host, I tried visiting the brief list of paths listed below:

1. `/portal`
2. `/portal/login`
3. `admin`
4. `/portal/admin`
5. `/silverpeas`
6. `/silverpeas/portal`
7. ...

All the paths returned status code _**404**_ (Not found).



4. Concentrating my efforts on port 8080 (**silverpeas**)

I decided to start trying to play around with port 8080 instead. After running a quick `nmap` scan, the results shows that it is running a _**http-proxy**_.

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



5. Continuation on port 8080!

**Searching for CVEs and exploits relating to JSP/2.3**

From the X-powered-by response headers, ...



I tried using a few Metasploit payloads:

a) `exploit/multi/http/struts_include_params`

b) `expoit/multi/http/struts2_content_type_ognl`



6. Further research on **silverpeas**

After much research, I came acrosss a vulnerability listing regarding silverpeas authentication bypass
