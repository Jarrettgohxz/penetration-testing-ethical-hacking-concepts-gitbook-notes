# Reconnaissance/Enumeration

{% stepper %}
{% step %}
### Basic manual enumeration

#### 1. Source code review

* Look for any leaked information: usernames, passwords, credentials, etc.

#### 2. HTTP traffic inspection (BurpSuite)

* Intercept all HTTP traffic with BurpSuite
* Inspect the traffic and look for any interesting values:
  * HTTP request/response headers (`Server` , `X-xxx` , etc.)
  * Query parameter
  * Request data
* **Target -> Sitemap**


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




{% endstep %}

{% step %}
### Vulnerability scanning

nikto, ZAP, etc.


{% endstep %}

{% step %}
### Additional enumeration

The following additional enumeration can be performed in the event that we are unable to find any useful information from the first few steps.

paramspider, arjun, katana, etc. and any other open source web pentesting tools...


{% endstep %}
{% endstepper %}
