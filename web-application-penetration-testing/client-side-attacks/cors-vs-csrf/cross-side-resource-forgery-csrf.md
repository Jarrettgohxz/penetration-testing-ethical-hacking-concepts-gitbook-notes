---
description: >-
  Cross-Side Resource Forgery (CSRF) involves tricking a user into performing
  unwanted actions on web applications that they are currently authenticated to.
---

# Cross-Side Resource Forgery (CSRF)

## Examples

1. **OAuth client and server side CSRF vulnerabilities.**

{% embed url="https://jarrettgxz-sec.gitbook.io/offensive-security-concepts/authentication-session-management/owasp-wstg-athz-05-oauth-weaknesses" %}

### Mitigations against CSRF

#### 1. CSRF token



#### 2. `SameSite` cookie attribute

We can refer to the table below to understand the difference between the terms _**"site"**_ and _**"origin":**_

| URL 1                       | URL 2                       | Same site?                   | Same origin?                |
| --------------------------- | --------------------------- | ---------------------------- | --------------------------- |
| https://test.com (port 443) | https://test.com (port 443) | YES                          | YES                         |
| https://test.com (port 443) | https://test.com:8000       | YES                          | NO (mismatched port)        |
| https://test.com            | https://top.test.com        | YES                          | NO (mismatched domain name) |
| https://test.com            | https://hello.com           | NO (mismatched domiain name) | NO (mismatched domain name) |
| https://test.com            | https://test.com.sg         | NO (mismatched TLD)          | NO (mismatched domain name) |
| https://test.com            | http://test.com             | NO (mismatched scheme)       | NO (mismatched scheme)      |

Generally, having the same _**"origin"**_ requires the URL to share exact values for:

1. Scheme
2. Domain name
3. Port

While _**"site"**_  accounts only for the scheme and the end of the domain name. This means that a different scheme or port may still be considered as the same _**"site"**_ .



{% embed url="https://portswigger.net/web-security/csrf/bypassing-samesite-restrictions" %}

