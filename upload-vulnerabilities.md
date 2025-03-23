# Upload vulnerabilities

{% embed url="https://tryhackme.com/room/uploadvulns" %}
TryHackMe upload vulnerabilities practice room
{% endembed %}

### Bypassing client-side filtering

1. Direct server requests with _cURL_

Eg. Task 7 of the _tryhackme.com_ practice room (link provided at the top)

```bash
curl 'http://[].uploadvulns.thm/' \
  -H 'Host: [].uploadvulns.thm' \
  -F 'fileToUpload=@shell.php;type=text/x-php'
```

2. Interceping and modifying requests with _BurpSuite_

_BurpSuite_ can be used to modify:

a) The GET response from the server to the client, allowing the removal of JavaScript filter logic loaded on the client side&#x20;

b) The POST request sent to the server, enabling the removal of client-side filtering before the data is uploaded



### Bypassing server-side filtering

...
