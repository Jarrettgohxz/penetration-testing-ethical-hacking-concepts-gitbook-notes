# Hydra

### General command

```bash
$ hydra -l username -P [path_to_wordlist] <host> <service>\

# eg. brute force login to FTP server with username "user" and password from rockyou.txt
$ hydra -l user -P /usr/share/wordlists/rockyou.txt 10.10.10.22 ftp
# OR
$ hydra -l user -P /usr/share/wordlists/rockyou.txt ftp://10.10.10.2
```

_**Additional flags**_

* `-s PORT` to specify a non-default port for the service in question.
* `-V` or `-vV`, for verbose output
* `-t n` where n is the number of parallel connections to the target. `-t 16` will create 16 (default) threads used to connect to the target.
* `-d`, for debugging

{% embed url="https://github.com/vanhauser-thc/thc-hydra" %}
