# Express app (port 4000)

Upon visiting the page, we are presented with a login page with a note to sign in as `guest:guest`.&#x20;

### Enumeration&#x20;

I opened Burp suite, and configured my browser to route traffic through the Burp proxy.

From inspection of the network requests, I discovered that the server uses _Express_ via the  `X-Powered-By` response headers. Express is a Node.js web framework used to develop web server applications ([https://expressjs.com/](https://expressjs.com/)).

<figure><img src="../../../.gitbook/assets/image (40).png" alt=""><figcaption></figcaption></figure>

Running a simple directory enumeration on port 4000 with `gobuster` , using the [wordlist](https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/common.txt):

```sh
$ gobuster dir -u http://<target>:4000 -w <wordlist>
```

<figure><img src="../../../.gitbook/assets/image (45).png" alt=""><figcaption></figcaption></figure>

From the enumeration results, the one that stands out is the `/signup` route. I visited the address in the browser, and was faced with the following error:

<figure><img src="../../../.gitbook/assets/image (44).png" alt=""><figcaption></figcaption></figure>

From this error message, we can learn of a few things:

a) The application uses a certain type of server-side rendered templating engine stored under the `views` folder

* Eg. Common Node.js engines includes: `.ejs`, `.pug`, etc.

b)  The root directory of the web application is `/home/ubuntu/include`&#x20;

* The application is ran as the user `ubuntu` &#x20;



Moving on, I logged into the application using the `guest:guest` credentials found earlier. I was presented with a page displaying my profile, along with a few of my friends. Navigating to my profile, I was able to view my current details, along with a form to "Recommend an Activity":

<figure><img src="../../../.gitbook/assets/image (46).png" alt=""><figcaption></figcaption></figure>



Upon entering the values **test** and **test** to the fields, a new entry appeared on the profile details:

<figure><img src="../../../.gitbook/assets/image (49).png" alt=""><figcaption></figcaption></figure>

This presents an interesting vulnerability, since we are able to directly manipulate the profile details. The following displays the HTTP POST request:

<pre class="language-http"><code class="lang-http"><strong>POST /recommend-activity/1 HTTP/1.1
</strong>Host: xxx.xxx.xxx.xxx:4000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:128.0) Gecko/20100101 Firefox/128.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate, br
Content-Type: application/x-www-form-urlencoded
Content-Length: 35
Origin: http://10.10.233.149:4000
Connection: keep-alive
Referer: http://10.10.233.149:4000/friend/1
Cookie: connect.sid=token
Upgrade-Insecure-Requests: 1
Priority: u=0, i

activityType=test&#x26;activityName=test
</code></pre>

I sent the request to the Burp Repeater, and attempted a prototype pollution attack with the following payloads for `activityType` and `activityName` set to `true` :

1. `proto.polluted`
2. `constructor.prototype.polluted`
3. `__proto__['polluted']`
4. `__proto__.constructor.prototype.polluted`&#x20;
5. `['__proto__'].polluted`&#x20;
6. `['__proto__']['pollluted']`
7. `constructor['prototype'].polluted`
8. `constructor['prototype']['polluted']`
9. `['constructor']['prototype'].polluted`
10. `['constructor']['prototype']['polluted']`&#x20;

However, none of the payloads worked. Instead, I attempted to directly change the `isAdmin` field to `true` , but ended up changing the value to the literal string `"true"` . To get around this, I changed the content-type to `application/json` and tried the same request with the following payload:

```json
{
  "activityType":"isAdmin",
  "activityName": true
}
```

With this, we are now an admin. Upon navigating to the profile page, I noticed 2 more options on the navigation bar: _**“API”**_ and _**“Settings”**_
