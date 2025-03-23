---
description: HTTP header methods that are exploitable
---

# HTTP headers

### 1. X-Forwarded-For, True-Client-IP, X-Client-IP

Commonly used by CDN, proxy servers, etc. Informs the webserver of the originating IP address. However, this can be spoofed to trick the web server.&#x20;

### Potential XSS

For example, if the provided value is placed somewhere on the web-page, it can potentially lead to a XSS vulnerability if not filtered properly.&#x20;

Refer to task 7 of the following TryHackMe challenge:&#x20;

a) Challenge: [https://tryhackme.com/room/owaspjuiceshop](https://tryhackme.com/room/owaspjuiceshop)

b) Write-up: [https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking/write-ups/owasp-juice-shop](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking/write-ups/owasp-juice-shop)
