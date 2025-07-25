---
description: >-
  Cross-Side Resource Forgery (CSRF) involves tricking a user into performing
  unwanted actions on web applications that they are currently authenticated to.
---

# CSRF

## Examples

1. **OAuth client and server side CSRF vulnerabilities.**

{% embed url="https://jarrettgxz-sec.gitbook.io/offensive-security-concepts/authentication-session-management/owasp-wstg-athz-05-oauth-weaknesses" %}

### Mitigations against CSRF

#### 1. CSRF token



#### 2. `SameSite` cookie attribute

Before getting into the `SameSite` cookie attribute, refer to the article on the different between the terms **"site"** and **"origin"** in the parent document **"Client-Side attacks".**

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
