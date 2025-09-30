# Registry Hives

We can utilize the Windows registry to harvest information. The following command examples can be used to query the registry for the _password_ keyword:

```powershell
reg query HKLM /f <search_pattern> /t REG_SZ /s
reg query HKU /f <search_pattern> /t REG_SZ /s
```

a. `HKM`, `HKU`: These values refers to the _keyname_ option which must be specified

* `HKLM`: **HKEY\_LOCAL\_MACHINE** key which contains configuration information particular to the computer (for any user)
* &#x20;`HKU`: **HKEY\_USERS** key which contains all the actively loaded user profiles on the computer

> Since we did not specify a remote machine (`\\<computername>\` ), the operation will default to the local computer

b. `/f` : Specifies the data or pattern to search for

c. `/t` : Specifies registry types to search. Valid types are: **REG\_SZ**, **REG\_MULTI\_SZ**, etc.

* In ourcase, we specify it as **REG\_SZ**, which is simply a fixed-length text string

d. `/s` : Specifies to query all subkeys and value names recursively



### Example

The Windows registry may store a copy of some of the SAM database contents to be used by Windows services. We can use the `reg.exe` tool to save the values from the registry. The following command can be used to extract the files required to decrypt the SAM database's content, namely the `HKLM\SAM` and `HKLM\SYSTEM` registries:

{% code title="Administrator shell" overflow="wrap" %}
```
C:\> reg.exe save HKLM\SAM C:\users\Administrator\Desktop\sam-reg
C:\> reg.exe save HKLM\system C:\users\Administrator\Desktop\system-reg
```
{% endcode %}

We can now use the [Impacket ](https://www.kali.org/tools/impacket/#impacket-secretsdump)`secretsdump.py` script to decrypt the SAM database content:

{% code title="Attacker machine " %}
```powershell
$ impacket-secretsdump -sam <SAM_file_location> -system <system_file_location> LOCAL
```
{% endcode %}

* `-sam` : SAM hive to parse
* `-system` : SYSTEM hive to parse
* `LOCAL` : To parse local files



