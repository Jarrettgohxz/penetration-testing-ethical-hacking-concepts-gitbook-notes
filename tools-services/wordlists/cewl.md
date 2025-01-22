# cewl

CeWL (Custom Word List Generator) is a tool written in Ruby that spiders a given URL, up to a specified depth, and returns a word list which are suitable for password cracking tools such as John the Ripper.

#### Basic usage

```bash
$ cewl <URL> -w <file_to_save>
```

> Scan to a depth of 2 (`-d 2`) and use a minimum word length of 5 (`-m 5`), save the words to a file (`-w docswords.txt`), targeting the given URL (`https://example.com`):

```bash
$ cewl -d 2 -m 5 -w docswords.txt https://example.com
```





{% embed url="https://www.kali.org/tools/cewl/" %}
