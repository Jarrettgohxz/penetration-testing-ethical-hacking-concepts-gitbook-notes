---
description: >-
  The Google search engine can be a powerful tool to discover open-source
  contents to aid in OSINT.
---

# Google dorks

## Site operator

Discover all subdomains of `domain.com`

<pre><code><strong>site:*domain.com
</strong></code></pre>

Exclude matches for `www.domain.com`

```markup
site:*domain.com -site:www.domain.com
```
