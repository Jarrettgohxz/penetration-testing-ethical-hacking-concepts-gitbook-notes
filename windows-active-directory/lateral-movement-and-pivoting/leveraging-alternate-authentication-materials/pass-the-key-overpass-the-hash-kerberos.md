# Pass-the-Key/Overpass-the-Hash (Kerberos)

### Pass-the-Key (PtK)

This method works similar to the Pass-the-Hash attack used with NTLM, but applied to Kerberos instead.

In the [Kerberos](https://jarrettgxz-sec.gitbook.io/windows/active-directory-ad/authentication-methods/kerberos) authentication process, when a user requests for a **TGT**, they will send a timestamp encrypted with an encryption key derived from their password.&#x20;

This attack aims to retrieve this key from memory using `mimikatz`, before using it to request a **TGT** without requiring the actual password - hence the name **Pass-the-Key** (PtK). This works because we can now use the stolen encryption key to craft a timestamp to forge a new request.

The following shows how we can use `mimikatz` to obtain the Kerberos encryption keys:

```
mimikatz # privilege::debug
mimikatz # sekurlsa::ekeys
```

We can use the keys we have obtained to perform a Pass-the-Key attack using the `sekurlsa::pth` module:

{% code overflow="wrap" %}
```
mimikatz # sekurlsa::pth /user:<username> /domain:<domain> /<hash-type>:xxxx /run:"<payload>"
```
{% endcode %}

Replace the `<hash-type>` option with following values according to what's available:

a. `rc4`&#x20;

b. `aes128`

c. `aes256`&#x20;

{% embed url="https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/windows-active-directory/tools/mimikatz/sekurlsa-pth" %}

### Overpass-the-Hash (OPtH)

Notice that when using the `rc4` hash type, the key is equal to the NTLM hash of a user. This means if we have obtained the NTLM hash, we can use it to request a TGT as long as `rc4` is one of the enabled protocols. This particular variant of attack is known as _**Overpass-the-Hash**_ (**OPtH**).



