# Apache web server (port 50000)

## Login with found credentials

We can login with the found credentials from the previous steps, where we will retrieve our first flag!

## Enumeration

We can perform a simple directory enumeration using the [wordlist](https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/common.txt), with authentication details set via the cookie:

* Notice that the `-x php` option is added to the command
* The authentication details will be set via the `-H "Cookie: PHPSESSID=xxx"` value. The PHPSESSID value can be found from the network inspection of the initial **GET** request to load the webpage.

{% code overflow="wrap" %}
```sh
$ gobuster dir -u http://<target>:50000 -w <wordlist> -x php -H "Cookie: PHPSESSID=xxx"
```
{% endcode %}

I decided to visit a few interesting looking routes:

#### uploads

![](<../../../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1).png>)

A single file `profile.png` exists. Perhaps, we can somehow find a way to upload a web shell?

#### templates

<figure><img src="../../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

There were nothing of interest in this directory.

The other routes will be ignored due to the having no content (size: 0) or forbidden.

