# Force power-off (hard)

Suppose we are in a situation where we are unable to power-off the machine (default soft power-off) directly from the GUI due to any form of errors. We can perform a series of manual steps instead.

1. Stop the daemon

```bash
$ sudo /etc/init.d/vmware stop
# or
$ sudo systemctl stop vmware
```

2. Modify `.vmx` file

* There will only typically be only a single `.vmx` file present, named as `<name-of-guest-machine>.vmx`&#x20;

```bash
$ vim <name-of-guest-machine>.vmx
...
checkpoint.vmState = ""
snapshot.action = ""
scsi0:0.fileName = "<name-of-guest-machine>.vmdk"
...
```

3. Remove state, lock and metadata files

```bash
$ cd /path/to/vm
rm -r *.vmsn *.vmss *.vmem *.lck *.vmsd
```

4. Restart vmware services

```bash
$ sudo /etc/init.d/vmware start
# or
$ sudo systemctl start vmware 
```



