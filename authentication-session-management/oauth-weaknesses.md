# OAuth weaknesses

### General OAuth flow

_**Common terms:**_&#x20;

* **OAuth provider**: The third-party service that implementing OAuth that a user wishes to integrate/authenticate with (eg. Google, Github).
* **Resource Owner**: An entity that can grant access to a protected resource (eg. an end-user).
* **Client**: Application requesting access to a protected resource on behalf of the Resource Owner (eg. a web application).
* **Resource Server**: A server hosting protected resource (eg. API to access).
* **Authorization Server (AS)**: A server that authenticates the Resource Owner and issues Access Tokens after a proper authorization process.
* **Authorization Code:** A string value used to request for an _Access Token_.
* **Access Tokens**: A string value used to validate a user's access to protected resource

{% stepper %}
{% step %}
### Start of OAuth process

A user performs an action to start an OAuth process on a _Client_ application
{% endstep %}

{% step %}
### Authorization request

1. The application redirects the user to an &#x41;_&#x75;thorization Server_ (/authorize endpoint).

> This process is often displayed as a small pop-up window or redirect initiated by the OAuth provider.

The authorization server URL may look like:

```http
https://example.com/oauth/authorize?client_id=xxx&response_type=code&... 
```

With the following list of parameters:

* `response_type` (eg. code)
* `state`: CSRF token&#x20;
* `client_id`: uniquely identifies the client application
* `redirect_uri`: the URL that AS will redirect the user
* `scope`: level of access requested

> Take note of the `state` value, as this is an important parameter involved in various CSRF-based attacks discussed below.

2. The user will be prompted to login (to verify his/her identity with the _protected resource_). Following that, a consent screen will be displayed to inform the user of the scope of permissions that the _Client application_ is requesting access to.
{% endstep %}

{% step %}
### Consent page & redirect

If the user accepts the permissions displayed in the consent screen (eg. click the "Authorize" button)

1. The _Authorization Server_ will handle the consent internally

This may include a request to an internal endpoint with the `state` and relevant `scope`(s).

> Example internal request:

```http
POST https://example.com/oauth/consent?state=xxx&scope=... 
```

2. The _Authorization Server_ then redirects the user to the `redirect_uri` specified earlier, with a generated _Authorization Code_ and the `state` provided by the _client application_ in the first reque&#x73;_&#x74;_.

> Example redirect:

```http
https://example.com/callback?code=xxx&state=xxxx
```

* The _Client_ application must validate the `state` to ensure that it matches the one sent in the initial request. This ensures that the response is linked to the _Client'_&#x73; initial request&#x20;

> Note: The `state` parameter is important in preventing server-side CSRF vulnerabilities (**OWASP WSTG-ATHZ-05** — **05.1-Testing for OAuth server weaknesses**)


{% endstep %}

{% step %}
### Request for Access Token

The _Authorization Code_ can be used to request for an _Access Token._
{% endstep %}
{% endstepper %}

{% embed url="https://auth0.com/docs/get-started/authentication-and-authorization-flow/authorization-code-flow" %}

## OWASP WSTG-ATHZ-05

### 05-Testing for OAuth weaknesses

{% embed url="https://github.com/OWASP/wstg/blob/master/document/4-Web_Application_Security_Testing/05-Authorization_Testing/05-Testing_for_OAuth_Weaknesses.md" %}

### 05.1-Testing for OAuth server weaknesses

{% embed url="https://github.com/OWASP/wstg/blob/master/document/4-Web_Application_Security_Testing/05-Authorization_Testing/05.1-Testing_for_OAuth_Authorization_Server_Weaknesses.md" %}

### 1. Consent page CSRF

The goal of this CSRF attack is to steal a

#### Prevention

The Authorization Server should validate that the state parameter is linked to an existing active OAuth process, and also that it matches the user session. This prevents an attacker from hijacking the OAuth flow.

> OWASP reference: copy and paste this link on a chromium-based browser to directly view the relevant paragraph.

**https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site\_Request\_Forgery\_Prevention\_Cheat\_Sheet.html#:\~:text=When%20a%20client%20issues%20a%20request**&#x20;







### 05.2-Testing for OAuth client weaknesses

{% embed url="https://github.com/OWASP/wstg/blob/master/document/4-Web_Application_Security_Testing/05-Authorization_Testing/05.2-Testing_for_OAuth_Client_Weaknesses.md" %}

{% stepper %}
{% step %}
### Redirect URI CSRF/Login CSRF


{% endstep %}
{% endstepper %}
