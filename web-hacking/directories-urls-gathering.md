---
description: getallurls/gau, hawkrawler, gobuster, wfuzz, dirb, dirbuster, ffuf
---

# Directories/URLs gathering

## Common web directories to recon:

1. Robots.txt
2. Sitemap.xml

## Burp suite target -> site map

The Burp Suite _**Site map**_ feature found under the _**Target**_ tab provides an overview of the directories found by Burp, that is gathered as the web app is explored, and with additional crawling.

## getallurls/gau

The package `getallurls`installed directly in Kali Linux with `apt install`seems to have some issue.&#x20;

The `gau` binary  can be installed from the installation step listed in the Github link below instead:

1. Determine the current system architecture (Linux)

```bash
$ uname -a
$ arch
$ cat /proc/version
... aarch64
... x86_64
```

Since I am running my Kali on a Raspberry pi in this case, the commands above will display `aarch64`, which is ARM-64.

2. Download the apprioprate gau binary `.tar.gz` file. In my case, it will be labelled as `gau_2.2.4_linux_arm64.tar.gz`.
3. Extract the files, and move the binary file to another location. Depending on your system, the default binary path may defer. In this example, I'll assume its `/usr/bin`.

```bash
$ mktemp -d # create temp dir
$ cd ... # change dir to temp dir
 
$ tar xvf gau_2.2.4_linux_arm64.tar.gz
LICENSE
README
gau

$ file gau
/usr/bin/gau: ELF 64-bit LSB executable, ARM aarch64, ...
$ mv gau /usr/bin/gau
$ which gau
/usr/bin/gau
```

#### Basic commands:

```bash
# Basic 
$ echo <domain> | gau
$ gau <domain> 

$ gau <domain> --verbose # show verbose output

# eg.
$ gau vulnweb.com --verbose
```

{% embed url="https://github.com/lc/gau" %}

## hakrawler

```bash
$ echo <HTTP_URL> | hakrawler
$ echo <HTTP_URL> | hakrawler -subs # include subdomains

# eg. 
$ echo https://domain.com | hakrawler 
$ echo https://domain.com | hakrawler -subs
```

{% embed url="https://github.com/hakluke/hakrawler" %}

## ffuf

{% embed url="https://www.kali.org/tools/ffuf/" %}

Ffuf is a fast web fuzzer for directory discovery. The term _**fuzzing**_ refers to the act of sending random data to applications (URLs in this case), to discover content that would not have been discovered otherwise.

**Basic command:**

<pre class="language-bash"><code class="lang-bash"><strong>$ ffuf -w &#x3C;path_to_wordlist> -u &#x3C;http_url>/FUZZ
</strong></code></pre>

**Flags**

`-w:` Path to wordlist&#x20;

`-u`: HTTP/HTTPS endpoint URL to fuzz



The _**`FUZZ`**_ keyword in the URL supplied to the `-u` flag will be replaced by each word given in the wordist.

### Example

Suppose there is a target at the HTTP address _**http://88.88.88.88**_ to be fuzzed: with the wordlist in the _**\~/wordlists/common.txt**_ directory containing common directory values.

```bash
$ ffuf -w ~/wordlists/common.txt -u http://88.88.88.88/FUZZ

        /'___\  /'___\           /'___\       
       /\ \__/ /\ \__/  __  __  /\ \__/       
       \ \ ,__\\ \ ,__\/\ \/\ \ \ \ ,__\      
        \ \ \_/ \ \ \_/\ \ \_\ \ \ \ \_/      
         \ \_\   \ \_\  \ \____/  \ \_\       
          \/_/    \/_/   \/___/    \/_/       

  ...
________________________________________________

 :: Method           : GET
 :: URL              : http://88.88.88.88/FUZZ
 :: Wordlist         : FUZZ: ~/wordlists/common.txt
 ...
 ...
________________________________________________

assets                  [Status: 301, ...]
robots.txt                 [Status: 200, ...]

:: Progress: [xxx/xxx] :...

```

The output shows that the directories: _**assets**_ and _**robots.txt**_, returned a valid status code, indicating that there are contents present.

## dirb

{% embed url="https://www.kali.org/tools/dirb/" %}
dirb tool
{% endembed %}

"DIRB is a Web Content Scanner. It looks for existing (and/or hidden) Web Objects. It basically works by launching a dictionary based attack against a web server and analyzing the responses."&#x20;

**Basic command:**

```bash
$ dirb <http_url> <path_to_wordlist>
```

### Example

Scan the URL _**http://88.88.88.88/**_ with the wordlist provided.

```bash
$ dirb http://88.88.88.88/ ~/wordlists/common.txt

-----------------
DIRB ...    
By The Dark Raver
-----------------

...
URL_BASE: http://88.88.88.88/
WORDLIST_FILES: ~/wordlists/common.txt

-----------------

GENERATED WORDS: ...                                                          

---- Scanning URL: http://88.88.88.88/ ----
...  
...
```

## gobuster

{% embed url="https://www.kali.org/tools/gobuster/" %}

"Gobuster is a tool used to brute-force: URIs (directories and files) in web sites, DNS subdomains (with wildcard support), Virtual Host names on target web servers, ..."

**Basic command:**

```bash
$ gobuster dir --url <http_url> -w <path_to_wordlist>
```

**Flags**

`dir`: Uses directory/file enumeration mode

`--url:` HTTP/HTTPS endpoint URL to brute-force

`-w`: Path to wordlist

### Example

To brute-force the HTTP URL _**http://88.88.88.88/**_ with the wordlist _**\~/wordlists/common.txt**_

<pre class="language-bash"><code class="lang-bash"><strong>$ gobuster dir --url http://88.88.88.88/ -w common.txt
</strong><strong>
</strong>===============================================================
Gobuster v3.6
by OJ Reeves (@TheColonial) &#x26; Christian Mehlmauer (@firefart)
===============================================================
[+] Url:                     http://88.88.88.88/
[+] Method:                  GET
..
[+] Wordlist:                ~/wordlists/common.txt
...
===============================================================
Starting gobuster in directory enumeration mode
===============================================================
/assets               (Status: 301) ...
/robots.txt              (Status: 200) ...

Progress: xxx/xxx (99.98%)
===============================================================
Finished
===============================================================

</code></pre>

The output shows that the directories: _**assets**_ and _**robots.txt**_, returned a valid status code, indicating that there are contents present.

{% embed url="https://docs.google.com/document/d/1r7l_Idd-C13G6aWO6grdbyx5NkqBiANi3cOOZqf06sg/edit" %}
Pentesting steps
{% endembed %}

{% embed url="https://docs.google.com/document/d/1LLC8hHAKBBRtnVGkW1Bcaf1k_1lSQ1T5h_g8xUL8Gw4/edit" %}
List of tools
{% endembed %}
