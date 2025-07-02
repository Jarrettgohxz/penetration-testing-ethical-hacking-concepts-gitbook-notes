# PHP wrappers

{% embed url="https://www.thehacker.recipes/web/inputs/file-inclusion/lfi-to-rce/php-wrappers-and-streams" %}

{% embed url="https://www.php.net/manual/en/wrappers.php" %}

PHP comes with many built-in wrappers for various URL-style protocols for use with the filesystem functions such as `fopen()`, `copy()` or even `include()` and `require()`. This can allow an attacker to read file or execute arbitary commands on the system.

The following covers a few simple techniques using PHP wrappers. Refer to _The Hacker Recipe's_ notes above for more examples.&#x20;

> Each of the payload will be valid only for some PHP functions, but not for others. Eg. `data://text/plain;base64,...` may be valid for `file_get_contents()`, but not for `include()`.&#x20;

#### `php://filter`&#x20;

Using the option `convert.base64-encode`, which simply base64 encodes the output, we can trick the server into returning the contents of a file in base64 format. Eg. The `/etc/passwd` file.

```sh
php://filter/convert.base64-encode/resource=/etc/passwd
```

> Note: the focus is not on the base64 encoding format, but rather on the ability to extract the contents of a file on the server.

#### `data://`&#x20;

```sh
# base64 encoded
data://text/plain;base64,PD9waHAlMjBwaHBpbmZvKCk7JTIwPz4K 
```
