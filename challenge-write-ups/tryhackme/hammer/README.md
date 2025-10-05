# Hammer

{% embed url="https://tryhackme.com/room/hammer" %}

**Check out the Medium blog post here:**

{% embed url="https://medium.com/@jarrettgoh.xz/tryhackme-hammer-walkthrough-bypassing-rate-limit-exploiting-jwt-b62bd36de716" %}

## Overview

This challenge room presents an interesting mix of issues such as information exposed within the source code, and vulnerabilities with authentication mechanisms.

> SPOILERT ALERT: the list below displays an overview of the vulnerabilities.&#x20;

The following is an outline of the vulnerabilities presented in this CTF:

1. &#x20;Information exposure in source code
2. Vulnerable rate limiting logic
3. Vulnerable JWT implementation



## **Trying to access port 80**

* failed, port 80 not open

## **Using nmap to discover web application port**

```bash
$ nmap <target> -p- -v
...
port 1137
...
```

* found port 1337 (labelled as waste, but is actually running  a HTTP web server)

## **Initial view**

#### Login page

Upon visiting the base URL (`/`), I was presented with a login page. Below the form, there is a link to a reset password page that accepts an email address. It appears that we have to find an email address that is used in the application.

