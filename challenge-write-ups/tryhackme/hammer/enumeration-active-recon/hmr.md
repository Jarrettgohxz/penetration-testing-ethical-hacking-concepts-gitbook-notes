# /hmr

> The word lists used in this phase are from Daniel Miessler's seclist: [https://jarrettgxz-sec.gitbook.io/offensive-security-concepts/tools-services/wordlists](https://jarrettgxz-sec.gitbook.io/offensive-security-concepts/tools-services/wordlists).&#x20;
>
> The word list path shown in the examples below will be displayed as a redacted relative directory.

## Manual inspection of source code

From a manual inspection of the source code within burp suite, I found a comment:

<figure><img src="../../../../.gitbook/assets/image (22).png" alt=""><figcaption></figcaption></figure>

It appears that the directories in this application uses the `hmr_` prefix.

## Directory discovery

I proceeded to perform a directory fuzzing with the `hmr_` prefix:

```bash
$ ffuf -u http://<target.com>:1337/hmr_FUZZ -w .../Discovery/Web-Content/common.txt -mc 200,301,302
```

<figure><img src="../../../../.gitbook/assets/image (24).png" alt=""><figcaption></figcaption></figure>

I visited the `/hmr_css`, `/hmr_images` and `/hmr_js` directories, and was presented with an index listing, but found nothing of interest.

However, the `/hmr_logs` displayed an `error.logs` file.

<figure><img src="../../../../.gitbook/assets/image (21).png" alt=""><figcaption></figcaption></figure>

From the `error.logs` file, I found the email address: `tester@hammer.thm`. Very well, now lets use this email address on the reset password page.

<figure><img src="../../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

> Refer to the _**Brute forcing 4-digit code**_ section for the new step.
