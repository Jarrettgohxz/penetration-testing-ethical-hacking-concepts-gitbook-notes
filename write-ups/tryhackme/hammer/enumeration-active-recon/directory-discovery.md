# Directory discovery

> The word lists used in this phase are from Daniel Miessler's seclist: [https://jarrettgxz-sec.gitbook.io/offensive-security-concepts/tools-services/wordlists](https://jarrettgxz-sec.gitbook.io/offensive-security-concepts/tools-services/wordlists).&#x20;
>
> The word list path shown in the examples below will be displayed as a redacted relative directory.

## Initial enumeration

```bash
$ gobuster dir -x php -u http://<target>:1337/ -w .../Discovery/Web-Content/common.txt
```

**Important options to note:**

1. `-x php` : Fuzz with a .`php` extension added to each item in the word list&#x20;

<figure><img src="../../../../.gitbook/assets/image (13).png" alt=""><figcaption></figcaption></figure>

```bash
$ gobuster dir -w .../Discovery/Web-Content/common.txt -u http://<target>:1337/
```

<figure><img src="../../../../.gitbook/assets/image (1).png" alt=""><figcaption></figcaption></figure>

_**Interesting directories**_

`/config.php` -> empty page with no interesting source code content

`/javascript` and `/vendor` -> FORBIDDEN

`/phpmyadmin` -> php admin login page



## Further enumeration

#### `/phpmyadmin/js` directory

After looking through the sitemap in burp suite (refer to the _**burp suite sitemap section**_), I discovered an interesting looking directory: `/phpmyadmin/js` . This directory contained a lot of `.js` and `.php` files — as shown from burp suite.

Thus, I decided further enumerate this directory with a common word list.

```bash
$ gobuster dir -x php,js -w .../Discovery/Web-Content/common.txt -u http://<target>:1337/phpmyadmin/js/
```

**Important options to note:**

1. `-x php,js` : Fuzz with a .`php` and `.js` extension added to each item in the word list&#x20;

> Note: specifying 2 extensions will double the runtime as the fuzzer will duplicate the requests

<figure><img src="../../../../.gitbook/assets/image.png" alt=""><figcaption></figcaption></figure>
