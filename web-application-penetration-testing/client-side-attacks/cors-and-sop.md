# CORS & SOP

Cross Origin Resource Sharing (CORS) and Same-Origin Policy (SOP) are client-side security mechanisms implemented by browsers to control the cross-origin resource access configurations.  &#x20;

> Take note of the term "cross-origin" used in this section. This is different from "cross-site". Refer to the article in the parent document labelled **"Client-Side attacks".**

Specifically, CORS adds flexibility to SOP, by allowing extended access configurations for controlled relaxation. It is a browser-enforced mechanism that is defined by the `Access-Control-Allow-Origin` and `Access-Control-Allow-Credentials` response headers from the server.

SOP is a default browser-enforced security policy.

> NOTE: CORS and SOP is **NOT** a protection against cross-origin attacks such as Cross-Site Request Forgery (CSRF). The reason for this is that CORS/SOP prevents Javascript from accessing data loaded from cross-origin requests. However, CSRF simply requires the request to be send (to invoke a state change, etc.) but does not actually require access to the data.

### Important CORS headers

1. `Access-Control-Allow-Origin`&#x20;

This header can be included in the web server's response to control the origins that are allowed to interact with the data via scripts. The `Origin` header will be automatically included by the browser. Only if the origin matches the value returned by the `Access-Control-Allow-Origin` header, will the browser allow the calling script to access the response value.

This header allows other origin values such as `null` or `*` .

&#x20;2\. `Access-Control-Allow-Credentials`&#x20;

By default, the `Access-Control-Allow-Origin` header is used to allow requests that does NOT include any credentials such as cookies and Authorization header from reading the response, but will be restricted by the browser otherwise.

We can allow reading of response value when credentials are sent with the request by setting the `Access-Control-Allow-Credentials` header to _**true**_.





{% embed url="https://portswigger.net/web-security/cors/same-origin-policy" %}

{% embed url="https://portswigger.net/web-security/cors" %}
