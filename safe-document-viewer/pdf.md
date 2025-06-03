# PDF

To safely view a PDF document, while preventing damage from exploitation of vulnerabilities or malware infection, we can use `firejail`.

> Firejail is a lightweight secuirty tool intended to protectd a Linux system by setting up a restricted environment for running (potentially untrusted) applications.

{% embed url="https://github.com/netblue30/firejail" %}

For the PDF document viewer, `mudpdf` will be a great option, due to it being lightweight and open-sourced.

{% embed url="https://github.com/ArtifexSoftware/mupdf" %}

`firejail` can be used to create a sandboxed environment for secure viewing of the PDF using `mupdf` :

```bash
$ firejail --net=none --caps.drop=all --nogroups --noroot --private=[pdf_dir] mupdf [pdf_to_view].pdf

# eg.
$ firejail --net=none --caps.drop=all --nogroups --noroot  --private=/home/user/sandbox mupdf view.pdf
```

**Flags**

* `--net=none`: Disables all network acccess, expect for a new loopback interface (`lo`).
* `--caps.drop=all`: Drop all capabilities for the processes running in the sandbox.
* `--nogroups` : Disable supplementary groups.
* `--noroot`: Install a user namespace with a single user - the current user. The root user does not exist in the new namespace.
* `--private=directory`: Use directory as user home. This should be the directory where the `.pdf` file is present.



### Reusable Bash function (`~/.bashrc`)

We can create a Bash function in \~/.bashrc that can be used as a simple command:

```bash
safeviewpdf() {
   local pdf_path="$1"
   
    if [ -z $pdf_path" ]; then
       echo "Usage: safepdf /absolute_path/to/file.pdf";
    
    elif [ ! -f "$pdf_path" ]; then
       echo "File not found" $pdf_path". Please provide the absolute path.";
    
    else
       firejail --net=none --private="$(dirname "$pdf_path")" --caps.drop=all --nogroups --noroot mupdf "$(basename "$pdf_path")";
       
}
```

{% embed url="https://man7.org/linux/man-pages/man1/firejail.1.html" %}
