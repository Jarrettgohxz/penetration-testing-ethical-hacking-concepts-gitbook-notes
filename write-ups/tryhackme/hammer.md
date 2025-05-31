# Hammer

{% embed url="https://tryhackme.com/room/hammer" %}

## **Trying to access port 80**

* failed, port 80 not open

## **Using nmap to discover web application port**

```bash
$ nmap <target> -p- -v
...
port 1137
...
```

* found port 1337 (labelled as waste, but is actually running  a HTTP web server)

## **Initial view**

Upon visiting the base URL (`/`), I was presented with a login page.

...







