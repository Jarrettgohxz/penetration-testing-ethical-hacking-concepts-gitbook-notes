# Brute forcing 4-digit code





&#x20;

1. Automatic logout (`/reset_password.php`): GET `/logout.php`

<figure><img src="../../../.gitbook/assets/image (28).png" alt=""><figcaption></figcaption></figure>

**Response**

Set-Cookie to `PHPSESSID=deleted`.

<figure><img src="../../../.gitbook/assets/image (29).png" alt=""><figcaption><p>RESPONSE</p></figcaption></figure>

2. From the `Location` header defined in the previous response, send a GET request to `/index.php` with no cookies set.

`GET /index.php HTTP/1.1` (without cookie)&#x20;

<figure><img src="../../../.gitbook/assets/image (26).png" alt=""><figcaption><p>REQUEST</p></figcaption></figure>

**Response**

New `PHPSESSID` in the Set-Cookie

* Retrieve `PHPSESSID: mgj0vc1q4908nel9i695d3mvj8`&#x20;
* This value will be sent as a cookie in the subsequent requests

<figure><img src="../../../.gitbook/assets/image (31).png" alt=""><figcaption></figcaption></figure>

3. Enter email in the **Reset Password** page

POST `/reset_password.php` (email=tester%40hammer.thm)

> NOTE: this request must be performed before attempting to POST the recovery code (see next step)&#x20;

<figure><img src="../../../.gitbook/assets/image (2).png" alt=""><figcaption></figcaption></figure>

**Response**

<figure><img src="../../../.gitbook/assets/image (3).png" alt=""><figcaption></figcaption></figure>

A `GET /reset_password.php` request will be sent.&#x20;

<figure><img src="../../../.gitbook/assets/image (25).png" alt=""><figcaption></figcaption></figure>

If the cookie is valid (not expired), we will be presented with a form to enter the 4-digit recovery code.

<figure><img src="../../../.gitbook/assets/image (5).png" alt=""><figcaption></figcaption></figure>

4. POST recovery code

<figure><img src="../../../.gitbook/assets/image (4).png" alt=""><figcaption></figcaption></figure>

**Response**

If we send an expired cookie, we will get the following response:

<figure><img src="../../../.gitbook/assets/image (30).png" alt=""><figcaption></figcaption></figure>

If the cookie is not expired, we will be able to send our recovery code. The image below shows the display for an invalid recovery code.

<figure><img src="../../../.gitbook/assets/image (6).png" alt=""><figcaption></figcaption></figure>
