# Express app (port 4000)

Upon visiting the page, we are presented with a login page with a note to sign in as `guest:guest`.&#x20;

### Enumeration&#x20;

From inspection of the network requests with Burp suite, I discovered that the server uses _Express_ via the  `X-Powered-By` response headers. Express is a Node.js web framework used to develop web server applications ([https://expressjs.com/](https://expressjs.com/)).

<figure><img src="../../../.gitbook/assets/image (40).png" alt=""><figcaption></figcaption></figure>

Other requests sent includes a&#x20;
