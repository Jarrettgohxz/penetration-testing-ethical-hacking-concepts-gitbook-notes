# OAuth weaknesses

### General OAuth flow

_**Common terms:**_&#x20;

* AS -> Authorization Server



1. A user performs an action to start an OAuth process on a client application
2. The application redirects the user to an authorization server (AS) with the following parameters
   * `response_type` (eg. code)
   * `state`: CSRF token&#x20;
   * `client_id`: uniquely identifies the client application
   * `redirect_uri`: the URL that AS will redirect the user
   * `scope`: level of access requested
3.

### OWASP WSTG-ATHZ-05

#### 05 Testing for OAuth weaknesses

{% embed url="https://github.com/OWASP/wstg/blob/master/document/4-Web_Application_Security_Testing/05-Authorization_Testing/05-Testing_for_OAuth_Weaknesses.md" %}

#### 05.1-Testing for OAuth server weaknesses

{% embed url="https://github.com/OWASP/wstg/blob/master/document/4-Web_Application_Security_Testing/05-Authorization_Testing/05.1-Testing_for_OAuth_Authorization_Server_Weaknesses.md" %}

#### 05.2-Testing for OAuth client weaknesses

{% embed url="https://github.com/OWASP/wstg/blob/master/document/4-Web_Application_Security_Testing/05-Authorization_Testing/05.2-Testing_for_OAuth_Client_Weaknesses.md" %}
