# Reconnaissance/Enumeration

{% stepper %}
{% step %}
### Basic manual enumeration

### 1. Source code review

* Look for any leaked information: usernames, passwords, credentials, etc.

### 2. API inspection (BurpSuite)

#### **2.1 Intercept all HTTP traffic with BurpSuite**

* Walk-through the website manually
  * **Target -> Sitemap** to view the generated sitemap

#### **2.2 Inspect the traffic and look for any interesting values that can be injected or manipulated**&#x20;

a. HTTP request/response headers

* `Server` , `X-Powered-By`: leak of server technology and version
* Other `X-xxx` type headers

b. Query parameter

c. Request data


{% endstep %}

{% step %}
### Directory/subdomain enumeration

1. `dirsearch`&#x20;

```
$
```

2. `gobuster`/`ffuf`/`wfuzz`&#x20;

```
$
```

#### Interesting directories

{% embed url="https://github.com/OWASP/wstg/blob/master/document/4-Web_Application_Security_Testing/01-Information_Gathering/03-Review_Webserver_Metafiles_for_Information_Leakage.md" %}

1. `robots.txt`&#x20;
2. `sitemap.xml`&#x20;
3.

...


{% endstep %}

{% step %}
### Automated vulnerability scanning

nikto, ZAP, etc.


{% endstep %}

{% step %}
### Additional enumeration

The following additional enumeration can be performed in the event that we are unable to find any useful information from the first few steps.

paramspider, arjun, katana, etc. and any other open source automated web pentesting tools...


{% endstep %}
{% endstepper %}
