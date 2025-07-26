# Request Smuggling

### 1. `Content-Length`&#x20;

{% embed url="https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Content-Length" %}

> The HTTP **`Content-Length`** header indicates the size, in bytes, of the message body sent to the recipient.

In the context of the [HTTP Request Smuggling](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/web-application-penetration-testing/http-request-smuggling) attack, a certain behavior of the `Content-Length`  header can be exploited. This can happen when a value larger than the actual supplied body content is used as the value, resulting in the server to pause and wait for the rest of the content to arrive.

### 2. `Transfer-Encoding`

{% embed url="https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Transfer-Encoding" %}

The possible values are:

1. `deflate`, `gzip`, `compress`
2. `chunked`&#x20;

In the context of the [HTTP Request Smuggling](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/web-application-penetration-testing/http-request-smuggling) attack, we will be focusing on the `chunked` value:

<pre class="language-http"><code class="lang-http"><strong>POST / HTTP/ 1.1 
</strong><strong>Host: ...
</strong><strong>Content-Type: application/x-www-form-urlencoded
</strong><strong>Transfer-Encoding: chunked
</strong><strong>
</strong><strong>aa
</strong><strong>actual data
</strong><strong>0
</strong><strong>
</strong></code></pre>

At the beginning of each chunk, a string of hex digits indicate the size of the chunk-data (eg. `aa`), followed by a carriage-return and newline character (CRLF: `\r\n`), the chunk-data itself, followed by another CRLF, and finally a terminating zero-length chunk.
