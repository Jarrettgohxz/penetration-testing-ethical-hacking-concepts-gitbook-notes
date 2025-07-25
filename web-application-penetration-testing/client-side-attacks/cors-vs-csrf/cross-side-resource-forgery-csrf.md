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

Before getting into the SameSite cookie attribute, lets look through a few important definitions.

#### Definitions

1. eTLD + 1&#x20;
   * effective TLD (eg. `.com.sg` )
   * \+ 1  (one additional level of the domain name - eg. `domain.com.sg`)

Eg. `domain.com.sg` , `test.com.sg` and `sub.domain.com.sg` , `sub2.domain.com.sg` have different eTLD+1.



We can refer to the table below to understand the difference between the terms _**"site"**_ and _**"origin":**_

| URL 1                       | URL 2                       | Same site?                                      | Same origin?                |
| --------------------------- | --------------------------- | ----------------------------------------------- | --------------------------- |
| https://test.com (port 443) | https://test.com (port 443) | YES                                             | YES                         |
| https://test.com (port 443) | https://test.com:8000       | YES                                             | NO (mismatched port)        |
| https://test.com            | https://top.test.com        | YES                                             | NO (mismatched domain name) |
| https://test.com            | https://hello.com           | NO (mismatched domain name)                     | NO (mismatched domain name) |
| https://test.com            | https://test.com.sg         | NO (mismatched TLD)                             | NO (mismatched domain name) |
| https://test.com            | http://test.com             | NO (mismatched scheme - refer below to nuances) | NO (mismatched scheme)      |



> According to PortSwigger (see link below)

Generally, having the same _**"origin"**_ requires the URL to share exact values for:

1. Scheme
2. Domain name
3. Port

While _**"site"**_  accounts only for the following:

1. &#x20;End of the domain name (eTLD + 1)&#x20;
2. Scheme

This means that a different scheme or port may still be considered as the same _**"site"**_ .

> Note that in some definitions, the scheme may not be accounted for when deciding if two URLs are of the same site: [https://html.spec.whatwg.org/multipage/browsers.html#example-same-site](https://html.spec.whatwg.org/multipage/browsers.html#example-same-site)

{% embed url="https://portswigger.net/web-security/csrf/bypassing-samesite-restrictions" %}

#### What is the `SameSite` attribute?

The `SameSite` cookie attribute limit the cross-site requests made by a browser. This can help in mitigating common cross-site attacks such as CSRF.

_**Restriction levels**_

1. Strict
   * If the `SameSite=Strict`  attribute is set, browsers will not send the cookie in any cross-site requests
   * The cookie will only be set if the target site matches the current site (matched exactly in the address bar)
2. Lax
   * &#x20;The cookie will only be sent if certain conditions are met:
     * The request uses the **GET** method
     * The request is a result of a top-level navigation by the user (clicking a link, redirected with `window.location`, etc.)
   * The cookie will not be sent in a cross-site `POST` request
3. None
   * This option effectively disables `SameSite` restrictions
   * This will make browsers send the cookie in all requests to any site specified (even if its cross-site)
