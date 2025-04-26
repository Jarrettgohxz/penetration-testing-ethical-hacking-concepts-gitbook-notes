# Webshell

PHP script that provides a simple webshell (via the `cmd` query parameter),

Eg. `https://vuln-website.com/path?cmd=ls`

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
