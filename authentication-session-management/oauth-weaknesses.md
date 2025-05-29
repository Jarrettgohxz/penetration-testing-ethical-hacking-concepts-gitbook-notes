# OWASP WSTG-ATHZ-05 \~ OAuth weaknesses

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

**2.1** The application redirects the user to an &#x41;_&#x75;thorization Server_ (`/authorize` endpoint).

> This process is often displayed as a small pop-up window or redirect initiated by the OAuth provider.

The authorization server URL may look like:

```http
https://[client_addr].com/oauth/authorize?client_id=xxx&response_type=code&... 
```

With the following list of parameters:

* `response_type` (eg. code)
* `state`: CSRF token&#x20;
* `client_id`: uniquely identifies the client application
* `redirect_uri`: the URL that AS will redirect the user
* `scope`: level of access requested

> Take note of the `state` value, as this is an important parameter involved in various CSRF-based attacks discussed below.

**2.2** The user will be prompted to login (to verify his/her identity with the _protected resource_). Following that, a consent screen will be displayed to inform the user of the scope of permissions that the _Client application_ is requesting access to.
{% endstep %}

{% step %}
### Consent page & redirect

If the user accepts the permissions displayed in the consent screen (eg. click the "Authorize" button)

**3.1** The _Authorization Server_ will handle the consent internally

This may include a request to an internal endpoint with the `state` and relevant `scope`(s).

> Example internal request:

```http
POST https://[AS_addr].com/oauth/consent?state=xxx&scope=... 
```

**3.2** The _Authorization Server_ then redirects the user to the `redirect_uri` specified earlier, with a generated _Authorization Code_ and the `state` provided by the _client application_ in the first reque&#x73;_&#x74;_.

> Example redirect:

```http
https://[client_addr].com/callback?code=xxx&state=xxxx
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

> Refer to the _Testing for Consent Page Cross-Site Request Forgery_ header in the main link above (**OWASP WSTG-05.1-Testing for OAuth server weaknesses**)

**This attack is possible due to a few potential flaws in the&#x20;**_**Authorization Server**:_

1. Improper or missing validation of the `state` parameter by the _Authorization Server_.
2. Predictable or reused`state` parameter value.

The goal of this CSRF-based attack is to trick an &#x41;_&#x75;thorization Server_ into generating an _Authorization Code_ with permissions/scopes defined by an attacker. Typically, the scopes defined will provide the attacker access to sensitive information about a target user.&#x20;

**Steps involved:**

1.  The attacker will initiate an OAuth request from within a malicious _Client_ application (eg. `/oauth/authorize` endpoint).

    * The attacker will then create a CSRF payload (eg. auto-submitting HTML element using a POST request) containing a malicious URL with the following format:

    > Not all _Authorization Server_ implementations expose `/oauth/consent` as a public endpoint. Some may process it internally.

```http
https://[AS_addr].com/oauth/consent?state=xxx&scope=... 
```

Parameters in the URL:

a. `state`: A random/predictable value

b. `scope`: Desired scope&#x20;

> Note the following:
>
> 1. The attacker is required to start an OAuth request to trick the Authorization Server into believing that an active OAuth process is happening for the malicious _Client_ application.
> 2. This URL is similar to the one shown in part **3.1** in the **General OAuth flow** section above.

> The scope defined may contain highly sensitive permissions about the target user

2.  The attacker will trick a target user into visiting the malicious Client application containing the CSRF payload **via a web browser** — this can be through a social engineering attack.&#x20;

    * However, for the attack to work, the target user's browser must be authenticated with the OAuth provider — a valid authenticated session must be established through an OAuth process prior to the attack.

    > This is due to the nature of  web browsers, which sends relevant information regarding the established session with the OAuth provider (eg. cookies, etc.) to identify the current user session

    * The CSRF attack occurs because the Authorization Server associates the scope processing with the session of the target user, instead of the attacker. This is due to the web browser sending session information about this particular user
    * Within the _Authorization Server_ logi&#x63;_,_ without proper validation of the `state` parameter (see **Prevention** section below for more information), the server will treat this as a valid OAuth request, and continue the OAuth process by redirecting the user back to the `redirect_uri`  (defined by the attacker in the initial request) with the _Authorization Code_ passed as the paramete&#x72;_._&#x20;

> Since the redirect URI is controlled by the attacker, he/she can retrieve the Authorization Code.



3. The attacker will be able to use this code to request for an _Access Token_, and perform actions for the target user within the _Client_ application (controlled by the attacker) with the privileged scopes.



#### Prevention

The _Authorization Server_ should validate the  following conditions for the`state` parameter:

1. &#x20;Linked to an existing active OAuth process
2. Matches the user session.&#x20;
3. Uses a cryptographically secure and random algorithm.

This prevents an attacker from hijacking the OAuth flow.

> OWASP reference: copy and paste this link on a chromium-based browser to directly view the relevant paragraph.

<mark style="color:blue;">https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site\_Request\_Forgery\_Prevention\_Cheat\_Sheet.html#:\~:text=When%20a%20client%20issues%20a%20request</mark>&#x20;



**Final notes**

This attack is categorized as a server-side vulnerability as the vulnerability (lack of `state` validation, etc.) lies within the _Authorization Server_ itself.

### 05.2-Testing for OAuth client weaknesses

{% embed url="https://github.com/OWASP/wstg/blob/master/document/4-Web_Application_Security_Testing/05-Authorization_Testing/05.2-Testing_for_OAuth_Client_Weaknesses.md" %}

### 1. Redirect URI CSRF/Login CSRF

> Refer to TryHackMe task 7 for OAuth Vulnerabilities room: [https://tryhackme.com/room/oauthvulnerabilities](https://tryhackme.com/room/oauthvulnerabilities)

**This attack is possible due to a few potential flaws in the&#x20;**_**Client**_**&#x20;application**:

1. Improper or missing validation of the `state` parameter by the _Client_ application.
2. Predictable or reused-+ `state` parameter value.

The goal of this CSRF-based attack is to trick a _Client_ application into accepting an _Authorization Code_ tied to an attacker-controlled account, causing the victim's session to be linked to the attacker's OAuth identity.

**Steps involved:**

1. The attacker will initiate an OAuth request to retrieve an _Authorization Code_ linked to a malicious account.
2. The attacker will then craft a CSRF payload (eg. email) with an URL. The format of the URL will be similar to the redirect URI used in an OAuth process.&#x20;

> Example of malicious URL

```http
https://[client_addr].com/callback?code=[attacker_authorization_code]
```

> Note : this URL is similar to the one shown in part **3.2** in the **General OAuth flow** section above.

3. A target user will be tricked into sending a GET request to the malicious URL **via a web browser**  (eg. via social engineering)

* However, for the attack to work, the target user's browser must be authenticated with the OAuth provider — a valid authenticated session must be established through an OAuth process prior to the attack.
* If successful, the _Client_ application will link the victim's session to the attacker's OAuth account.



4. As a result:
   * Any subsequent actions performed on the Client application will be linked to the attacker's account instead
   * This may allow the attacker to view sensitive information about the target user.

#### Prevention

The _Client_ application should validate the following conditions for the `state` parameter:&#x20;

1. Linked to an existing active OAuth process.
2. Matches the one defined in the initial request (eg. `/oauth/authorize` endpoint).
3. Uses a cryptographically secure and random algorithm.

\
**Final notes**

This attack is categorized as a client-side vulnerability as the vulnerability (lack of `state` validation, etc.) lies within the _Client_ application itself.
