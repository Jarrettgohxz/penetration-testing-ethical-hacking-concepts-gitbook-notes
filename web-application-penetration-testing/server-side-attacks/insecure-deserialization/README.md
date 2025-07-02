# Insecure deserialization

> Serialization is the process of transforming an object's state into a human readable or binary format (or a mix of both) that can be stored or transmitted and recontstructed as and when required. This is essential for data transfer between different parts of a system or across the network - such as in web applications.

{% embed url="https://tryhackme.com/room/insecuredeserialisation" %}



For example in PHP using the `serialize()` function, we can convert the fields:

* `title` -> "My Note" and `content` -> Welcome to my note!

to a serialized format that looks like: `a:2:{s:5:"title";s:7:"My Note";s:7:"content";s:19:"Welcome to my note!";}`

### Black-box testing

1. **Access backup or temporary files**

* Append a tilde at the end of the filename (`~`)
* Can potentially leak information about serialization functions used



2. **Analyzing & manipulating request/response headers**

As serialized data are commonly base64-encoded in transmission, by observing the values used in the request/response headers, we can identify serialized data by looking for base64-encoded fields. Those fields can be base64-decoded to retrieve useful information regarding the serialized object or data structures. This can inform us of any potentially vulnerable fields that can be exploited.

Moreover, the fields in the request headers can be altered/modified to invoke unexpected behavior that can present useful information through error messages. For example, certain PHP warnings may indicate the deserialization function used such as `unserialize()` , or throw an error such as **Object deserialization error**, which will quickly inform us of the underlying serialization process and potential vulnerabilities.

The following presents response header fields that are commonly serialized:

a) ASP.NET view state: `__VIEWSTATE`&#x20;

b) Session cookies

