# URI standard (RFC 3986)

Uniform Resource Identifier (URI): Generic syntax

{% embed url="https://datatracker.ietf.org/doc/html/rfc3986" %}

### URI fragment (#)

{% embed url="https://developer.mozilla.org/en-US/docs/Web/URI/Reference/Fragment" %}

> The **fragment** of a URI is the last part of the URI, starting with the `#` character. It is used to identify a specific part of the resource, such as a section of a document or a position in a video. The fragment is not sent to the server when the URI is requested, but it is processed by the client (such as the browser) after the resource is retrieved.

In certain types of attack, an URI fragment can be used to form payloads. Such as terminating a HTTP URL value being read by a server (eg. SSRF).

Refer to the following challenge example: [https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking/write-ups/tryhackme/owasp-top-10-2021-task-22](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking/write-ups/tryhackme/owasp-top-10-2021-task-22)

_**NOTE**_: A slash character within the portion after an URI fragment is not actually a HTTP URL path in a way that a server will read it. Rather, it is a value used by the client itself (such as a browser), and its up to its interpretation and parsing to process it.&#x20;

Eg. The following shows the fragment value of each URL:

`http://example.com/path/#/about` -> `/about`

`http://example.com/path/#about` -> `about`

