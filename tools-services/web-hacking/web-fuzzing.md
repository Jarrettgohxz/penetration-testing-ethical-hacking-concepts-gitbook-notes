---
description: >-
  Compilation of all the tools I have worked and experimented with for web
  fuzzing.
---

# Web fuzzing

## ffuf

**Basic command with common flags:**

```bash
$ ffuf -w <path_to_wordlist> -u <http_url_with_fuzz_keyword> -X <http_method>

# eg.
$ ffuf -w ~/wordlists/wordlist.txt -u http://domain.com/FUZZ -X POST
```

_**Flags**_

`-w`: Path to word-list

* Multiple word-list values:

```bash
# eg. with multiple -w flags
$ ffuf -w <path_to_wordlist_1>:FUZZ1 -w <path_to_wordlist_2>:FUZZ2 -d "key1=FUZZ1&key2=FUZZ2"

# eg. with a single -w flag
$ ffuf -w <path_to_wordlist_1>:FUZZ1,<path_to_wordlist_2>:FUZZ2 -d "key1=FUZZ1&key2=FUZZ2"
```

**Note:** The placeholder values for each line in the word-list must be capital letters.

`-u`: HTTP URL

`-X`: HTTP method, default value is **GET**

The _**`FUZZ`**_ keyword will be inserted with values from the word-list during the fuzzing process (refer to basic command example above).

There are multiple other use cases where th&#x65;_**`FUZZ`**_&#x6B;eyword can be utilized to fuzz different input values such as headers, request data, etc. Refer to the various sub-sections under the **WEB EXPLOITATION** section for more examples.

#### Other useful flags

* `-mr`: Match regexp
* `-d`: Specifies the data to send
* `-H`: Specifies the headers to send
* `-fw`,`-fr`, `-fl,` ... : Filter options
* `-r`: To follow redirects
* `-recursion`: Scan recursively
* `-recursion-depth`: Recursion depth

{% embed url="https://github.com/ffuf/ffuf" %}

## gobuster

Gobuster provides a vast amount of available commands as follows:

* _`completion`_ Generate the autocompletion script for the specified shell
* _`dir`_ Uses directory/file enumeration mode
* _`dns`_ Uses DNS subdomain enumeration mode
* _`fuzz`_ Uses fuzzing mode. Replaces the keyword FUZZ in the URL, Headers and the request body
* _`gcs`_ Uses gcs bucket enumeration mode&#x20;
* _`help`_ Help about any command
* _`s3`_ Uses aws bucket enumeration mode&#x20;
* _`tftp`_ Uses TFTP enumeration mode&#x20;
* _`version`_ shows the current version
* _`s3`_ Uses aws bucket enumeration mode tftp Uses TFTP enumeration mode version shows the current version

### Usage

To view the help menu for each of the command, simply enter the command name with the `--help` flag.  Eg. _`fuzz`_ command:

```bash
$ gobuster fuzz --help 

Flags:
  ...
```

{% embed url="https://github.com/OJ/gobuster" %}

## wfuzz

wfuzz is a web fuzzer that works similarly to _**ffuf**_ in that it uses th&#x65;_**`FUZZ`**_&#x6B;eyword to replace with the payload.

> **Below shows an example of wfuzz looking for common directories:**

```bash
$ wfuzz -w wordlist/general/common.txt http://testphp.vulnweb.com/FUZZ
```

{% embed url="https://wfuzz.readthedocs.io/en/latest/user/basicusage.html#fuzzing-paths-and-files" %}
wfuzz documentation
{% endembed %}

### Useful wordlist

wfuzz comes with a bunch of useful wordlist for various types of testing. This can be found from the _**`/usr/share/wfuzz/wordlist`**_ directory on <mark style="color:blue;">Kali Linux</mark>.

{% embed url="https://github.com/xmendez/wfuzz" %}
