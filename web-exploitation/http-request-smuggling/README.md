# HTTP Request Smuggling

HTTP Request Smuggling is a vulnerability that occurs due to the mismatch in how different servers interprets the boundaries of a HTTP request. The headers involved in this attack are the `Content-Length` and `Transfer-Encoding` headers.

### Exploring the components of a modern web application

There may be multiple servers involved for a single HTTP request to a web server (`GET`, `POST`, etc.):

1. Front-end server that forwards request to the back-end server
   * reverse proxy
   * load balancer
2. Back-end server that processes the request and communicates with other components:
   * Database
   * Other services
