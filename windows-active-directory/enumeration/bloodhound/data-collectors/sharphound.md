# Sharphound

{% embed url="https://bloodhound.specterops.io/collect-data/ce-collection/sharphound-flags" %}

#### Basic usage

```sh
sharphound.exe --CollectionMethods <methods> --Domain <domain> --ExcludeDCs
```

* `--CollectionMethods`: specifies the kind of data to collect. Usually, this value will be `All` .Refer to the link above for the full list of available options
* `--Domain`:  specifies which Active Directory domain to gather information from
* `--ExcludeDCs`: instruct SharpHound to not touch domain controllers. This can help in avoiding detection.

#### Using runas.exe

```sh
# spawn a cmd instance using a particular user's AD credentials
C:\> runas /netonly /user:<domain>\<username> cmd.exe

# from the spawned cmd 
$ ./sharphound.exe --domain xxxx ...
```
