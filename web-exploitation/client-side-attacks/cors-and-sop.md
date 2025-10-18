# CORS & SOP

Cross Origin Resource Sharing (CORS) and Same-Origin Policy (SOP) are client-side security mechanisms implemented by browsers to control the cross-origin resource access configurations.  &#x20;

> Take note of the term "cross-origin" used in this section. This is different from "cross-site". Refer to the article in the parent document labelled **"Client-Side attacks".**

Specifically, SOP is a default browser-enforced security policy that restricts scripts on one origin from accessing data from another origin.

CORS adds flexibility to SOP, by allowing extended access configurations for controlled relaxation. It is a browser-enforced mechanism that is defined by the `Access-Control-Allow-Origin` and `Access-Control-Allow-Credentials` response headers from the server.



> NOTE: CORS and SOP is **NOT** a protection against cross-origin attacks such as Cross-Site Request Forgery (CSRF)., and should never be used alone as a defence mechanism against it. The reason for this is that CORS/SOP prevents Javascript from accessing data loaded from cross-origin requests. However, CSRF simply requires the request to be send (to invoke a state change, etc.) but does not actually require access to the data.
>
>
>
> Refer to the section **"Possible relations between CORS and CSRF"** for more details on how CORS may actually allow CSRF even with security measures CSRF.

### Important CORS headers

1. `Access-Control-Allow-Origin`&#x20;

This header can be included in the web server's response to control the origins that are allowed to interact with the data via scripts. The `Origin` header will be automatically included by the browser. The server will check if the origin is present in the allowed origins list, return  the `Access-Control-Allow-Origin` header if it matches, else it will not return the header. The browser will decide if  the calling script is allowed to access the response value according to the response from the server.

This header allows other origin values such as `null` or `*` .

&#x20;2\. `Access-Control-Allow-Credentials`&#x20;

By default, the `Access-Control-Allow-Origin` header is used to allow requests that does NOT include any credentials such as cookies and Authorization header from reading the response, but will be restricted by the browser otherwise.

We can allow reading of response value when credentials are sent with the request by setting the `Access-Control-Allow-Credentials` header to _**true**_.

### Possible relations between CORS and CSRF

As noted before, CORS itself does not completely prevent CSRF attacks. Suppose a website implemented proper CORS headers to only allow access to resource to a trusted origin. However, suppose this website failed to enforce proper CSRF security mechanisms (lack of CSRF token and `SameSite=None`). This can be exploited by an attacker to lure the user to a malicous website that runs a malicious script that sends a POST request to another website that the user is currently logged in to. Even with the CORS protection, the server will still process the POST request, and update a certain value in the system, while CORS will merely prevent the script from accessing the response.&#x20;

Consequently, this attack will still succeed even though CORS is properly enforced, simply due to the poor CSRF protections.

#### How can a lack of CORS protection allow for a CSRF attack?

As mentioned earlier, CORS & SOP alone does not defend against CSRF attacks. However, there may be instances where a lack of CORS protection may actually contribute to making a CSRF attack possible.

Suppose another website with partial CSRF protections (proper CSRF token, but a misconfigured `SameSite` value such as `None` ) , and a misconfigured CORS settings. Now, an attacker can setup a malicious website that runs a script that sends a GET request to the target website (assume that the CSRF token can be found from the source code), to retrieve the CSRF token from the source code, before including this token in a new POST request to the target website to invoke a state change, effectively bypassing the original CSRF token protection in place. This is due to the misconfigured CORS settings, the browser allows the script to read the response value with the CSRF token value.

The above example illustrates a scenario where the `SameSite` attribute is set to `None` .Now, suppose that the `SameSite` value is `Lax` instead, the previous method of exploitation will not work since the browser will not include the cookies in POST request, preventing any form of CSRF. However,  an auto-submitting HTML form can be used instead, that performs a top-level navigation action, effectively bypassing the `SameSite=Lax` configurations.

> Refer to the section  [CSRF](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/web-application-penetration-testing/client-side-attacks/csrf) to learn more about the `SameSite` attribute.



{% embed url="https://portswigger.net/web-security/cors/same-origin-policy" %}

{% embed url="https://portswigger.net/web-security/cors" %}
