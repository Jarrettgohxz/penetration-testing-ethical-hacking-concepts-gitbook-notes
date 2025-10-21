# Spring Boot (Java)

### Resources

{% embed url="https://medium.com/@shteenlo/sbscan-a-penetration-testing-tool-focused-on-the-spring-framework-45b1789fbb66" %}

{% embed url="https://blog.certcube.com/spring-boot-pentesting-fundamentals-part-1/" %}

{% embed url="https://cametom006.medium.com/how-i-found-and-bypassed-a-spring-boot-actuator-information-disclosure-bug-c4930b740a50" %}

{% embed url="https://medium.com/@kivir/what-i-learned-from-fuzzing-98-000-random-spring-boot-servers-for-aws-s3-keys-3a24faa38721" %}

{% embed url="https://blog.1nf1n1ty.team/hacktricks/network-services-pentesting/pentesting-web/spring-actuators" %}



### Enumeration

1. **Directory traversal**

{% embed url="https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/Programming-Language-Specific/Java-Spring-Boot.txt" %}

```sh
$ gobuster dir -u <target> -w spring-boot.txt
```

2. **Additional endpoints**

```
h2-console
...
```



### Vulnerabilities

Certain versions of nginx + spring boot are vulnerable to an ACL list bypass attack:

{% embed url="https://blog.1nf1n1ty.team/hacktricks/pentesting-web/proxy-waf-protections-bypass#spring-boot" %}

