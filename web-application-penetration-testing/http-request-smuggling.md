# HTTP Request Smuggling

HTTP Request Smuggling is a vulnerability that occurs due to the mismatch in how different servers handling a web request interprets the boundaries of a HTTP request. The headers involved in this attack are the `Content-Length` and `Transfer-Encoding` headers.

### Exploring the components of a modern web application

There may be multiple servers involved for a single request to a web server (`GET`, `POST`, etc.):

1. Front-end server that forwards request to the back-end server
   * reverse proxy
   * load balancer
2. Back-end server that processes the request and communicates with other components:
   * Database
   * Other services

### How can a HTTP Request Smuggling vulnerability occur?

The vulnerability arises when the servers involved in the request interprets the HTTP request boundaries differently. This can happen in the following scenarios;

1. Both the `Content-Length` and `Transfer-Encoding` headers are present
2. The front-end server prioritizes `Content-Length` , while the back-end prioritizes `Transfer-Encoding` , and vice versa
   * Indicated as _**CL.TE**_ and _**TE.CL**_ respectively&#x20;

Sometimes, _**TE.TE**_ can happen too, when both the front-end and back-end servers uses the `Transfer-Encoding` header. In this case, a certain technique can be used to workaround this.

For the attack to work, a duplicate `Transfer-Encoding`  header can be added with a malformed and invalid value such as:

```http
POST / HTTP/1.1
...
Transfer-Encoding chunked
Transfer-Encoding random-invalid-value

xx
...
0
```



### Basic example of an attack

Let's assume that the front-end server prioritizes  `Content-Length` while the back-end prioritizes `Transfer-Encoding` . A HTTP request can be crafted to exploit the HTTP Request Smuggling vulnerability:

```http
POST / HTTP/1.1
Host: ...
Content-Type: application/x-www-form-urlencoded
Content-Length: 140
Transfer-Encoding: chunked

0

POST /feedback HTTP/1.1
Host: ...
Content-Type: application/x-www-form-urlencoded
Content-Length: 500

name=test&query=<payload_position>
```

#### Front-end server

In the following payload, the front-end server will first interpret the boundaries based on the `Content-Length` header (value of **140**). This will interpret the entire request up to the end of the data body as a single request, and forward it to the back-end server.

#### Back-end server

The back-end server will interpret the boundaries based on the `Transfer-Encoding` header, and read the first&#x20;
