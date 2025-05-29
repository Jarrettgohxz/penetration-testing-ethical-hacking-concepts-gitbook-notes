# OAuth weaknesses

### General OAuth flow

_**Common terms:**_&#x20;

* **OAuth provider**: The third-party that a user wishes to integrate/authenticate with.
* **Resource Server**: An entity that can grant access to a protected resource — eg. an end-user.
* **Client**: Application requesting access to a protected resource on behalf of the Resource Owner — eg. a web application.
* **Resource Server**: A server hosting protected resource — eg. API to access.
* **Authorization Server (AS)**: A server that authenticates the Resource Owner and issues Access Tokens after a proper authorization process.
* **Access Tokens**: A string values used to validate a user's access to protected resource

{% stepper %}
{% step %}
A user performs an action to start an OAuth process on a _Client_ application
{% endstep %}

{% step %}
The application redirects the user to an &#x41;_&#x75;thorization Server_ (`AS`)&#x20;

> This process is displayed as the small pop-up window from the OAuth provider.

The authorization server URL may look like:

`https:// example.com/oauth/authorize?client_id=xxx&response_type=code&...` , with the following list of parameters:

* `response_type` (eg. code)
* `state`: CSRF token&#x20;
* `client_id`: uniquely identifies the client application
* `redirect_uri`: the URL that AS will redirect the user
* `scope`: level of access requested

> Take note of the `state` value, as this is an important parameter involved in various attacks

> The user will be prompted to login (to verify his/her identity with the _protected resource_). Following that, a consent screen will be displayed to inform the user the scope of permissions that the _client application_ is requesting access to.
{% endstep %}

{% step %}
If the user accepts the permissions displayed in the consent screen (eg. click the "Authorize" button)

a) A consent request will be sent to the authorization server endpoint with the `state` and relevant `scope`(s).





b) The authorization server then redirects the user to the `redirect_uri` specified earlier, with a generated authorization code.
{% endstep %}
{% endstepper %}



### OWASP WSTG-ATHZ-05

#### 05 Testing for OAuth weaknesses

{% embed url="https://github.com/OWASP/wstg/blob/master/document/4-Web_Application_Security_Testing/05-Authorization_Testing/05-Testing_for_OAuth_Weaknesses.md" %}

#### 05.1-Testing for OAuth server weaknesses

{% embed url="https://github.com/OWASP/wstg/blob/master/document/4-Web_Application_Security_Testing/05-Authorization_Testing/05.1-Testing_for_OAuth_Authorization_Server_Weaknesses.md" %}

#### 05.2-Testing for OAuth client weaknesses

{% embed url="https://github.com/OWASP/wstg/blob/master/document/4-Web_Application_Security_Testing/05-Authorization_Testing/05.2-Testing_for_OAuth_Client_Weaknesses.md" %}
