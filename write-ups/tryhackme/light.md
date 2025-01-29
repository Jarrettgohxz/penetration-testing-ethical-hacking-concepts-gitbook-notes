# Light

```bash
#!/usr/bin/bash

filename="/usr/share/wordlists/seclists/Usernames/top-usernames-shortlist.txt"

while IFS="" read -r line; do
	res=$(echo "$line" | nc -w 1 10.10.231.206 1337)

	if [[ "$res" == *"not found"* ]]; then
		...
	else
		...
	fi;

done < "$filename"

#echo smokey | nc 10.10.231.206 1337
```
