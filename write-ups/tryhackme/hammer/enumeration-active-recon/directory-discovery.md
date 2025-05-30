# Directory discovery

### Directory fuzzing with gobuster

```bash
$ gobuster dir -x php -u http://<target>:1337/ -w .../SecLists/Discovery/Web-Content/common.txt
```

<figure><img src="../../../../.gitbook/assets/image (13).png" alt=""><figcaption></figcaption></figure>

```bash
$ gobuster dir -w ../SecLists/Discovery/Web-Content/common.txt -u http://<target>:1337/
```

<figure><img src="../../../../.gitbook/assets/image.png" alt=""><figcaption></figcaption></figure>

_**Interesting directories**_

`/config.php` -> empty page with no interesting source code content

`/javascript` and `/vendor` -> FORBIDDEN

`/phpmyadmin` -> php admin login page
