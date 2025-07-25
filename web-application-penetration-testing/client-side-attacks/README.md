# Client-Side attacks

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
