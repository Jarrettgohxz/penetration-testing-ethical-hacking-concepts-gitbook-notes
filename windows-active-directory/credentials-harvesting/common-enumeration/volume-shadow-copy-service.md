# Volume Shadow Copy Service

### Resources

1. **Shadow copy creation tools**

a. VShadow

{% embed url="https://learn.microsoft.com/en-us/windows/win32/vss/vshadow-tool-and-sample" %}

b. Win32\_ShadowCopy Create method

{% embed url="https://learn.microsoft.com/en-us/previous-versions/windows/desktop/vsswmi/create-method-in-class-win32-shadowcopy" %}

c. vssadmin create shadow

{% embed url="https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc788055(v=ws.11)" %}

### Create shadow copy

> Refer to the resources links above for more client tools for shadow copy creation (\*\*not tested)

```powershell
C:\Users\Administrator> wmic shadowcopy call create Volume='C:\'
```

### List shadow copy

```powershell
C:\Users\Administrator> vssadmin list shadows
```

The output of the shadow copy volume (of `C:\` ) will be shown. We can now access the SAM and system registry files from the `windows\system32\config\sam` and `windows\system32\config\system` respectively.

Now that we have the extracted credentials from the SAM and system registry hives, we can use Impacket's secretsdump.py script to decrypt it. Refer to the example from [Registry Hives](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/windows-active-directory/credentials-harvesting/common-enumeration/registry-hives) section for more information.

