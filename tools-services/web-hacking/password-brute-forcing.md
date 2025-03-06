# Password brute-forcing

The tools discussed in the [Web Fuzzing](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking/tools-services/web-hacking/web-fuzzing) section can also be utilized for a web-based password brute-force attack.

### Example with ffuf (content-type application/json)

Suppose we want to brute-force a POST request to the URL: http://vuln-website.com/user/login. Assuming that this website retrieves the data in a [JSON](https://developer.mozilla.org/en-US/docs/Learn_web_development/Core/Scripting/JSON) format, with the fields: _username_ and _password_. The general format of the request will be:

<pre class="language-bash"><code class="lang-bash"><strong>$ ffuf -X POST -H "content-type:application/json" -d &#x3C;data> -w &#x3C;password_wordlist> -u http://vuln-website.com/user/login 
</strong></code></pre>

The `data` field can be replaced with the following:

<pre class="language-bash"><code class="lang-bash"><strong>
</strong><strong>$ ffuf ... -d "{\"username\":\"test\",\"password\":\"FUZZ\"}"
</strong><strong># OR
</strong><strong>$ ffuf ... -d '{"username":"test","password":"FUZZ"}'
</strong></code></pre>

**Note**: The escaping of the double quotes with `\` symbol in the first example, the use of single quotes in the second example, and the `FUZZ` keyword.

### Example with ffuf (content-type application/www-urlencoded)

