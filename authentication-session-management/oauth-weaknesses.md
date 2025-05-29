# OAuth weaknesses

### General OAuth flow

_**Common terms:**_&#x20;

* **OAuth provider**: The third-party that a user wishes to integrate/authenticate with.
* **Resource Server**: An entity that can grant access to a protected resource — eg. an end-user.
* **Client**: Application requesting access to a protected resource on behalf of the Resource Owner — eg. a web application.
* **Resource Server**: A server hosting protected resource — eg. API to access.
* **Authorization Server (AS)**: A server that authenticates the Resource Owner and issues Access Tokens after a proper authorization process.
* **Access Tokens**: A string values used to validate a user's access to protected resource



1. A user performs an action to start an OAuth process on a _Client_ application.
2. The application redirects the user to an &#x41;_&#x75;thorization Server_ (`AS`) with the following parameters:

> This process is displayed as the small pop-up window from the OAuth provider

* `response_type` (eg. code)
* `state`: CSRF token&#x20;
* `client_id`: uniquely identifies the client application
* `redirect_uri`: the URL that AS will redirect the user
* `scope`: level of access requested

1. The user will be prompted to login (to verify his/her identity with the _protected resource_). Following that, a consent screen will be displayed to inform the user the scope of permissions that the `client application` is requesting access to.

### OWASP WSTG-ATHZ-05

#### 05 Testing for OAuth weaknesses

{% embed url="https://github.com/OWASP/wstg/blob/master/document/4-Web_Application_Security_Testing/05-Authorization_Testing/05-Testing_for_OAuth_Weaknesses.md" %}

#### 05.1-Testing for OAuth server weaknesses

{% embed url="https://github.com/OWASP/wstg/blob/master/document/4-Web_Application_Security_Testing/05-Authorization_Testing/05.1-Testing_for_OAuth_Authorization_Server_Weaknesses.md" %}

#### 05.2-Testing for OAuth client weaknesses

{% embed url="https://github.com/OWASP/wstg/blob/master/document/4-Web_Application_Security_Testing/05-Authorization_Testing/05.2-Testing_for_OAuth_Client_Weaknesses.md" %}
