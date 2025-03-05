---
description: >-
  This challenge deals with a Server-Side Request Forgery (SSRF) vulnerability
  that is present in the server query parameter.
---

# OWASP Top 10 - 2021 (task 22)

_**Extra practice challenge: "Going the extra mile"**_

> There's a way to use SSRF to gain access to the site's admin area. Can you find it?

A **GET** request is sent to the following href to download the resume:

`/download?server=secure-file-storage.com:8087&id=75482342`

General format of the HTTP URL:

`http://<url>:8087/download?server=<server_addr>&id=<file_id>`



### Enumeration

1. Visiting the following URL [http://10.10.106.252:8087/admin](http://10.10.106.252:8087/admin) (GET request), presented me with a webpage displaying the following message:&#x20;

_<mark style="color:red;">Admin interface only available from localhost!!!</mark>_

This tells us that the admin page can only be accessed from within the machine itself. The goal now will be to find a SSRF vulnerability to redirect the request to the localhost admin URL instead.

2. I have noticed that an error messages with snippets of the code-base (sensitive information) is shown when a non-integer value is provided to the `id` query parameter via a GET request.&#x20;

For example, when the value `t` is provided, the following info and code snippet is shown in the error message.&#x20;

A GET request to `http://<url>:8087/download?server=&id=t` gives the following error details:

_<mark style="color:red;">ValueError: invalid literal for int() with base 10: 't'</mark>_

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

The placeholder `<url>`will be used as a general value. As detailed from part 1 in the _**Enumeration**_ section, the goal will be to redirect the **GET** request to the localhost admin page at port 8087 - placeholder value should be replaced with `localhost:8087/admin`. &#x20;

1. Null terminator/byte (`%00`)

`http://<url>:8087/download?server=<url>%00&id=1`

The input to the _**id**_ parameter will be a random integer value. While the value to the _**server**_ query parameter will be the target URL with the `%00` character at the end. The goal is to forcefully terminate the string value, to have the server ignore the part after the input.

`<url>%00/public-docs-k057230990384293/<filename>` _**->**_ `<url>`

However, this method does not work, and produces the following error message:

_<mark style="color:red;">ValueError: embedded null byte</mark>_



2. `?` (query symbol) (<mark style="color:green;">**✔ Working method**</mark>)

Inserting a ? character at the end of the server query parameter value will trick the server to treat the rest of the input (`'/public-docs-k057230990384293/' + filename`) as a query. Thus, effectively ignoring its values, allowing an attacker to fully control the server address.

A **GET** request to the following payload allows us to send a request to the **/admin** path from within the server localhost, bypassing the restriction&#x73;**.**

`http://<target_url>:8087/download?server=localhost:8087/admin?&id=1`

This forged request allows us to view the content of the admin page.



3. `#`(URI fragment) (<mark style="color:green;">**✔ Working method**</mark>)

{% embed url="https://developer.mozilla.org/en-US/docs/Web/URI/Reference/Fragment" %}

{% embed url="https://support.google.com/richmedia/answer/190941?hl=en" %}

Similar to the query symbol, inserting an URI fragment symbol (`#`) at the end of the server query parameter value will trick the server to treat the rest of the input as a fragment.

First attempt of payload:

`http://<target_url>:8087/download?server=localhost:8087/admin#&id=1`

_\*\*Tested on Google Chrome and Firefox_

Some browsers may remove the section after the hash symbol (`#`):

`.../.../admin#&id=1` **->** `.../.../admin`

The final URL causes the id query parameter to be removed, which gives the following error:

`No file selected...`

A fix will be to encode the hash symbol (`%23`):

`.../.../admin%23&id=1` **->** `.../.../admin#&id=1`

Hence, the final **GET** request URL is:

`http://<target_url>:8087/download?server=localhost:8087/admin%23&id=1`



3. `@`, `%2F`, `//`

