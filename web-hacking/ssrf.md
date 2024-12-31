---
description: >-
  Server Side Request Forgery (SSRF) is a form of attack that allows an attacker
  to trick a webserver in performing requests to make unintended HTTP requests
  to a resource of the attacker's choice.
---

# SSRF

## Common endpoints to access

1. `169.254.169.254`: A special IP in cloud environments to retrieve user data and instance metadata related to the current instance
2. `localhost`, `127.0.0.1`, `0.0.0.0`, etc.

## Bypass access/deny list filtering

### Bypass access list filtering

White (access) list filtering is a method to control outgoing requests, by denying all requests unless a certain condition is met.

#### 1. Self hosted domain

&#x20;For example, a certain access list requires the requested HTTP URL to begin with a certain value , such as: `domain.com`. This means that only requests to valid URLs such as `http://domain.com/api`will be accepted, while requests to URLs such as: `http://malicious.com` will not.&#x20;

However, this can be bypassed by hosting a DNS server to resolve a malicious domain with the required starting value, such as: `http://domain.com.malicious.com`. In this case, the value: `domain.com` is the subdomain of the root domain: `malicious.com`, which is controlled by the attacker. Since the domain starts with the required value of `domain.com`, it will be accepted.

### Bypass deny list filtering

Black (deny) list filtering is a method to control outgoing requests, by denying all requests that matches a certain condition.

#### 1. Alternate IP address representation

Some servers may deny access to a list of IP addresses that may contain sensitive information. This includes localhost, or other special addresses (refer to _**common endpoints to access**_ above).

However, the deny list may only contain the common representations of the specified addresses such as the dotted decimal representations (`127.0.0.1,` `169.254.169.254),` or `localhost` for the localhost. This can be bypassed by using the alternate representations for the IP addresses:

1. _**localhost**_: `0`, `0.0.0.0`, `0000` (default route), `127.1` (shortened dot-notation), `2130706433` (decimal-base10), `017700000001`(octal-base8)`, 0x7f000001`(hex-base16)
2. _**169.254.169.254**_:`2852039166`(decimal-base10),`25177524776`(octal-base8), `0xa9fea9fe`(hex-base16)

<mark style="color:green;">**Proof of concept**</mark>

**Try to ping the following addresses listed above:**

```bash
# localhost addresses
$ ping 0
$ ping 127.1
$ ping 2130706433
$ ping 017700000001
$ ping 0x7f000001

# "special" address
$ ping 2852039166
$ ping 25177524776
$ ping 0xa9fea9fe
```

#### 2. Malicious DNS resolution

Hosting a DNS server to resolve controlled subdomains to a specified IP address value will be another method to bypass IP address restrictions.&#x20;

For example a certain deny list includes the localhost addresses. An attacker controlled domain: `https://localhost.malicious.com` can be created to resolve to the localhost address of 1`27.0.0.1.` However, since this particular domain was not specified in the deny list, the request will be sent, and eventually resolved to the localhost address, completely bypassing the deny list.

This method can be used to bypass IP address restrictions for other addresses besides the localhost, by changing the IP address value in the DNS server.
