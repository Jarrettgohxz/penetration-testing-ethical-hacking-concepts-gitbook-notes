---
description: Methods to discover the subdomain of a root domain.
---

# Subdomain enumeration

## Certificate Transparency (CT) logs

{% embed url="https://crt.sh/" %}

## Google dorks

{% embed url="https://jarrettgxz-sec.gitbook.io/offensive-security/osint/google-dorks" %}

## dnsrecon

**Basic command:**

```bash
$ dnsrecon -t brt -d <domain>
```

**Flags**

&#x20;`-t:` **brt** - Brute force domains and hosts using a given dictionary

`-d` : Domain to brute-force

&#x20;

## sublist3r

sublist3r enumerates subdomains by utilizing many search engines such as Google, Yahoo, etc. and other services such as Netcraft, VirusTotal, etc.

**Basic command:**

```bash
$ sublist3r -d <domain>
```

**Flags**

`-d`: Domain to brute-force&#x20;

{% embed url="https://www.kali.org/tools/sublist3r/" %}

## ffuf

Ffuf can be utilized to fuzz the virtual hosts of an IP address. The HTTP Host header can be modified with different values to discover open virtual hosts.&#x20;

```bash
$ ffuf -w ~/wordlists/namelist.txt -H "Host: FUZZ.domain.com" -u <target_url>
```

**Flags**

`-w`:  Path to wordlist

`-H`: HTTP header to append to request

`-u`: Target URL

### fs flag

Some web server may return a default status code and content for multiple virtual host addresses. These addresses will return a valid response to ffuf, causing it to be picked up as an active host. This may pollute the results, as these hosts may not actually be a functioning service.

The `-fs` flag can be used to filter out response sizes (of a fixed and predictable value), to remove the invalid default responses.

```bash
$ ffuf ... -fs <response_size>
```

## amass

#### Basic command for subdomain enumeration:

```bash
$ amass enum -d <domain>
```

{% embed url="https://github.com/owasp-amass/amass" %}
