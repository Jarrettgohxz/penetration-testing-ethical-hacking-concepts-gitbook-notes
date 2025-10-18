# PHP wrappers

{% embed url="https://www.thehacker.recipes/web/inputs/file-inclusion/lfi-to-rce/php-wrappers-and-streams" %}

{% embed url="https://www.php.net/manual/en/wrappers.php" %}

Refer to my payload list:

{% embed url="https://github.com/Jarrettgohxz/offsec-wordlists/tree/file-inclusion/file-inclusion" %}

PHP comes with many built-in wrappers for various URL-style protocols for use with the filesystem functions such as `fopen()`, `copy()` or even `include()` and `require()`. This can allow an attacker to read file or execute arbitary commands on the system.

The following covers a few simple techniques using PHP wrappers. Refer to _The Hacker Recipe's_ notes above for more examples.&#x20;

#### `php://filter`&#x20;

Using the option `convert.base64-encode`, which simply base64 encodes the output, we can trick the server into returning the contents of a file in base64 format. Eg. The `/etc/passwd` file.

```sh
php://filter/convert.base64-encode/resource=/etc/passwd
```

> Note: the focus is not on the base64 encoding format, but rather on the ability to extract the contents of a file on the server.

#### `data://`&#x20;

The following payload contains a base64 encoded value for `<?php phpinfo(); ?>`, which will allow us to view the PHP configuration details, potentially leaking sensitive data.&#x20;

```sh
data://text/plain;base64,PD9waHAgcGhwaW5mbygpOyA/Pgo=
```
