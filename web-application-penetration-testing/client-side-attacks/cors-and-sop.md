# CORS & SOP

Cross Origin Resource Sharing (CORS) and Same-Origin Policy (SOP) are client-side security mechanisms implemented by browsers to control the cross-origin resource access configurations.  &#x20;

> Take note of the term "cross-origin" used in this section. This is different from "cross-site". Refer to the article in the parent document labelled **"Client-Side attacks".**

Specifically, CORS adds flexibility to SOP, by allowing extended configurations. It is a browser-enforced mechanism that is defined by the `Access-Control-Allow-Origin` and `Access-Control-Allow-Credentials` response headers from the server.

SOP is a default browser-enforced security policy.

{% embed url="https://portswigger.net/web-security/cors" %}

{% embed url="https://portswigger.net/web-security/cors/same-origin-policy" %}

> NOTE: CORS and SOP is **NOT** a protection against cross-origin attacks such as Cross-Site Request Forgery (CSRF). The reason for this is that CORS/SOP prevents Javascript from accessing data loaded from cross-origin requests. However, CSRF simply requires the request to be send (to invoke a state change, etc.) but does not actually require access to the data.



