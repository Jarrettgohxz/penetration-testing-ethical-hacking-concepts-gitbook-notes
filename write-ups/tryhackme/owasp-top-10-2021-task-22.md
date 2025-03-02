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



1. Visiting the following URL [http://10.10.106.252:8087/admin](http://10.10.106.252:8087/admin) (GET request), presented me with a webpage displaying the following message:&#x20;

`Admin interface only available from localhost!!!`

This tells us that the admin page can only be accessed from within the machine itself. The goal now will be to find a SSRF vulnerability to redirect the request to the localhost admin URL instead.

2. I have noticed that an error messages with snippets of the code-base (sensitive information) is shown when a non-integer value is provided to the `id` query parameter via a GET request.&#x20;

For example, when the value `t` is provided, the following info and code snippet is shown in the error message.&#x20;

_**GET http://\<url>:8087/download?server=\&id=t**_

`ValueError: invalid literal for int() with base 10: 't'`

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

From the code snippet in the error message, I have discovered that the final HTTP URL where the request is being sent is generated in the following format:

```python
server + '/public-docs-k057230990384293/' + filename
```

Where the `server` query parameter is taken directly from the _**server**_ query parameter value. The _**id**_ query parameter value is used directly to generate the final URL value, however, it does not have a direct exploitable impact. This tells us that we can potentially control the final URL where the GET request is being sent.

Thus, the goal is to craft a payload to the _**server**_ query parameter to forge a request to the localhost admin URL: `http://localhost:8087/admin` - allowing us to retrieve the admin page content.

### Payload to the `server` query parameter

The placeholder `<url>`will be used as a general value - it should be replaced `with localhost:8087/admin`.

1. Null terminator/byte (`%00`)

`http://<url>:8087/download?server=<url>%00&id=1`

The input to the _**id**_ parameter will be a random integer value. While the value to the _**server**_ query parameter will be the target URL with the `%00` character at the end. The goal is to forcefully terminate the string value, to have the server ignore the part after the input.

`<url>%00/public-docs-k057230990384293/<filename>` _**->**_ `<url>`

2. `?` (query symbol)

Inserting a ? character at the end of the value passed to the server query parameter will trick the server to treat the rest of the input (`'/public-docs-k057230990384293/' + filename`) as a query. Thus, effectively ignoring its values, allowing an attacker to fully control the server address.

The following payload allows us to send a request to the **/admin** path from within the server localhost, bypassing the restriction&#x73;**.**

`10.10.106.252:8087/download?server=localhost:8087/admin?&id=1`



3. `#`
4. `@`, `%2F`, `//`

